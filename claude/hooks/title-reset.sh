#!/usr/bin/env bash
set -eu

# On SessionEnd, reset the tmux pane title back to the hostname. Claude Code
# sets pane_title to the current task while running, but tmux never restores
# it when the process exits — so without this the last task would linger on
# the pane border. Resetting to the hostname makes the `pane_title == host`
# fallback in pane-border-format kick in (shows the running command instead).
[ -n "${TMUX:-}" ] || exit 0

tty=$(tmux display-message -p ${TMUX_PANE:+-t "$TMUX_PANE"} '#{pane_tty}' 2>/dev/null || true)
[ -n "$tty" ] && printf '\033]2;%s\033\\' "$(hostname -s)" > "$tty" 2>/dev/null || true
