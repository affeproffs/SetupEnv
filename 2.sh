# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

main() {
    cd ~

    installVsCode;
    installNode;
    installChrome;
    installYarn;

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

main