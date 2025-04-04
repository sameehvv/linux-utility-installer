#!/bin/bash

GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
NC=$(tput sgr0)

if [[ "$SHELL" == *"bash"* ]]; then
  SHELL_RC="$HOME/.bashrc"
elif [[ "$SHELL" == *"zsh"* ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  echo -e "${RED}Unknown shell. Exiting...${NC}"
  exit 1
fi

separator() {
  echo -e "${YELLOW}------------------------------------------------------------${NC}"
}

is_go_installed() {
  if command -v go &> /dev/null; then
    return 0
  else
    return 1
  fi
}

is_postman_installed() {
  if command -v postman &> /dev/null; then
    return 0
  else
    return 1
  fi
}

is_sublime_installed() {
  if command -v subl &> /dev/null; then
    return 0
  else
    return 1
  fi
}


is_python2_installed() {
  if command -v python2 &> /dev/null; then
    return 0
  else
    return 1
  fi
}

function install_go {
  separator
  if is_go_installed; then
    echo -e "${GREEN}Go is already installed.${NC}"
  else
    echo -e "${GREEN}Installing Go...${NC}"
    GOVER=$(curl --silent https://go.dev/VERSION?m=text | head -n 1)
    wget https://go.dev/dl/$GOVER.linux-amd64.tar.gz
    sudo tar -xvf $GOVER.linux-amd64.tar.gz
    sudo mv go /usr/local
    rm -f $GOVER.linux-amd64.tar.gz


    echo -e "\n# Go Environment Variables" >> $SHELL_RC
    echo "export GOROOT=/usr/local/go" >> $SHELL_RC
    echo "export GOPATH=\$HOME/go" >> $SHELL_RC
    echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> $SHELL_RC
    source $SHELL_RC

    echo -e "${GREEN}Go installation complete!${NC}"
  fi
}

function install_postman {
  separator
  if is_postman_installed; then
    echo -e "${GREEN}Postman is already installed.${NC}"
  else
    echo -e "${GREEN}Installing Postman...${NC}"
    sudo snap install postman
    echo -e "${GREEN}Postman installation complete!${NC}"
  fi
}

function install_postman {
  separator
  if is_postman_installed; then
    echo -e "${GREEN}Postman is already installed.${NC}"
  else
    echo -e "${GREEN}Installing Postman...${NC}"
    wget https://dl.pstmn.io/download/latest/linux_64 -O postman-linux-x64.tar.gz
    tar -xzf postman-linux-x64.tar.gz
    sudo mv Postman /opt/
    sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
    rm postman-linux-x64.tar.gz
    echo -e "${GREEN}Postman installation complete!${NC}"
  fi
}


function install_sublime_text {
  separator
  if is_sublime_installed; then
    echo -e "${GREEN}Sublime Text is already installed.${NC}"
  else
    echo -e "${GREEN}Installing Sublime Text...${NC}"
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /usr/share/keyrings/sublimehq-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt update
    sudo apt install sublime-text -y
    echo -e "${GREEN}Sublime Text installation complete!${NC}"
  fi
}

function update_system {
  separator
  echo -e "${GREEN}Updating system...${NC}"
  sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y
  sudo apt --fix-broken install -y
  sudo apt autoremove -y && sudo apt clean
  echo -e "${GREEN}System update complete!${NC}"
}

function install_python2_and_pip2 {
  separator
  if is_python2_installed; then
    echo -e "${GREEN}Python2 is already installed.${NC}"
  else
    echo -e "${GREEN}Installing Python2 and Pip2...${NC}"
    sudo apt update
    sudo apt install python2 python-is-python2 -y
    curl -sS https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2
    echo -e "${GREEN}Python2 and Pip2 installation complete!${NC}"
  fi
}


separator
echo -e "${GREEN}Welcome to the Installer Script!${NC}"
separator

PS3=$'\n'"$(tput bold)${YELLOW}Please enter your choice: ${NC}"

options=(
  "Install Go"
  "Install Postman"
  "Install Sublime Text"
  "Update System"
  "Install Python2 & Pip2"
  "Install All"
  "Quit"
)

select opt in "${options[@]}"; do
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
    "Update System")
      update_system
      ;;
    "Install Python2 & Pip2")
      install_python2_and_pip2
      ;;
    "Install All")
      install_go
      install_postman
      install_sublime_text
      update_system
      install_python2_and_pip2
      ;;
    "Quit")
      echo -e "${RED}Exiting...${NC}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Please try again.${NC}"
      ;;
  esac
done
