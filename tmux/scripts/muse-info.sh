#!/usr/bin/env bash
# Show which backend services every locally-running muse is wired to, across
# the whole 300x port range (prefix + M). Mirrors the `muse-info` shell alias
# (curl /info, pull the *.fuga.com URLs) but probes 3000–3009 so it finds a
# muse on any port — a sandbox/second instance, the :3005 fake server, etc.
#
# Lives in a script (not inline in tmux.conf) because a popup runs a
# non-interactive shell that doesn't load aliases, and the loop's quoting is
# far easier to maintain here.
#
# Each /info is fetched with a short --max-time so closed ports (instant
# "connection refused" on localhost) and the rare hang don't stall the popup.

found=0
for port in $(seq 3000 3009); do
  services=$(curl -s --max-time 1 "http://localhost:${port}/info" \
    | grep -Eio '[a-z/:.]+fuga.com' | sort -u)
  if [ -n "$services" ]; then
    found=1
    printf '\033[1;34m── :%s ──\033[0m\n' "$port"
    printf '%s\n\n' "$services"
  fi
done

if [ "$found" -eq 0 ]; then
  echo "No muse reachable on ports 3000–3009."
fi
