#!/bin/bash

mkdir -p $HOME/tmp/nerd-fonts
cd $HOME/tmp/nerd-fonts
if [ -d nerd-fonts ]; then
  cd nerd-fonts
  git pull
else
  git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts
fi
chmod +x install.sh
./install.sh "Hack"
