# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

main() {
    cd ~

    installVsCode;
    installNode;
    installChrome;
    installYarn;
    installDocker;

    echo -e "${GREEN}Installations complete.${NOCOLOR}"
    exit 0;
}

# Common functions
source ./common.sh

askForInstall() {
    if ask "Would you like to install $*?"; then
        return 0
    fi
    return 1
}

installVsCode() {
    clear
    if ! askForInstall "vscode"; then
        return;
    fi
    
    echo "Retrieving .deb-file..."
    cd ~/Downloads
    if curl https://update.code.visualstudio.com/latest/linux-deb-x64/stable -o vscode.deb -L -s -f; then
        echo "Successfully retrieved .deb-file"
        sleep 2;
    else
        echo "Failed to retrieve .deb-file. Cancelling installation."
        sleep 3;
        return;
    fi    

    echo "Installing .deb-file..."
    sudo apt install ./vscode.deb -qq
    echo -e "${GREEN}Finished installing vscode.${NOCOLOR}"
    sleep 3;
}

installNode() {
    clear
    if ! askForInstall "node and npm"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving node and npm..."
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    echo "Installing node and npm..."
    sudo apt-get install -y nodejs -qq
    echo -e "${GREEN}Finished installing node and npm.${NOCOLOR}"
    sleep 3;    
}

installChrome() {
    clear
    if ! askForInstall "google chrome"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving google chrome..."
    if wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; then        
        echo "Successfully retrieved google chrome"
        sleep 2        
    else
        echo "Failed to retrieve google chrome. Cancelling installation."
        sleep 3;
        return
    fi

    echo "Installing google chrome..."
    sudo apt install ./google-chrome-stable_current_amd64.deb -qq
    echo -e "${GREEN}Finished installing google chrome.${NOCOLOR}"
    sleep 3;
}

installYarn() {
    clear
    if ! askForInstall "yarn"; then
        return;
    fi

    echo "Installing yarn..."
    sudo npm install --quiet --global yarn
    echo -e "${GREEN}Finished installing yarn.${NOCOLOR}"
    sleep 3;
}

installDocker() {
    clear
    if ! askForInstall "docker"; then
        return;
    fi

    echo "Uninstalling old versions..."
    sudo apt-get remove docker docker-engine docker.io containerd runc -qq
    echo "Installing dependencies..."
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release -qq

    # GPG key and stable repo
    echo "Setting up repository for download..."
    sleep 1
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -qq
    echo "Installing docker..."
    sudo apt-get install docker-ce docker-ce-cli containerd.io -qq
    echo -e "${GREEN}Finished installing docker.${NOCOLOR}"
    sleep 1;
    if ask "Wish to create a docker group? For non-sudo access."; then
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
        echo "Added docker group."
        sleep 2;
    fi    
}

main