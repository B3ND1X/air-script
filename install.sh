#!/bin/bash

# Ensure script is running as root
if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi
echo "Please eneter your username (eg: Pi) " username
read username
# Color Definitions
Red="\e[1;91m"
Green="\e[0;92m"
Yellow="\e[0;93m"
Blue="\e[1;94m"
White="\e[0;97m"

# Banner function for introduction
banner () {
    echo -e "${Red}                    __   __   __   __     __  ___    "
    echo -e "${Red}             /\  | |__) /__\` /  \` |__) | |__)  |     "
    echo -e "${Red}            /~~\\ | |  \\ .__/ \\__, |  \\ | |     |     "
    echo -e "${Yellow} \n            Install Tool"
    echo -e "${Green}\n           WELCOME! HACK THE WORLD! HAPPY CRACKING!"
}

# Main menu for selecting options
menu() {
    echo -e "\n${Yellow}                      [ Select Option To Continue ]\n\n"
    echo -e "      ${Red}[${Blue}1${Red}] ${Green}Install Minimum Required Dependencies"
    echo -e "      ${Red}[${Blue}2${Red}] ${Green}Install All Dependencies"
    echo -e "      ${Red}[${Blue}3${Red}] ${Green}Select Specific Tools"
    echo -e "      ${Red}[${Blue}4${Red}] ${Green}Exit\n\n"

    while true; do
        echo -e "${Green}┌─[${Red}Select Option${Green}]──[${Red}~${Green}]─[${Yellow}Menu${Green}]:"
        read -p "└─────►$(tput setaf 7) " option
        case $option in
            1) installMin; break ;;
            2) installAll; break ;;
            3) selectTools; break ;;
            4) exit 0 ;;
            *) echo -e "${Red}Invalid option, please try again...";;
        esac
    done
}

# Install Minimum Dependencies
installMin() {
    clear
    echo "$(tput setaf 2)Installing minimum required dependencies..."
    apt-get update
    apt-get install -y aircrack-ng macchanger

    # Check if sendemail is installed, and remove it if found
    if dpkg -l | grep -q sendemail; then
        echo "$(tput setaf 2)Removing sendemail as it's incompatible with postfix..."
        apt-get remove --purge -y sendemail
    fi

    # Install postfix
    echo "$(tput setaf 2)Installing postfix..."
    apt-get install -y postfix

    # Make pwn.sh executable if not already
    chmod +x ./pwn.sh

    # Create a symbolic link for airscript to open pwn.sh from anywhere
    ln -sf $(pwd)/pwn.sh /usr/local/bin/airscript

    # Confirmation
    clear
    echo "$(tput setaf 2)The command 'airscript' is now available from any directory and will open pwn.sh."
    sleep 3
    clear
    permissions
    echo "$(tput setaf 2)Installation of minimal tools complete!"
    shortcut
}

# Install All Dependencies
installAll() {
    clear
    echo "$(tput setaf 2)Installing all selected dependencies, please wait..."
    apt-get update
    apt-get install -y aircrack-ng macchanger

    # Check if sendemail is installed, and remove it if found
    if dpkg -l | grep -q sendemail; then
        echo "$(tput setaf 2)Removing sendemail as it's incompatible with postfix..."
        apt-get remove --purge -y sendemail
    fi

    # Install postfix
    echo "$(tput setaf 2)Installing postfix..."
    apt-get install -y postfix

 # Create a symbolic link for airscript to open pwn.sh from anywhere
    ln -sf $(pwd)/pwn.sh /usr/local/bin/airscript

    # Ensure the tools directory exists
  
  


    # Change to the tools directory
    cd /home/$username/air-script/tools

    # Clone additional tools into the tools directory
    echo "Cloning additional tools into 

    git clone https://github.com/Und3rf10w/kali-anonsurf
    git clone https://github.com/derv82/wifite2.git
    git clone https://github.com/FluxionNetwork/fluxion.git
    git clone https://github.com/threat9/routersploit.git
    git clone https://github.com/Sleek1598/Zatacker.git
    git clone https://github.com/r00t-3xp10it/morpheus.git
    git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
    git clone https://github.com/Mebus/cupp
    git clone https://github.com/k4m4/kickthemout.git
    git clone https://github.com/savio-code/ghost-phisher.git
    git clone https://github.com/angryip/ipscan.git

    # Set the proper permissions for the tools
    chmod -R 755 *

    echo "All tools have been cloned into tools directory
    echo "Please go to tools directory and set up tools."
    sleep 5


    clear
    permissions  # Ensure the 'permissions' function exists
    
    echo "$(tput setaf 2)Installed successfully!"
    sleep 3
}


# Tool selection for individual installation
selectTools() {
    cd /home/$username/air-script/tools
    echo -e "\n${Yellow}         Select the tools you want to install:\n"
    tools=("aircrack-ng" "macchanger" "websploit" "wifiphisher" "fluxion" "wifite2" "anonsurf" "dracnmap" "morpheus" "kickthemout" "routersploit" "ghost-phisher" "zattacker" "airgeddon" "angryip")
    for i in "${!tools[@]}"; do
        echo -e "${Green}$((i+1))) ${tools[i]}"
    done
    echo -e "${Red}16) ${Green}Back to Menu"

    read -p "Select a tool to install: " tool_option

    case $tool_option in
        1) installTool "aircrack-ng";;
        2) installTool "macchanger";;
        3) installTool "websploit";;
        4) installTool "wifiphisher";;
        5) installTool "fluxion";;
        6) installTool "wifite2";;
        7) installTool "anonsurf";;
        8) installTool "dracnmap";;
        9) installTool "morpheus";;
        10) installTool "kickthemout";;
        11) installTool "routersploit";;
        12) installTool "ghost-phisher";;
        13) installTool "zattacker";;
        14) installTool "airgeddon";;
        15) installTool "angryip";;
        16) menu ;;
        *) echo -e "${Red}Invalid option, please try again.";;
    esac
}

# Function to install a specific tool
installTool() {
    cd /home/$username/air-script/tools
    tool=$1
    echo "Installing $tool..."
    case $tool in
        "aircrack-ng") sudo apt install -y aircrack-ng ;;
        "macchanger") sudo apt install -y macchanger ;;
        "websploit") sudo apt install -y websploit ;;
        "wifiphisher") sudo apt install -y wifiphisher ;;
        "fluxion") git clone https://github.com/FluxionNetwork/fluxion.git ;;
        "wifite2") git clone https://github.com/derv82/wifite2.git ;;
        "anonsurf") git clone https://github.com/Und3rf10w/kali-anonsurf ;;
        "dracnmap") git clone https://github.com/Screetsec/Dracnmap.git ;;
        "morpheus") git clone https://github.com/r00t-3xp10it/morpheus.git ;;
        "kickthemout") git clone https://github.com/k4m4/kickthemout.git ;;
        "routersploit") git clone https://github.com/threat9/routersploit.git ;;
        "ghost-phisher") git clone https://github.com/savio-code/ghost-phisher.git ;;
        "zattacker") git clone https://github.com/Sleek1598/Zatacker.git ;;
        "airgeddon") git clone --depth 1 https://github.com/v1s1t0r1sh3r3/airgeddon.git ;;
        "angryip") git clone https://github.com/angryip/ipscan.git ;;
        *) echo -e "${Red}Invalid tool specified."; return ;;
    esac
    echo "$tool Download successfully!"
      echo  "Please go to tools directory and set up tools."
    sleep 5
}

# Permissions function
permissions () {
    clear
    echo "$(tput setaf 2)Fixing permissions..."
    sleep 5
    cd /home/$username/air-script
    }

# Run the banner and main menu
banner
menu
