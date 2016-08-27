# ctrl-p plugin dependency
apt-get install silversearcher-ag -y
apt-get install gnome-vim -y

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ln -s ~/git/dotfiles/vim/before.vim ~/.vim/before.vim
ln -s ~/git/dotfiles/vim/bundles.vim ~/.vim/bundles.vim
ln -s ~/git/dotfiles/vim/macros.vim ~/.vim/macros.vim
ln -s ~/git/dotfiles/vim/plugins.vim ~/.vim/plugins.vim
ln -s ~/git/dotfiles/vim/global.vim ~/.vim/global.vim

ln -s ~/git/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/git/dotfiles/vim/gvimrc ~/.gvimrc
ln -s ~/git/dotfiles/vim/editorconfig ~/.editorconfig
mkdir -p ~/.vim/{.backup,.swap,.undo}
