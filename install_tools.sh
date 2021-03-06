#!/bin/sh

set -eux

# 各種インストール
sudo apt update -y
sudo apt install -y --fix-missing htop dstat glances unzip graphviz

# netdata
sudo apt install -y autoconf-archive zlib1g-dev uuid-dev libmnl-dev libuv1-dev liblz4-dev libssl-dev libjudy-dev
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait

# alp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.3/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin
rm alp_linux_amd64.zip alp

curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/alp.yml -o ~/alp.yml

# percona-toolkit
wget percona.com/get/pt-query-digest
sudo install ./pt-query-digest /usr/local/bin
rm pt-query-digest

# slackcat
curl -Lo slackcat https://github.com/bcicen/slackcat/releases/download/1.7.2/slackcat-1.7.2-$(uname -s)-amd64
sudo mv slackcat /usr/local/bin/
sudo chmod +x /usr/local/bin/slackcat
slackcat --configure
