#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

set -e

echo ''

# find the installers and run them iteratively
find . -name install.sh -not -path "./script/*" | while read installer ;
do
  chmod +x "${installer}"
  echo 'Installing ${installer}'
  bash "${installer}"
	
done

echo ''
echo '  All installed!'
