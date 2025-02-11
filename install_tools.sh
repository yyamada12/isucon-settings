#!/bin/sh

set -eux

# 各種インストール
sudo apt update -y
sudo apt install -y --fix-missing htop unzip graphviz

# netdata
sudo apt install -y autoconf-archive zlib1g-dev uuid-dev libmnl-dev libuv1-dev liblz4-dev libssl-dev libjudy-dev
bash <(curl -Ss https://get.netdata.cloud/kickstart.sh) --dont-wait

# alp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.11/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin
rm alp_linux_amd64.zip alp

curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/alp.yml -o ~/alp.yml

# percona-toolkit
wget percona.com/get/pt-query-digest
sudo install ./pt-query-digest /usr/local/bin
rm pt-query-digest

# # slackcat
# curl -Lo slackcat https://github.com/bcicen/slackcat/releases/download/1.7.2/slackcat-1.7.2-$(uname -s)-amd64
# sudo mv slackcat /usr/local/bin/
# sudo chmod +x /usr/local/bin/slackcat
# slackcat --configure

# upload_file_slack.sh
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/upload_file_slack.sh -o ~/upload_file_slack.sh
chmod +x ~/upload_file_slack.sh

# set_env.sh
curl -L https://raw.githubusercontent.com/yyamada12/isucon-settings/master/set_env.sh -o ~/set_env.sh
chmod +x ~/set_env.sh
~/set_env.sh
