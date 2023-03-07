#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt --fix-broken install -y
sudo apt autoremove
sudo apt clean