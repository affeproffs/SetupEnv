# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

# Common functions
source ./common.sh

# SSH key
SSH_KEY=~/.ssh/id_ed25519.pub
if [ ! -f "$SSH_KEY" ]; then
	get "Enter your email address for the SSH key" email
	ssh-keygen -t ed25519 -C "$email"
fi
clear
echo -e "${GREEN}Generated SSH key, copy the following:${NOCOLOR}"
cat ~/.ssh/id_ed25519.pub

if ask "Copied?"; then
	echo "A link to github will open, log in and save your ssh key."
	sleep 3;
	xdg-open https://github.com/settings/keys
fi

if ! ask "Saved the SSH key?"; then
	echo "You need to save the SSH key to continue."
	exit 1;
fi

# Personal Access Token (github)
clear
echo "Now you need to create a personal access token. A browser will open."
sleep 3;
xdg-open https://github.com/settings/tokens/new

if ! ask "Did you create a personal access token?"; then
	echo "You need to have a personal access token to continue."
	exit 1;
fi

get "Enter your personal access token" pat

# Coding directory and GitScripts
clear
if ask "Create Coding directory?"; then
	mkdir ~/Coding
fi
sleep 1;
cd ~/Coding
if ask "Clone GitScripts into ~/Coding/GitScripts?"; then
	git clone git@github.com:affeproffs/GitScripts.git
fi
cd GitScripts

echo -e "${GREEN}Saving your personal access token inside GitScripts...${NOCOLOR}"
echo "$pat" > token.txt
sleep 2;

# Setting up git aliases
clear
if ask "Set git aliases and .gitconfig?"; then
	aliases=$(cat aliases)
	echo "$aliases" | sed -e 's,bash ,bash '"~/Coding/GitScripts"/',g' > ~/.bash_aliases
	cp .gitconfig ~/.gitconfig
fi
sleep 1;

clear
echo -e "${GREEN}Basic installations done.${NOCOLOR}"
if ask "Wish to continue with programs?"; then
	cd ~/SetupEnv
	bash 2.sh
fi
