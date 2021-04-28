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
echo -e "${Green}




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
sudo apt-get install -y aircrack-ng
##################### macchanger ##################### 
sudo apt-get install -y macchanger
##################### Websploit #####################
sudo apt-get install websploit
#####################################################
### Wifiphisher ################################
sudo apt install -y wifiphisher 
##################### Python PyQt4 ################################
sudo apt-get install -y python3-pyqt4
sudo apt-get install libqt4-dev
sudo apt-get install python-qt4
sudo pip install sip
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
################# BeeLogger ####################
git clone https://github.com/4w4k3/BeeLogger.git
cd BeeLogger
sudo chmod +x install.sh
./install.sh
cd ..
############### Zirikatu #########################
git clone https://github.com/pasahitz/zirikatu
chmod -R 755 zirikatu
################ Routersploit ##############################
apt-get install python3-pip
git clone https://www.github.com/threat9/routersploit
cd routersploit
python3 -m pip install -r requirements.txt
cd ..
################### Zattacker ##########################
git clone https://github.com/Sleek1598/Zatacker.git
cd Zatacker
chmod +x setup.sh
echo "$(tput setaf 2)When asked for filepath, please specify or click enter for default"
sleep 3
./setup.sh
cd ..
############################## Hakku ###################################
git clone https://github.com/4shadoww/hakkuframework
chmod -R 755 hakkuframework
cd hakkuframework
./isntall
cd ..
######################### morpheus ################################
git clone https://github.com/r00t-3xp10it/morpheus.git
cd morpheus
chmod -R +x *.sh
chmod -R +x *.py
echo "$(tput setaf 2)Edit morpheus settings... click Crtl + X when done. Please wait.."
sleep 5
nano settings
cd ..
############## XERXES #########################################
git clone https://github.com/XCHADXFAQ77X/XERXES
cd XERXES
chmod +x xerxes
sudo gcc -o xerxes xerxes.c
cd ..
############## Katana ########################################
git clone https://github.com/PowerScript/KatanaFramework.git
cd KatanaFramework
sudo sh dependencies
sudo python install
cd ..
############## Airogedden ########################################
git clone --depth 1 https://github.com/v1s1t0r1sh3r3/airgeddon.git
cd airgeddon
sudo bash airgeddon.sh
cd ..
################# EZSPLOIT #####################################
git clone https://github.com/rand0m1ze/ezsploit
chmod +x ezsploit.sh
###################### TheFatRat ############################
git clone https://github.com/Screetsec/TheFatRat.git
cd TheFatRat
sudo chmod +x setup.sh && ./setup.sh
./update && chmod +x setup.sh && ./setup.sh
chmod +x chk_tools 
./chk_too
cd ..
############## Cupp #############################################
git clone https://github.com/Mebus/cupp
chmod -R 755 cupp
##################################################################
git clone https://github.com/Screetsec/Dracnmap.git
cd Dracnmap
sudo chmod +x Dracnmap.sh 
cd ..
#################### KickThemOut ################################
sudo apt-get install nmap
git clone https://github.com/k4m4/kickthemout.git
cd kickthemout/
sudo -H pip3 install -r requirements.txt
cd ..
##################### Ghost-Phisher ##############################
git clone https://github.com/savio-code/ghost-phisher
#################### Sniper #######################################
git clone https://github.com/1N3/Sn1per
cd Sn1per
sudo bash install.sh
cd ..
################### Trity #######################################
git clone https://github.com/toxic-ig/Trity.git
cd Trity
sudo python install.py
cd ..
############### Angry IP Scanner ######################
sudo wget https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_all.deb
sudo chmod +x ipscan_3.7.6_all.deb 
sudo apt install ./ipscan_3.7.6_all.deb 
cd ..
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
echo -e "All done here, type air-script in terminal or ./air-script.sh to start..."
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
