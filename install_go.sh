#!/bin/bash

GOVER=$(curl --silent https://go.dev/VERSION?m=text)
wget https://go.dev/dl/$GOVER.linux-amd64.tar.gz
sudo tar -xvf $GOVER.linux-amd64.tar.gz
sudo mv go /usr/local
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.zshrc
echo 'export GOPATH=$HOME/go'	>> ~/.zshrc			
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.zshrc	
source ~/.zshrc