#!/bin/sh

set -eux

# 各種インストール
sudo apt update -y
sudo apt install -y --fix-missing vim tmux htop dstat glances unzip graphviz

# netdata
sudo apt install -y autoconf-archive zlib1g-dev uuid-dev libmnl-dev libuv1-dev liblz4-dev libssl-dev libjudy-dev
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait


mkdir -p ~/tmp
cd ~/tmp

# alp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin

curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/alp.yml -o ~/alp.yml

# percona-toolkit
wget percona.com/get/pt-query-digest
sudo install ./pt-query-digest /usr/local/bin

# remove tmp
cd ~
rm -rf ~/tmp

# bashrc
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
alias gl='git log'
alias ggr="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# alp
alias al='alp ltsv -c ~/alp.yml | less'
alias als='alp ltsv -c ~/alp.yml | slackcat -t -c yyamada -n alp.txt'

# pt-query-digest
alias pt='sudo pt-query-digest --limit 10 --report-format profile,query_report /var/log/mysql/slow.log | less'
alias pts='sudo pt-query-digest --limit 10 --report-format profile,query_report /var/log/mysql/slow.log | slackcat -c yyamada -n slowlog.txt'

# pprof
alias pp='go tool pprof -png -output ~/pprof/pprof.png http://localhost:6060/debug/pprof/profile'
alias pps='go tool pprof -png -output ~/pprof/pprof.png http://localhost:6060/debug/pprof/profile && slackcat -c yyamada -n pprof.png ~/pprof/pprof.png'

# for incremental search with Ctr + S
stty stop undef
""" >> ~/.bashrc

# dotfiles
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.tmux.conf -o ~/.tmux.conf
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.gitconfig -o ~/.gitconfig

# slackcat
curl -Lo slackcat https://github.com/bcicen/slackcat/releases/download/1.7.2/slackcat-1.7.2-$(uname -s)-amd64
sudo mv slackcat /usr/local/bin/
sudo chmod +x /usr/local/bin/slackcat
slackcat --configure
