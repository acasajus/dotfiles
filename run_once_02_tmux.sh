#!/bin/bash

if [[ ! -d $HOME/.tmux/plugins/tmp ]]; then
  mkdir -p $HOME/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi
cd $HOME/.tmux/plugins/tpm
git pull
