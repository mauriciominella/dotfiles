#curl
sudo apt-get install curl -y

#zsh
sudo apt-get install zsh -y

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# It adds two context menu items in nautlius so you can right click and choose "Resize Image". (The other is "Rotate Image").
sudo apt-get install nautilus-image-converter -y

sudo apt-get install vim -y

# Installing spotify http://ubuntuhandbook.org/index.php/2014/04/install-spotify-ubuntu-14-04/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client -y

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get update; sudo apt-get install google-chrome-stable -y

#docker
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $USER

#docker compose
sudo touch /usr/local/bin/docker-compose && sudo chown $USER /usr/local/bin/docker-compose
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#terminator
sudo add-apt-repository ppa:gnome-terminator

sudo apt-get update

sudo apt-get install terminator -y

#git
sudo apt-get install git-core -y

git config --global user.name "Mauricio Minella"
git config --global user.email "mauriciominella@gmail.com"
git config --global core.editor vim
git config --global core.autocrlf input

#ssh-keygen -t rsa -C "mauricio.minella@bravi.com.br"

#cat ~/.ssh/id_rsa.pub

#node
sudo apt-get install build-essential libssl-dev
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
echo ". ~/.nvm/nvm.sh" >> ~/.zshrc

source ~/.zshrc

nvm install stable

nvm use stable

n=$(which node);n=${n%/bin/node}; sudo chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
