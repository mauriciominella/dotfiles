# dotfiles
My dotfiles



# Manual settings
Ability to keep a key pressed on VSCode on Mac
```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## symlinks
./.tmux.conf -> /Users/mauricio/git/dotfiles/tmux/tmux.conf
./.editorconfig -> /Users/mauricio/git/dotfiles/vim/editorconfig
./.vimrc -> /Users/mauricio/git/dotfiles/vim/vimrc


ln -s /Users/mauricio/git/dotfiles/vim/plugins.vim /Users/mauricio/.vim/plugins.vim 
ln -s /Users/mauricio/git/dotfiles/vim/bundles.vim /Users/mauricio/.vim/bundles.vim 
ln -s /Users/mauricio/git/dotfiles/vim/macros.vim /Users/mauricio/.vim/macros.vim
ln -s /Users/mauricio/git/dotfiles/vim/global.vim /Users/mauricio/.vim/global.vim 
ln -s /Users/mauricio/git/dotfiles/vim/before.vim /Users/mauricio/.vim/before.vim 
ln -s /Users/mauricio/git/dotfiles/tmux/tmux.conf /Users/mauricio/.tmux.conf 
ln -s /Users/mauricio/git/dotfiles/vscode/settings.json /Users/mauricio/Library/Application Support/Code/User/settings.json 
ln -s /Users/mauricio/git/dotfiles/vscode/keybindings.json /Users/mauricio/Library/Application Support/Code/User/keybindings.json 
