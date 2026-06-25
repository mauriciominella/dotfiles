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
# Core and Cerberus are the two we care about most, so they're pulled out by
# key and shown first, with their full host:port (the rest is dumped below for
# context). We parse the /info table by key rather than a blanket *.fuga.com
# grep because that grep stopped at ".com" and dropped the port — which made
# Core and Cerberus (both on lurch.fuga.com) collapse into one ambiguous line.
#
# Each /info is fetched with a short --max-time so closed ports (instant
# "connection refused" on localhost) and the rare hang don't stall the popup.

# Pull a single /info table row's value (KEY -> URL) out of the HTML.
extract() {
  # $1 = full /info HTML, $2 = config key (e.g. CORE_API_URL)
  printf '%s' "$1" | perl -ne 'print "$1" if /\Q'"$2"'\E<\/td><td[^>]*>([^<]*)/'
}

found=0
for port in $(seq 3000 3009); do
  info=$(curl -s --max-time 1 "http://localhost:${port}/info")
  [ -z "$info" ] && continue

  core=$(extract "$info" CORE_API_URL)
  cerberus=$(extract "$info" CERBERUS_API_URL)
  # only treat it as a real muse if /info gave us the expected config
  [ -z "$core" ] && [ -z "$cerberus" ] && continue

  found=1
  printf '\033[1;34m── :%s ──\033[0m\n' "$port"
  printf '  \033[1;32mCore    \033[0m %s\n' "${core:-—}"
  printf '  \033[1;35mCerberus\033[0m %s\n' "${cerberus:-—}"

  services=$(printf '%s' "$info" | grep -Eio 'https?://[a-z0-9./:-]+fuga[a-z]*\.com[a-z0-9./:-]*' | sort -u)
  if [ -n "$services" ]; then
    printf '  \033[2mother:\033[0m\n'
    printf '%s\n' "$services" | sed 's/^/    /'
  fi
  printf '\n'
done

if [ "$found" -eq 0 ]; then
  echo "No muse reachable on ports 3000–3009."
fi
