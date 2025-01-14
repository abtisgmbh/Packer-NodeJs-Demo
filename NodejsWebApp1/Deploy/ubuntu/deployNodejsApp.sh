#!/bin/sh
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs
sudo apt-get update
sudo apt-get install -y nginx
sudo rm /etc/nginx/sites-enabled/default
script_dir=$(dirname "$0")
sudo cp $script_dir/node-app-nginx-config /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/node-app-nginx-config /etc/nginx/sites-enabled/node-app-nginx-config
sudo service nginx restart
sudo apt-get update
sudo apt-get install -y npm
sudo npm install -g pm2
sudo pm2 startup upstart
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup upstart -u atulm --hp /home/atulm
sudo pm2 start -f $script_dir/../../server.js
sudo pm2 save
