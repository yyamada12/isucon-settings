#!/bin/sh -eux

# 各種インストール
sudo apt update -y
sudo apt install -y vim tmux htop dstat glances unzip graphviz

# netdata
sudo apt install -y autoconf-archive zlib1g-dev uuid-dev libmnl-dev libuv1-dev liblz4-dev libssl-dev libjudy-dev
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

# alp
mkdir -p ~/tmp
cd ~/tmp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin

curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/alp.yml -o ~/alp.yml

# percona-toolkit
mkdir -p ~/tmp
cd ~/tmp
wget percona.com/get/pt-query-digest
sudo install ./pt-query-digest /usr/local/bin

# remove tmp
rm -rf ~/tmp

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
alias als='alp ltsv -c ~/alp.yml | slackcat -t -c 12yacropolisy -n alp.txt'

alias pt='sudo pt-query-digest --limit 10 --report-format profile,query_report /var/log/mysql/slow.log | less'
alias pts='sudo pt-query-digest --limit 10 --report-format profile,query_report /var/log/mysql/slow.log | slackcat -c 12yacropolisy -n slowlog.txt'

alias pp='go tool pprof -png -output ~/pprof/pprof.png http://localhost:6060/debug/pprof/profile'
alias pps='go tool pprof -png -output ~/pprof/pprof.png http://localhost:6060/debug/pprof/profile && slackcat -c 12yacropolisy -n pprof.png ~/pprof/pprof.png'

stty stop undef
""" >> ~/.bashrc

# dotfiles
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.tmux.conf -o ~/.tmux.conf
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/.gitconfig -o ~/.gitconfig

# slackcat
wget https://github.com/bcicen/slackcat/releases/download/v1.5/slackcat-1.5-linux-amd64 -O slackcat
sudo mv slackcat /usr/local/bin/
sudo chmod +x /usr/local/bin/slackcat
slackcat --configure
