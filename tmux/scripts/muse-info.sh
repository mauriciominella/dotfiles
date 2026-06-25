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
# Core and Cerberus are the only two we care about, so they're pulled out by
# key and shown with their full host:port. We parse the /info table by key
# rather than a blanket *.fuga.com grep because that grep stopped at ".com"
# and dropped the port — which made Core and Cerberus (both on lurch.fuga.com)
# collapse into one ambiguous line.
#
# Each /info is fetched with a short --max-time so closed ports (instant
# "connection refused" on localhost) and the rare hang don't stall the popup.

# Pull a single /info table row's value (KEY -> URL) out of the HTML.
extract() {
  # $1 = full /info HTML, $2 = config key (e.g. CORE_API_URL)
  printf '%s' "$1" | perl -ne 'print "$1" if /\Q'"$2"'\E<\/td><td[^>]*>([^<]*)/'
}

# Resolve the working directory of whoever is listening on a port. We go
# port -> listening PID -> its cwd via lsof; the dev server is launched from
# the muse's front-end folder, so this points straight at the checkout/worktree.
port_cwd() {
  # $1 = port
  local pid cwd
  pid=$(lsof -ti "tcp:$1" -sTCP:LISTEN 2>/dev/null | head -1)
  [ -z "$pid" ] && return
  cwd=$(lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')
  # tidy: $HOME -> ~ and drop the trailing /front-end that's noise on every row
  cwd=${cwd%/front-end}
  printf '%s' "${cwd/#$HOME/~}"
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
  dir=$(port_cwd "$port")
  printf '\033[1;34m── :%s ──\033[0m\n' "$port"
  printf '  \033[1;33mFolder  \033[0m %s\n' "${dir:-—}"
  printf '  \033[1;32mCore    \033[0m %s\n' "${core:-—}"
  printf '  \033[1;35mCerberus\033[0m %s\n\n' "${cerberus:-—}"
done

if [ "$found" -eq 0 ]; then
  echo "No muse reachable on ports 3000–3009."
fi
