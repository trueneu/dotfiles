#!/usr/bin/env bash
cd $HOME
sudo apt install python3-pip
sudo pip3 install xkeysnail
mkdir git_tree
cd git_tree
git clone https://github.com/trueneu/dotfiles.git

git clone https://github.com/rbreaves/kinto.git
cd kinto
./setup.py

sudo apt install emacs-nox
sudo apt install wmctrl
sudo apt install tmux
sudo apt install copyq
sudo apt install xclip

cd $HOME

ln -s $HOME/git_tree/dotfiles/clipper.service $HOME/.config/systemd/user/clipper.service

systemd --user daemon-reload

cd $HOME/git_tree/dotfiles
ln -s ssh-config $HOME/.ssh/config
ln -s .tmux.conf $HOME/.tmux.conf
ln -s .tmux.conf.linux $HOME/tmux.conf.linux
ln -s .gitconfig $HOME/.gitconfig

rm $HOME/.config/kinto/kinto.py
ln -s kinto.py $HOME/.config/kinto/kinto.py

source $HOME/git_tree/bashrc
sudo apt install golang-go

cd git_tree
mkdir -p gopath/src
go get github.com/wincent/clipper
cd github.com/wincent/clipper
go build

mkdir $HOME/bin
cp clipper $HOME/bin/

systemctl --user enable clipper.service
systemctl --user start clipper.service

sudo apt install dconf-editor
sudo apt install i3
sudo apt install rofi
sudo apt install feh

cd $HOME

mkdir -p .config/i3

ln -s $HOME/git_tree/dotfiles/i3/config .config/i3/config

cd $HOME/git_tree

git clone https://github.com/grwlf/xkb-switch.git

sudo apt install libxkbfile-dev
sudo apt install cmake

cd xkb-switch

mkdir build && cd build

cmake ..

make

sudo make install

sudo ldconfig

cd $HOME/git_tree/dotfiles/bin

ls -1 | while read f ; do ln -s $HOME/git_tree/dotfiles/bin/$f $HOME/bin/$f ; done

echo '[ -f ~/git_tree/dotfiles/.bashrc ] && source ~/git_tree/dotfiles/.bashrc' >> $HOME/.bashrc

sudo apt install lxappearance

cd $HOME/git_tree/dotfiles

mkdir $HOME/.fonts

mv fts.tgz $HOME/.fonts

cd $HOME/.fonts

tar xvzf fts.tgz

rm fts.tgz

fc-cache -fv

ln -s $HOME/git_tree/dotfiles/.Xresources $HOME/.Xresources

cd $HOME

mkdir -p Pictures/wallpapers

cd Pictures/wallpapers

wget https://512pixels.net/downloads/macos-wallpapers/10-13.jpg

feh --bg-scale $HOME/Pictures/wallpapers/10-13.jpg

