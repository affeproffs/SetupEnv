# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

main() {
    cd ~

    # Technologies
    installNode;
    installNvm;
    installYarn;
    installPnpm;
    installBun;
    installDocker;
    installDockerCompose;
    installHelm;
    installKubectl;
    installMinikube;
    installAwsCli;
    installAz;
    installPip;
    installRust;
    installDotNet;
    installPowerShell;
    installRedis;
    installPostgreSQL;

    # Applications
    installVsCode;
    installSpotify;
    install1Password;
    installChrome;

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
    rm vscode.deb
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
    sudo apt install -y nodejs -qq
    echo -e "${GREEN}Finished installing node and npm.${NOCOLOR}"
    sleep 3;    
}

installNvm() {
    clear
    if ! askForInstall "nvm"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving and installing nvm..."
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    echo -e "${GREEN}Finished installing nvm.${NOCOLOR}"
    sleep 3;
}

installChrome() {
    clear
    if ! askForInstall "google chrome"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving google chrome..."
    if wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -q; then
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
    rm google-chrome-stable_current_amd64.deb
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

installDockerCompose() {
    clear
    if ! askForInstall "docker compose (requires docker)"; then
        return;
    fi

    echo "Installing docker compose..."
    sudo apt-get install docker-compose-plugin
    echo -e "${GREEN}Finished installing docker compose.${NOCOLOR}"
    sleep 3;
}

installKubectl() {
    clear
    if ! askForInstall "kubectl"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving kubectl..."
    curl -LOs "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    echo "Installing kubectl..."
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl    
    echo -e "${GREEN}Finished installing kubectl.${NOCOLOR}"
    sleep 3;
}

installMinikube() {
    clear
    if ! askForInstall "minikube"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving minikube..."
    curl -LOs https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    echo "Installing minikube..."
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    echo -e "${GREEN}Finished installing minikube.${NOCOLOR}"
    sleep 3;
}

installAwsCli() {
    clear
    if ! askForInstall "aws cli"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving aws cli..."
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    echo "Installing aws cli..."
    unzip awscliv2.zip
    sudo ./aws/install
    echo -e "${GREEN}Finished installing aws cli.${NOCOLOR}"
    rm awscliv2.zip
    sleep 3;
}

installPip() {
    clear
    if ! askForInstall "pip"; then
        return;
    fi

    echo "Installing pip..."
    sudo apt-get install python3-pip -qq
    echo -e "${GREEN}Finished installing pip.${NOCOLOR}"
    sleep 3;
}

install1Password() {
    clear
    if ! askForInstall "1Password"; then
        return;
    fi

    cd ~/Downloads
    echo "Retrieving 1Password..."
    if wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb -q; then
        echo "Successfully retrieved 1Password"
        sleep 2        
    else
        echo "Failed to retrieve 1Password. Cancelling installation."
        sleep 3;
        return
    fi

    echo "Installing 1Password..."
    sudo apt install ./1password-latest.deb -qq
    echo -e "${GREEN}Finished installing 1Password.${NOCOLOR}"
    rm 1password-latest.deb
    sleep 3;
    
}

installRust() {
    clear
    if ! askForInstall "Rust"; then
        return;
    fi

    echo "Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh    
    echo -e "${GREEN}Finished installing rust.${NOCOLOR}"
    sleep 3;
}

installBun() {
    clear
    if ! askForInstall "Bun"; then
        return;
    fi

    echo "Installing bun..."
    curl -fsSL https://bun.sh/install | bash
    echo -e "${GREEN}Finished installing bun.${NOCOLOR}"
    sleep 3;
}

installSpotify() {
    clear
    if ! askForInstall "Spotify"; then
        return;
    fi

    echo "Installing spotify..."
    cd ~/Downloads
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update -qq && sudo apt-get install spotify-client -qq
    echo -e "${GREEN}Finished installing spotify.${NOCOLOR}"
    sleep 3;
}

installPostgreSQL() {
    clear
    if ! askForInstall "postgresql"; then
        return;
    fi

    echo "Installing postgresql..."
    sudo apt-get update
    sudo apt-get install postgresql
    echo -e "${GREEN}Finished installing postgresql.${NOCOLOR}"
    sleep 3;
}

installRedis() {
    clear
    if ! askForInstall "redis"; then
        return;
    fi

    echo "Installing redis..."
    cd ~/Downloads
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
    sudo apt-get update
    sudo apt-get install redis -qq
    sudo apt-get install redis-server -qq
    echo -e "${GREEN}Finished installing redis.${NOCOLOR}"
    sleep 3;
}

installPnpm() {
    clear
    if ! askForInstall "pnpm"; then
        return;
    fi

    echo "Installing pnpm..."
    cd ~/Downloads
    curl -fsSL https://get.pnpm.io/install.sh | sh -    
    echo -e "${GREEN}Finished installing pnpm.${NOCOLOR}"
    sleep 3;
}

installAz() {
    clear
    if ! askForInstall "azure CLI"; then
        return;
    fi

    echo "Installing az..."
    cd ~/Downloads
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    echo -e "${GREEN}Finished installing az.${NOCOLOR}"
    sleep 3;
}

installHelm() {
    clear
    if ! askForInstall "helm"; then
        return;
    fi

    echo "Installing helm..."
    cd ~/Downloads
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
    echo -e "${GREEN}Finished installing helm.${NOCOLOR}"
    sleep 3;
}

installDotNet() {
    clear
    if ! askForInstall ".NET"; then
        return;
    fi

    echo "Installing .NET..."
    cd ~/Downloads
    wget https://dot.net/v1/dotnet-install.sh -q -O dotnet-install.sh
    chmod +x ./dotnet-install.sh
    ./dotnet-install.sh --version latest
    rm dotnet-install.sh

    echo '# .NET' >> ~/.bashrc
    echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
    echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc

    echo -e "${GREEN}Finished installing .NET.${NOCOLOR}"
    sleep 3;
}

installPowerShell() {
    clear
    if ! askForInstall "PowerShell"; then
        return;
    fi

    echo "Installing PowerShell..."
    cd ~/Downloads
    source /etc/os-release
    wget -q https://packages.microsoft.com/config/debian/$VERSION_ID/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt-get update -qq
    sudo apt-get install -y powershell -qq

    echo -e "${GREEN}Finished installing PowerShell.${NOCOLOR}"
    sleep 3;
}

main