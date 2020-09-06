#!/usr/bin/env bash
cd $HOME
sudo apt install python3-pip
sudo pip3 install xkeysnail
mkdir git_tree
cd git_tree
git clone https://github.com/rbreaves/kinto.git
git clone https://github.com/trueneu/dotfiles.git
cd kinto
./setup.py

sudo apt install emacs-nox
cd $HOME

sudo apt install wmctrl
sudo apt install tmux
sudo apt install copyq
sudo apt install xclip

ln -s $HOME/git_tree/dotfiles/clipper.service $HOME/.config/systemd/user/clipper.service
systemctl --user enable clipper.service
systemctl --user start clipper.service

cd $HOME/git_tree/dotfiles
ln -s ssh-config $HOME/.ssh/config
ln -s .tmux.config $HOME/.tmux.config
ln -s .tmux.config.linux $HOME/tmux.config.linux
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
cp clipper $HOME/bin/
