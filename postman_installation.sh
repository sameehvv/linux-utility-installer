#!/bin/bash

wget https://dl.pstmn.io/download/latest/linux_64 -O postman-linux-x64.tar.gz
tar -xzf postman-linux-x64.tar.gz
sudo mv Postman /opt/
sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
rm postman-linux-x64.tar.gz