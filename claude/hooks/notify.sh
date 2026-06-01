#!/usr/bin/env bash
set -eu

input=$(cat)
event=$(printf '%s' "$input" | jq -r '.hook_event_name // ""')
message=$(printf '%s' "$input" | jq -r '.message // ""')

if [ -n "${TMUX:-}" ]; then
    ctx=$(tmux display-message -p '#S:#I' 2>/dev/null || true)
    title="Claude Code${ctx:+ — $ctx}"
else
    title="Claude Code"
fi

case "$event" in
    Stop)         body="${message:-Task complete}" ;;
    Notification) body="${message:-Needs your input}" ;;
    *)            body="${message:-$event}" ;;
esac

case "${LC_TERMINAL:-${TERM_PROGRAM:-}}" in
    iTerm*)         activate="com.googlecode.iterm2" ;;
    Apple_Terminal) activate="com.apple.Terminal" ;;
    ghostty)        activate="com.mitchellh.ghostty" ;;
    WezTerm)        activate="com.github.wez.wezterm" ;;
    *)              activate="" ;;
esac

args=(-title "$title" -message "$body" -sound default -group claude-code)
[ -n "$activate" ] && args+=(-activate "$activate")

/opt/homebrew/bin/terminal-notifier "${args[@]}" >/dev/null 2>&1 || true

# Inside tmux, also ring the bell on Claude's pane so the window flashes
# red in the status bar (monitor-bell). Works even if macOS notifications
# are suppressed by Focus/Do-Not-Disturb or missing permissions.
if [ -n "${TMUX:-}" ]; then
    tty=$(tmux display-message -p ${TMUX_PANE:+-t "$TMUX_PANE"} '#{pane_tty}' 2>/dev/null || true)
    [ -n "$tty" ] && printf '\a' > "$tty" 2>/dev/null || true
fi
