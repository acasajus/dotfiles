#!/bin/bash

mkdir -p $HOME/tmp/nerd-fonts
cd $HOME/tmp/nerd-fonts
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
chmod +x install.sh
./install.sh "Hack"
