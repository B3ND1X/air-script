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
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Install Minimum Required Dependencies"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Install All Dependencies"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Select What To Install To Save Space"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Install Minimum Required Dependencies..."
    installMin
    exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Install All Dependencies..."
    installAll
    exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Select What To Install..."
    selectTool
    exit 0
     ;;
  4) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}




installMin () {
clear
echo "$(tput setaf 2)Installing everything for you! Please wait..."
sleep 5
clear
apt-get update
##################### aircrack-ng ##################### 
sudo apt-get install -y aircrack-ng
##################### macchanger ##################### 
sudo apt-get install -y macchanger
######################## email #########################
sudo apt-get install postfix
sudo apt-get install sendemail
sudo apt install postfix
sudo apt install sendemail
clear
echo "$(tput setaf 2)Fixing permissions..."
sleep 5
cd
chmod -R 755 air-script
clear
echo -e "Air Script and tools installed!"
	sleep 2
	echo "$(tput setaf 2)DONE!"
	sleep 3
	echo "$(tput setaf 2)Be safe and happy cracking! :) "
	sleep 3
	clear
	shortcut
}


installAll () {
clear
echo "$(tput setaf 2)Installing everything for you! Please wait..."
sleep 5
clear
apt-get update
cd /bin/air-script/tools
##################### aircrack-ng ##################### 
sudo apt-get install -y aircrack-ng
##################### macchanger ##################### 
sudo apt-get install -y macchanger
######################## email #########################
sudo apt-get install postfix
sudo apt-get install sendemail
sudo apt install postfix
sudo apt install sendemail
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
#sudo bash airgeddon.sh
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
########################## SETOOLKIT #############################
git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/
cd setoolkit
pip3 install -r requirements.txt
python setup.py
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
sudo chmod +x *.deb 
sudo dpkg -i *.deb
################### RED HAWK ##########################
git clone https://github.com/Tuhinshubhra/RED_HAWK
echo "$(tput setaf 2) Red Hawk Download complete.."
sleep 3
echo "$(tput setaf 2) Run Fix option in Red Hawk to install.."
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
echo "$(tput setaf 2)Be safe and happy cracking! :) "
sleep 2
clear
shortcut

}


shortcut () {
while true; do
    read -p "Do you want to add a Desktop shortcut so air-script is easier to find and launch? (You can move and delete it later)" yn
    case $yn in
        [Yy]* ) shortcutYes; break;;
        [Nn]* ) shortcutNo;;
        * ) echo "Please answer yes or no.";;
    esac
done
}

shortcutYes () {
echo "Your current directory:"
pwd
read -p "Where do you want the launcher? : " launcher
launcher
cd $launcher
wget https://github.com/B3ND1X/air-script-img/releases/download/desktop/air-script.desktop
sudo chmod -R 755 AIR-SCRIPT.desktop

}

shortcutNo () {
exit

}


AddPath () { 
	mkdir /bin/air-script
	echo -e "Preparing to install..."
	sleep 1
	echo "Enter your username (e.g. 'root': " username
	read username
	echo -e "Copying files to /bin/air-script... please wait!"
	sleep 2
	cp /home/$username/air-script/* /bin/air-script
	cp -R /home/$username/air-script/logs /bin/air-script
	cp -R /home/$username/air-script/tools /bin/air-script
	cp -R /home/$username/air-script/img /bin/air-script
	echo -e "Done"
	clear
	echo -e "Fixing permissions..."
	sleep 1
	sudo chmod -R 755 /bin/air-script/*
	sudo chmod -R 755 /bin/air-script/logs/*
	sudo chmod -R 755 /bin/air-script/tools/*
	sudo chmod -R 755 /bin/air-script/img/*
	echo -e "Done"
	sleep 1
	clear
	echo -e "Adding air-script to PATH so you can access it from anywhere"
	sleep 1
	export PATH=/bin/air-script:$PATH
	sleep 1
	echo "export PATH=/bin/air-script:$PATH" >> ~/.bashrc
	sleep 1
	clear
	break
	clear
	echo -e "DONE"
	sleep 1
	clear
	echo -e "All done here, type air-script in terminal to find it faster..."
	sleep  3
	echo -e "Please choose what tools air-script should install for you."
	sleep 2
	menu
	
	 
}


selectTool () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Aircrack-ng"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Macchanger"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Websploit"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Wifiphisher"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Anonsurf"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Wifite"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}BeeLogger"
echo -e "      ${Red}[${Blue}8${Red}] ${Green}Zirikatu"
echo -e "      ${Red}[${Blue}9${Red}] ${Green}Routersploit"
echo -e "      ${Red}[${Blue}10${Red}] ${Green}Zatacker"
echo -e "      ${Red}[${Blue}11${Red}] ${Green}Hakku"
echo -e "      ${Red}[${Blue}12${Red}] ${Green}Morpheus"
echo -e "      ${Red}[${Blue}13${Red}] ${Green}Xerxes"
echo -e "      ${Red}[${Blue}14${Red}] ${Green}Katana"
echo -e "      ${Red}[${Blue}15${Red}] ${Green}Airogeddon"
echo -e "      ${Red}[${Blue}16${Red}] ${Green}Ezsploit"
echo -e "      ${Red}[${Blue}17${Red}] ${Green}TheFatRat"
echo -e "      ${Red}[${Blue}18${Red}] ${Green}Cupp"
echo -e "      ${Red}[${Blue}19${Red}] ${Green}Dracnmap"
echo -e "      ${Red}[${Blue}20${Red}] ${Green}KickThemOut"
echo -e "      ${Red}[${Blue}21${Red}] ${Green}Ghost-Phisher"
echo -e "      ${Red}[${Blue}22${Red}] ${Green}Sn1per"
echo -e "      ${Red}[${Blue}23${Red}] ${Green}Trity"
echo -e "      ${Red}[${Blue}24${Red}] ${Green}Angry IP Scanner"
echo -e "      ${Red}[${Blue}25${Red}] ${Green}Red Hawk"
echo -e "      ${Red}[${Blue}26${Red}] ${Green}Setoolkit"
echo -e "      ${Red}[${Blue}27${Red}] ${Green}Air Script Email Notifications"
echo -e "      ${Red}[${Blue}28${Red}] ${Green}Fluxion"
echo -e "      ${Red}[${Blue}29${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Installing Aircrack-ng..."
    aircrack
    exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Installing Macchanger..."
     macchanger
     exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Installing Websploit..."
     websploit
     exit 0
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Installing Wifiphisher..."
     wifiphisher
     exit 0
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Installing Anonsurf..."
     anonsurf
     exit 0
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 Installing Wifite..."
     wifite
     exit 0
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Installing Fluxion..."
     fluxion
     exit 0
     ;;
  8) echo -e "\n[${Green}Selected${White}] Option 8 Installing BeeLogger..."
     beelogger
     exit 0
     ;;
  9) echo -e "\n[${Green}Selected${White}] Option 9 Installing Zirikatu..."
     zirikatu
     exit 0
     ;;
  10) echo -e "\n[${Green}Selected${White}] Option 10 Installing Zatacker..."
     zatacker
     exit 0
     ;;
  11) echo -e "\n[${Green}Selected${White}] Option 11 Installing Hakku..."
     hakku
     exit 0
     ;;
  12) echo -e "\n[${Green}Selected${White}] Option 12 Installing Morpheus..."
     morpheus
     exit 0
     ;;
  13) echo -e "\n[${Green}Selected${White}] Option 13 Installing Xerxes..."
     xerxes
     exit 0
     ;;
  14) echo -e "\n[${Green}Selected${White}] Option 14 Installing Katana..."
     katana
     exit 0
     ;;
  15) echo -e "\n[${Green}Selected${White}] Option 15 Installing Airogeddon..."
     airogeddon
     exit 0
     ;;
  16) echo -e "\n[${Green}Selected${White}] Option 16 Installing Ezsploit..."
     ezsploit
     exit 0
     ;;
  17) echo -e "\n[${Green}Selected${White}] Option 17 Installing TheFatRat..."
     thefatrat
     exit 0
     ;;
  18) echo -e "\n[${Green}Selected${White}] Option 18 Installing Cupp..."
     cupp
     exit 0
     ;;
  19) echo -e "\n[${Green}Selected${White}] Option 19 Installing Dracnmap..."
     dracnmap
     exit 0
     ;;
  20) echo -e "\n[${Green}Selected${White}] Option 20 Installing KickThemOut..."
     kickthemout
     exit 0
     ;;
  21) echo -e "\n[${Green}Selected${White}] Option 21 Installing Ghost-Phisher..."
     ghostphisher
     exit 0
     ;;
  22) echo -e "\n[${Green}Selected${White}] Option 22 Installing Sn1per..."
     sn1per
     exit 0
     ;;
  23) echo -e "\n[${Green}Selected${White}] Option 23 Installing Trity..."
     trity
     exit 0
     ;;
  24) echo -e "\n[${Green}Selected${White}] Option 24 Installing Angry IP Scanner..."
      angryipscanner
     exit 0
     ;;
  25) echo -e "\n[${Green}Selected${White}] Option 25 Installing Red Hawk..."
     redhawk
     exit 0
     ;;
  26) echo -e "\n[${Green}Selected${White}] Option 26 Installing Red Hawk..."
     setoolkit
     exit 0
     ;;
  27) echo -e "\n[${Green}Selected${White}] Option 27 Installing Postfix and Sendemail... Air Script needs this for notifications! Please wait..."
     email
     exit 0
     ;;
  28) echo -e "\n[${Green}Selected${White}] Option 28 Installing fluxion..."
     fluxion
     exit 0
     ;;
  29) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}
########################## List of tools #########################################

aircrack () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
apt-get update
sudo apt-get install -y aircrack-ng
}


macchanger () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
apt-get update
sudo apt-get install -y macchanger
}

websploit () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
apt-get update
sudo apt-get install websploit
}

wifiphisher () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
apt-get update
sudo apt install -y wifiphisher 
}

anonsurf () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
apt-get update
git clone https://github.com/Und3rf10w/kali-anonsurf
chmod -R 755 kali-anonsurf
cd kali-anonsurf
./installer.sh
apt install ./kali-anonsurf.deb

}

wifite () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/derv82/wifite2.git

}

fluxion () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
air-script
cd /bin/air-script/tools
git clone https://www.github.com/FluxionNetwork/fluxion.git
chmod -R 755 fluxion
cd fluxion
sudo ./fluxion.sh -i
}


beelogger () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/4w4k3/BeeLogger.git
cd BeeLogger
sudo chmod +x install.sh
./install.sh
}

zirikatu () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/pasahitz/zirikatu
chmod -R 755 zirikatu
}

routersploit () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
apt-get install python3-pip
git clone https://www.github.com/threat9/routersploit
cd routersploit
python3 -m pip install -r requirements.txt
}

zatacker () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/Sleek1598/Zatacker.git
cd Zatacker
chmod +x setup.sh
echo "$(tput setaf 2)When asked for filepath, please specify or click enter for default"
sleep 3
./setup.sh
}

hakku () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/4shadoww/hakkuframework
chmod -R 755 hakkuframework
cd hakkuframework
./isntall
}

morpheus () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/r00t-3xp10it/morpheus.git
cd morpheus
chmod -R +x *.sh
chmod -R +x *.py
echo "$(tput setaf 2)Edit morpheus settings... click Crtl + X when done. Please wait.."
sleep 5
nano settings
}

xerxes () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/XCHADXFAQ77X/XERXES
cd XERXES
chmod +x xerxes
sudo gcc -o xerxes xerxes.c
}

katana () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/PowerScript/KatanaFramework.git
cd KatanaFramework
sudo sh dependencies
sudo python install
}

airogeddon () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone htt
git clone --depth 1 https://github.com/v1s1t0r1sh3r3/airgeddon.git
cd airgeddon
sudo bash airgeddon.sh
}

ezsploit () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/rand0m1ze/ezsploit
chmod +x ezsploit.sh
}

thefatrat () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/Screetsec/TheFatRat.git
cd TheFatRat
sudo chmod +x setup.sh && ./setup.sh
./update && chmod +x setup.sh && ./setup.sh
chmod +x chk_tools 
./chk_too
}

cupp () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/Mebus/cupp
chmod -R 755 cupp
}

dracnmap () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/Screetsec/Dracnmap.git
sudo chmod +x Dracnmap.sh 
}

kickthemout () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
sudo apt-get install nmap
git clone https://github.com/k4m4/kickthemout.git
cd kickthemout/
sudo -H pip3 install -r requirements.txt
}

ghostphisher () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/savio-code/ghost-phisher
}

sn1per () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/1N3/Sn1per
cd Sn1per
sudo bash install.sh
}

trity () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/toxic-ig/Trity.git
cd Trity
sudo python install.py
}

angryipscanner () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
sudo wget https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_all.deb
sudo chmod +x *.deb
sudo apt install ./*.deb 
}

redhawk () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/Tuhinshubhra/RED_HAWK
echo "$(tput setaf 2) Red Hawk Download complete.."
sleep 3
echo "$(tput setaf 2) Run Fix option in Red Hawk to install.."

}



setoolkit () {
clear
echo "$(tput setaf 2)Installing... Please wait..."
sleep 5
clear
cd /bin/air-script/tools
git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/
cd setoolkit
pip3 install -r requirements.txt
python setup.py

}



email () {
sudo apt-get install postfix
sudo apt-get install sendemail
sudo apt install postfix
sudo apt install sendemail


}











############# End of tools ########################################################

targeted () {
banner
AddPath
}

targeted
