#!/bin/sh -eux

# 各種インストール
sudo apt update -y
sudo apt install -y vim tmux htop dstat glances unzip

# alp
mkdir -p ~/tmp
cd ~/tmp
wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin

curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/alp.yml -o ~/alp.yml

# percona-toolkit
mkdir -p ~/tmp
cd ~/tmp
wget percona.com/get/pt-query-digest
sudo install ./pt-query-digest /usr/local/bin

# alias
echo """
# git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gci='git commit'

alias al='alp ltsv -c ~/alp.yml | less'
alias als='alp ltsv -c ~/alp.yml | slackcat -t -c 12yacropolisy'

alias pt='sudo pt-query-digest --limit 10 /var/log/mysql/slow.log | less'
alias pts='sudo pt-query-digest --limit 10 /var/log/mysql/slow.log | slackcat -t -c 12yacropolisy'

""" >> ~/.bashrc

# dotfiles
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.tmux.conf -o ~/.tmux.conf
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.gitconfig -o ~/.gitignore

# slackcat
wget https://github.com/bcicen/slackcat/releases/download/v1.5/slackcat-1.5-linux-amd64 -O slackcat
sudo mv slackcat /usr/local/bin/
sudo chmod +x /usr/local/bin/slackcat
slackcat --configure
