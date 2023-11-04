#!/bin/sh
set -x

# 各種インストール
sudo apt update -y
sudo apt install -y --fix-missing git vim tmux tig

# bashrc
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.alias.bash -o ~/.alias.bash
echo """
# alias
source ~/.alias.bash
source ~/.bash_profile

# for incremental search with Ctr + S
stty stop undef
""" >> ~/.bashrc

# dotfiles
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.tmux.conf -o ~/.tmux.conf
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.gitconfig -o ~/.gitconfig
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.vimrc -o ~/.vimrc

# deploy script
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/deploy.sh -o ~/deploy.sh
chmod +x ~/deploy.sh

# manage_etc_files.sh
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/manage_etc_files.sh -o ~/manage_etc_files.sh
chmod +x ~/manage_etc_files.sh
