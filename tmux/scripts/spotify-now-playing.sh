#!/usr/bin/env bash
# Print what Spotify is currently playing, for on-demand display (prefix + S).
# Reads the running app over AppleScript / Apple Events — local only, no
# network and no Web API token. Guarded on `is running` so it never *launches*
# Spotify just to answer the question. First use triggers a one-time macOS
# Automation permission prompt ("Terminal wants to control Spotify").
#
# AppleScript note: a bare top-level `return` placed *before* a `tell` block
# trips the compiler ("Expected expression"), so we funnel everything through
# one `out` variable and return it once at the end.
osascript <<'EOF' 2>/dev/null
set out to "♫ Nothing playing"
if application "Spotify" is running then
  tell application "Spotify"
    set pstate to player state as text
    if pstate is "playing" or pstate is "paused" then
      set glyph to "♫"
      if pstate is "paused" then set glyph to "⏸"
      set out to glyph & " " & artist of current track & " – " & name of current track
    end if
  end tell
else
  set out to "♫ Spotify isn't running"
end if
return out
EOF
