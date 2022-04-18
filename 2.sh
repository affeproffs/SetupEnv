# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

main() {
    cd ~

    installVsCode;
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

main