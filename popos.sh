#!/usr/bin/env bash
cd $HOME
sudo apt install python3-pip
sudo pip3 install xkeysnail
mkdir git_tree
cd git_tree
git clone https://github.com/rbreaves/kinto.git
cd kinto
./setup.py

sudo apt install emacs-nox
cd $HOME

sudo apt install wmctrl
sudo apt install tmux
sudo apt install xdotool

