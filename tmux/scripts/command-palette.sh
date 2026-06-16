#!/usr/bin/env bash
#
# command-palette.sh — VSCode-style fuzzy palette over tmux key bindings.
#
# Lists every prefix-table binding that carries a note (-N), lets you
# fuzzy-search it by description in an fzf popup, and EXECUTES the chosen
# binding's command on Enter.
#
# Bound from tmux.conf:
#   bind-key ? display-popup -E -w 80% -h 70% '~/git/dotfiles/tmux/scripts/command-palette.sh'
#
# How execution works: tmux has no "invoke this binding" command, so we read
# the binding's command back from `list-keys`, strip the leading
# `bind-key -T prefix <key>` header, and hand the remainder to
# `tmux source-file`. Going through source-file (rather than `eval` in the
# shell) means tmux itself re-parses the command, so nested quotes survive
# intact.
#
# One wrinkle: tmux joins a binding's multiple commands with " \; ", which is
# a separator on the command line but NOT inside a sourced file (there each
# command must be its own line). So we split on that exact 4-char token into
# separate lines. It's safe to match literally because tmux renders any
# backslash *inside* a quoted string as "\\", so a lone " \; " only ever
# occurs as a top-level separator.

set -uo pipefail

command -v fzf >/dev/null 2>&1 || { echo "fzf not found on PATH"; sleep 1.5; exit 0; }

# Each line is "<key>   <note>"; fzf returns the whole line, so we keep the key
# visible (you learn the shortcut) and recover it afterwards.
sel=$(tmux list-keys -N -T prefix \
        | sort \
        | fzf --reverse --border \
              --prompt 'run> ' \
              --header 'fuzzy-search a command · Enter runs it · Esc cancels') || exit 0

[ -n "$sel" ] || exit 0

# First whitespace-separated field is the key (e.g. g, C-h, ?).
key=$(printf '%s\n' "$sel" | awk '{print $1}')
[ -n "$key" ] || exit 0

# Pull the full binding line and strip the fixed header to leave just the
# command, verbatim in tmux's own quoting.
full=$(tmux list-keys -T prefix "$key") || exit 0
header="bind-key -T prefix $key "
cmd=${full#"$header"}

# If the prefix didn't strip (unexpected format), bail rather than run garbage.
[ "$cmd" != "$full" ] || exit 0

# Turn top-level " \; " separators into newlines so source-file runs each
# command in turn (see header note on why this is safe). The separator is held
# in a variable and matched as a *quoted* pattern so the backslash is taken
# literally — an inline pattern gets mangled by bash's own backslash handling.
sep=' \; '
cmd=${cmd//"$sep"/$'\n'}

# Let tmux parse and run the command(s) via source-file.
tmpf=$(mktemp "${TMPDIR:-/tmp}/tmux-palette.XXXXXX") || exit 0
printf '%s\n' "$cmd" >"$tmpf"
tmux source-file "$tmpf"
rm -f "$tmpf"
