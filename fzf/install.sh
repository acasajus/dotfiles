#!/bin/sh

if ! test -d $HOME/.fzf; then
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
fi

$HOME/.fzf/install --key-bindings --completion --update-rc