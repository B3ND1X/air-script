#!/bin/bash

# Ensure script is running as root
if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ORIGINAL_DIR="$SCRIPT_DIR"

current_user="$(logname 2>/dev/null || whoami)"
if [ -z "$current_user" ]; then
  echo "Unable to determine current user."
  exit 1
fi

# Prefer a predictable install location so the tool can be used from anywhere
TARGET_DIR="/opt/airscript"

relocate_repo_if_needed() {
    local target="$1"

    # If we're already in the target directory, nothing to do
    if [ "$SCRIPT_DIR" = "$target" ]; then
        base_dir="$SCRIPT_DIR"
        return
    fi

    echo "Relocating Air-Script from $SCRIPT_DIR to $target ..."
    mkdir -p "$target"

    if command -v rsync >/dev/null 2>&1; then
        rsync -a --delete "$SCRIPT_DIR"/ "$target"/ || { echo "Relocation with rsync failed."; exit 1; }
    else
        cp -a "$SCRIPT_DIR"/. "$target"/ || { echo "Relocation with cp failed."; exit 1; }
    fi

    base_dir="$target"

    # Remove the old copy to keep things tidy
    if [ -d "$SCRIPT_DIR" ]; then
        rm -rf "$SCRIPT_DIR"
    fi

    echo "Air-Script is now located at $base_dir"
}

relocate_repo_if_needed "$TARGET_DIR"

# Base directory for the install now reflects the relocated path
: "${base_dir:=$TARGET_DIR}"
mkdir -p "$base_dir"
cd "$base_dir" || exit 1

# Update pwn.sh paths if any legacy /home/*/air-script placeholders exist
placeholder_count=$(grep -c "/home/\*/air-script" "$base_dir/pwn.sh" || true)
if [ "$placeholder_count" -gt 0 ]; then
  sed -i "s|/home/\*/air-script|$base_dir|g" "$base_dir/pwn.sh"
  echo "pwn.sh has been updated for path: $base_dir"
else
  echo "No /home/*/air-script placeholders found in pwn.sh; leaving paths unchanged."
fi

# Color Definitions
Red="\e[1;91m"
Green="\e[0;92m"
Yellow="\e[0;93m"
Blue="\e[1;94m"
White="\e[0;97m"

run_postfix_setup() {
    local postfix_script="$base_dir/setup_postfix.sh"

    if [ ! -f "$postfix_script" ]; then
        echo "Postfix setup script not found at $postfix_script, skipping Postfix automation."
        return
    fi

    echo -n "Run Postfix setup now (uses setup_postfix.sh)? [Y/n]: "
    read -r choice
    case "$choice" in
        [Nn]*) echo "Skipping Postfix setup per request."; return ;;
        *) ;;
    esac

    chmod +x "$postfix_script"
    echo "Running Postfix setup..."
    if bash "$postfix_script"; then
        echo "Postfix setup completed."
    else
        echo "Postfix setup encountered issues. Please review $postfix_script output."
    fi
}

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
    # Core tooling needed by pwn.sh (mail/curl/tshark/xterm for notifications & uploads)
    sudo apt install -y \
        arp-scan dsniff aircrack-ng net-tools iw macchanger \
        xterm tshark tmux mailutils curl postfix
    # Check if sendemail is installed, and remove it if found
    if dpkg -l | grep -q sendemail; then
        echo "$(tput setaf 2)Removing sendemail as it's incompatible with postfix..."
        apt-get remove --purge -y sendemail
    fi

    # Postfix configuration helper
    run_postfix_setup

    # Make pwn.sh executable if not already
    chmod +x "$base_dir/pwn.sh"

    # Create a symbolic link for airscript to open pwn.sh from anywhere
    ln -sf "$base_dir/pwn.sh" /usr/local/bin/airscript

    # Confirmation
    clear
    echo "$(tput setaf 2)The command 'airscript' is now available from any directory and will open pwn.sh."
    echo "$(tput setaf 2)Air-Script installed to: $base_dir"
    echo "$(tput setaf 2)Run it anytime with: sudo airscript"
    sleep 3
    clear
    permissions
    echo "$(tput setaf 2)Installation of minimal tools complete!"
    
}

# Install All Dependencies

installAll () {
    
   installMin

    # Define the tools directory
    tools_dir="$base_dir/tools"

    # Ensure the tools directory exists
    mkdir -p "$tools_dir"

    # Change to the tools directory
    if ! cd "$tools_dir"; then
        echo "Failed to change directory to $tools_dir"
        return 1
    fi

    # Clone additional tools into the tools directory
    echo "Cloning additional tools into $tools_dir"


# 1. kali-anonsurf
git clone https://github.com/Und3rf10w/kali-anonsurf.git
cd kali-anonsurf
chmod +x kali-anonsurf.sh
cd ..

# 2. wifite2
git clone https://github.com/derv82/wifite2.git
cd wifite2
sudo apt install python3-pip
sudo pip3 install -r requirements.txt
cd ..

# 3. fluxion
git clone https://github.com/FluxionNetwork/fluxion.git
cd fluxion
cd ..

# 4. routersploit
git clone https://github.com/threat9/routersploit.git
cd routersploit
sudo apt install python3-pip
sudo pip3 install -r requirements.txt
cd ..

# 5. Zatacker
git clone https://github.com/Sleek1598/Zatacker.git
cd Zatacker
sudo apt install python3-pip
sudo pip3 install -r requirements.txt
cd ..

# 6. morpheus
git clone https://github.com/r00t-3xp10it/morpheus.git
cd morpheus
sudo apt install python3-pip
sudo pip3 install -r requirements.txt
cd ..

# 7. airgeddon
git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
cd airgeddon
chmod +x airgeddon.sh
cd ..

# 8. cupp
git clone https://github.com/Mebus/cupp.git
cd cupp
chmod +x cupp.py
cd ..

# 9. kickthemout
git clone https://github.com/k4m4/kickthemout.git
cd kickthemout
sudo apt install python3-pip
sudo pip3 install -r requirements.txt
cd ..

# 10. ghost-phisher
git clone https://github.com/savio-code/ghost-phisher.git
cd ghost-phisher
sudo apt install python3-pip
sudo pip3 install -r requirements.txt
cd ..

# 11. angryip
git clone https://github.com/angryip/ipscan.git
cd ipscan
sudo apt install qt5-qmake qtbase5-dev-tools qtchooser qtbase5-dev
qmake
make
cd ..

    


    # Set proper permissions for the tools
    echo "Setting permissions for all tools..."
    chmod -R 755 "$tools_dir"

    echo "All tools have been cloned into the tools directory."
    echo "Please go to the tools directory and set up tools if necessary."
    sleep 5

    clear

    # Ensure the 'permissions' function exists and call it
    if type permissions &>/dev/null; then
        permissions
    else
        echo "Warning: 'permissions' function not found."
    fi

    echo "$(tput setaf 2)Installed successfully!"
    sleep 3
}


# Tool selection for individual installation
selectTools() {
    mkdir -p "$base_dir/tools"
    cd "$base_dir/tools" || return
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
    cd "$base_dir/tools" || return
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

raspberry_pi_setup() {
    if ! grep -q "Raspberry Pi" /proc/cpuinfo; then
        echo "Non-Raspberry Pi system detected. Skipping Raspberry Pi-specific installations."
        return
    fi

    echo "Raspberry Pi detected. Installing Raspberry Pi specific packages..."

    # Install necessary packages for Raspberry Pi (e.g., X11, if needed for running xterm or GUI-based apps)
    sudo apt update
    sudo apt install -y x11-xserver-utils xterm xvfb

    local script_path="$base_dir/pwn.sh"

    # Remove lines containing 'airmon-ng check kill' from pwn.sh
    if [[ -f "$script_path" ]]; then
      sed -i '/airmon-ng check kill/d' "$script_path"
      echo "Lines containing 'airmon-ng check kill' have been removed from $script_path."
    else
      echo "Error: $script_path not found. Please ensure the file exists."
      return 1
    fi

    # Remove setuid permission from xterm
    if ! sudo chmod u-s /usr/bin/xterm; then
      echo "Error: Failed to remove setuid permission from /usr/bin/xterm."
      return 1
    fi

    # Run the pwn.sh script using xvfb-run
    if [[ -f "$script_path" ]]; then
      sudo xvfb-run "$script_path"
    else
      echo "Error: $script_path not found. Please ensure the file exists."
      return 1
    fi
}

# Permissions function
permissions () {
    clear
    echo "$(tput setaf 2)Fixing permissions..."
    sleep 5
    cd "$base_dir" 2>/dev/null || return 0
    sudo chmod -R 755 "$base_dir" > /dev/null 2>&1
    sudo chown -R "$current_user:$current_user" "$base_dir" > /dev/null 2>&1
    }

# Run Raspberry Pi adjustments (if applicable), then show the menu
raspberry_pi_setup
banner
menu
