#!/bin/sh

set -eux

# 各種インストール
sudo apt update -y
sudo apt install -y --fix-missing git vim tmux

# bashrc
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.alias.bash -o ~/.alias.bash
echo """
# alias
source ~/.alias.bash

# for incremental search with Ctr + S
stty stop undef
""" >> ~/.bashrc

# dotfiles
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.tmux.conf -o ~/.tmux.conf
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.gitconfig -o ~/.gitconfig
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.vimrc -o ~/.vimrc
