#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  # Mac OS X platform        
  ln -s ~/git/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
  ln -s ~/git/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # GNU/Linux platform
  ln -s ~/git/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
  ln -s ~/git/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
fi
