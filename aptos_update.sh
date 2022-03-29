#!/bin/bash

curl -s https://raw.githubusercontent.com/cryptongithub/init/main/logo.sh | bash && sleep 2

cd $HOME/aptos
sudo docker compose down -v
sudo docker pull aptoslab/validator:devnet

echo "=+=+=+=+=+=++=+=++=crypton=+=+=+=+=+=++=+=++="

echo -e "\e[1m\e[32m2. Downloading \e[0m" && sleep 1

rm $HOME/aptos/genesis.blob
wget -P $HOME/aptos https://devnet.aptoslabs.com/genesis.blob

rm $HOME/aptos/waypoint.txt
wget -P $HOME/aptos https://devnet.aptoslabs.com/waypoint.txt

echo "=+=+=+=+=+=++=+=++=crypton=+=+=+=+=+=++=+=++="

echo -e "\e[1m\e[32m3. Setting a new waypoint param in the public_full_node.yaml file \e[0m" && sleep 1

sed -i.bak 's/\(from_config: \).*/\1"'$(cat $HOME/aptos/waypoint.txt)'"/g' $HOME/aptos/public_full_node.yaml

echo "=+=+=+=+=+=++=+=++=crypton=+=+=+=+=+=++=+=++="

echo -e "\e[1m\e[32m4. Restarting the node \e[0m" && sleep 1

sudo docker compose up -d

echo "=+=+=+=+=+=++=+=++=crypton=+=+=+=+=+=++=+=++="

echo -e "\e[1m\e[32m5. Aptos FullNode Started \e[0m"

echo "=+=+=+=+=+=++=+=++=crypton=+=+=+=+=+=++=+=++="

echo -e "\e[1m\e[32mTo check sync status: \e[0m" 
echo -e "\e[1m\e[39m    curl 127.0.0.1:9101/metrics 2> /dev/null | grep aptos_state_sync_version | grep type \n \e[0m" 

echo -e "\e[1m\e[32mTo view logs: \e[0m" 
echo -e "\e[1m\e[39m    docker logs -f aptos-fullnode-1 --tail 5000 \n \e[0m" 

echo -e "\e[1m\e[32mTo stop: \e[0m" 
echo -e "\e[1m\e[39m    docker compose stop \n \e[0m" 
