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
&nbsp;
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

&nbsp;
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
- installs pip
- installs 1Password

&nbsp;
### Optionals and links
##### Set up network drivers for RTL8811AU, RTL8812AU, RTL8814AU chipsets --> [Link](https://blog.abysm.org/2020/03/realtek-802-11ac-usb-wi-fi-linux-driver-installation/)