#!/bin/bash

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

clear
Red="\e[1;91m"      ##### Colors Used #####
Green="\e[0;92m"
Yellow="\e[0;93m"
Blue="\e[1;94m"
White="\e[0;97m"


banner () {        ##### Banner #####
echo -e "${Red}




 ██▓ ███▄    █   ██████ ▄▄▄█████▓ ▄▄▄       ██▓     ██▓    
▓██▒ ██ ▀█   █ ▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▓██▒    ▓██▒    
▒██▒▓██  ▀█ ██▒░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▒██░    ▒██░    
░██░▓██▒  ▐▌██▒  ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██░    ▒██░    
░██░▒██░   ▓██░▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒░██████▒░██████▒
░▓  ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▒░▓  ░░ ▒░▓  ░
 ▒ ░░ ░░   ░ ▒░░ ░▒  ░ ░    ░      ▒   ▒▒ ░░ ░ ▒  ░░ ░ ▒  ░
 ▒ ░   ░   ░ ░ ░  ░  ░    ░        ░   ▒     ░ ░     ░ ░   
 ░           ░       ░                 ░  ░    ░  ░    ░  ░
                                                             "
echo -e "${Yellow} \n            Install Tool"
echo -e "${Green}\n           WELCOME! HACK THE WORLD! HAPPY CRACKING!"
}

menu () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Install Script And All Dependencies"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Make air-script accessible anywhere (THIS IS IN BETA BE CAREFUL)"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Install Script And All Dependencies..."
    installScript
    exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Adding Air-Script Path..."
     AddPath
     exit 0
     ;;
  3) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}



installScript () {
clear
echo "$(tput setaf 2)Installing everything for you! Please wait..."
sleep 5
clear
cd tools
apt-get update
##################### aircrack-ng ##################### 
apt-get install -y aircrack-ng
##################### macchanger ##################### 
apt-get install -y macchanger
##################### anonsurf ##################### 
git clone https://github.com/Und3rf10w/kali-anonsurf
chmod -R 755 kali-anonsurf
cd kali-anonsurf
./installer.sh
apt install ./kali-anonsurf.deb
###################### Wifite2 ####################
cd ..
git clone https://github.com/derv82/wifite2.git
cd wifite2
cd ..
echo "$(tput setaf 2)Press Ctrl + C when fluxion is done."
sleep 10
##################### Fluxion ##################### 
git clone https://www.github.com/FluxionNetwork/fluxion.git
chmod -R 755 fluxion
cd fluxion
sudo ./fluxion.sh -i
cd ..
############### Zirikatu #########################
git clone https://github.com/pasahitz/zirikatu
chmod -R 755 zirikatu
############# DONE ###################
clear
echo "$(tput setaf 2)Fixing permissions..."
sleep 5
cd
chmod -R 755 air-script
cd air-script
clear
echo "$(tput setaf 2)DONE!"
sleep 3
echo "$(tput setaf 2)Please type ./air-script to start!"
sleep 3
echo "$(tput setaf 2)Be safe and happy cracking! :) "
sleep 3
clear


}

AddPath () { 
	echo -e "Adding air-script to PATH so you can access it from anywhere"
	sleep 1
	export PATH=/bin/air-script:$PATH
	sleep 1
	echo "export PATH=/bin/air-script:$PATH" >> ~/.bashrc
	sleep 1
	clear
	break
#done
clear
echo -e "DONE"
sleep 1
clear
echo -e "All done here, type air-script in terminal to start..."
sleep  4
cd air-script
./air-script.sh
exit

}

targeted () {
banner
menu
}

targeted
