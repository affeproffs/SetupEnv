### **Ignore this repository.**
###### I use it to set up my own environment on new devices without a pre-existing SSH key.

&nbsp;

# Prerequisites
- [Git](https://github.com/git-guides/install-git)
- Run
```sh
sudo apt update && sudo apt upgrade
```

# Steps
### 1. Clone the repository
```sh
cd 
git clone git@github.com:affeproffs/SetupEnv.git
```

### 2. Run `1.sh` - basic configuration
```sh
cd SetupEnv
bash 1.sh
```
The script does the following:
- generates and sets a SSH key and a personal access token
- creates a Coding directory
- clones GitScripts
- sets git aliases and .gitconfig

### 3. Run `2.sh` - program installation
```sh
bash 2.sh
```
The script does the following:
- installs node
- installs npm
- installs vs code
- installs google chrome
- installs yarn
- installs docker
