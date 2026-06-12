#!/usr/bin/env bash
set -e

mkdir -p ~/.config/nvim

ln -sfn ~/git/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sfn ~/git/dotfiles/nvim/lua ~/.config/nvim/lua
ln -sfn ~/git/dotfiles/nvim/queries ~/.config/nvim/queries

echo "Symlinks installed. Launch nvim — lazy.nvim will bootstrap and install plugins on first run."
echo "After plugins install, run :Mason to verify LSP servers, and :checkhealth for diagnostics."
