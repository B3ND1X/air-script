#!/bin/bash


clear
Red="\e[1;91m"      ##### Colors Used #####
Green="\e[0;92m"
Yellow="\e[0;93m"
Blue="\e[1;94m"
White="\e[0;97m"


banner () {        ##### Banner #####
echo -e "${Red}
 █    ██  ███▄    █  ██▓ ███▄    █   ██████ ▄▄▄█████▓ ▄▄▄       ██▓     ██▓    
 ██  ▓██▒ ██ ▀█   █ ▓██▒ ██ ▀█   █ ▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▓██▒    ▓██▒    
▓██  ▒██░▓██  ▀█ ██▒▒██▒▓██  ▀█ ██▒░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▒██░    ▒██░    
▓▓█  ░██░▓██▒  ▐▌██▒░██░▓██▒  ▐▌██▒  ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██░    ▒██░    
▒▒█████▓ ▒██░   ▓██░░██░▒██░   ▓██░▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒░██████▒░██████▒
░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒ ░▓  ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▒░▓  ░░ ▒░▓  ░
░░▒░ ░ ░ ░ ░░   ░ ▒░ ▒ ░░ ░░   ░ ▒░░ ░▒  ░ ░    ░      ▒   ▒▒ ░░ ░ ▒  ░░ ░ ▒  ░
 ░░░ ░ ░    ░   ░ ░  ▒ ░   ░   ░ ░ ░  ░  ░    ░        ░   ▒     ░ ░     ░ ░   
   ░              ░  ░           ░       ░                 ░  ░    ░  ░    ░  ░
                                                                                "
echo -e "${Yellow} \n            Uninstall Tool"
echo -e "${Green}\n           It's sad to see you go :("
echo -e "${Green}           If there anything I can do to make this script better feel free to contact me!"
echo -e "${Green}           Email me liam@liambendix.com"
}

menu () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Uninstall everything!"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Uninstall just tools but keep air script"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Uninstall Everything, Air Script sucks ballz lol.."
    uninstallALL
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Uninstall tools but keep Air Script.."
     uninstallTools
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

uninstallALL () {  
sudo rm -r /home/superuser/air-script
sudo rm -r /home/pi/air-script
sudo rm -r /root/home/air-script
sudo apt-get remove kali-anonsurf
sudo rm -r /usr/sbin/wifite

}


uninstallTools () { 
sudo rm -r tools
sudo apt-get remove kali-anonsurf
}

targeted () {
banner
menu
}

targeted