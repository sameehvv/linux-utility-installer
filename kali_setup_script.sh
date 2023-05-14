#!/bin/bash

function install_go {
  GOVER=$(curl --silent https://go.dev/VERSION?m=text)
  wget https://go.dev/dl/$GOVER.linux-amd64.tar.gz
  sudo tar -xvf $GOVER.linux-amd64.tar.gz
  sudo mv go /usr/local
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
  echo 'export GOROOT=/usr/local/go' >> ~/.zshrc
  echo 'export GOPATH=$HOME/go' >> ~/.zshrc
  echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.zshrc
  source ~/.zshrc
}

function install_postman {
  wget https://dl.pstmn.io/download/latest/linux_64 -O postman-linux-x64.tar.gz
  tar -xzf postman-linux-x64.tar.gz
  sudo mv Postman /opt/
  sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
  rm postman-linux-x64.tar.gz
}

function install_sublime_text {
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt-get install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install sublime-text -y
}

function install_linux_priv_tools {
  mkdir /home/$USER/Desktop/linpriv_tools
  wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -P /home/$USER/Desktop/linpriv_tools/
  wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -P /home/$USER/Desktop/linpriv_tools/
  wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64 -P /home/$USER/Desktop/linpriv_tools/
  wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy32 -P /home/$USER/Desktop/linpriv_tools/
  echo "Tools has been downloaded on /home/$USER/Desktop/linpriv_tools"
}

function update_system {
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt dist-upgrade -y
  sudo apt --fix-broken install -y
  sudo apt autoremove
  sudo apt clean
}

function install_python2_and_pip2 {
  sudo apt update
  sudo apt -y install python2.7
  curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
  python2 get-pip.py
}

# Main menu
PS3='Please enter your choice: '
options=("Install Go" "Install Postman" "Install Sublime Text" "Install Linux Priv Tools" "Update System" "install python2 and pip2" "All" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Install Go")
      install_go
      ;;
    "Install Postman")
      install_postman
      ;;
    "Install Sublime Text")
      install_sublime_text
      ;;
    "Install Linux Priv Tools")
      install_linux_priv_tools
      ;;
    "Update System")
      update_system
      ;;
    "install python2 and pip2")
      install_python2_and_pip2
      ;;      
    "All")
      install_go
      install_postman
      install_sublime_text
      install_linux_tools
      update_system
      install_python2_and_pip2
      ;;
    "Quit")
      break
      ;;
    *) echo "Invalid option. Please try again.";;
  esac
done
