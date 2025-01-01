#!/bin/bash

# Ensure the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please run with sudo." 
   exit 1
fi
# Define the file path
file="pwn.sh"

# Check if the file exists
if [[ ! -f "$file" ]]; then
    echo "File $file does not exist."
    exit 1
fi

# Remove lines containing 'airmon-ng check kill'
sed -i '/airmon-ng check kill/d' "$file"

# Confirm that the lines were removed
echo "Lines containing 'airmon-ng check kill' have been removed from $file."

# Variables
INTERFACE="YOURINTERFACE"  # Replace with your actual interface name
NEW_INTERFACE_NAME="wlan1"
XVFB_DISPLAY=":1"
SCREEN_RESOLUTION="1024x768x24"
SCRIPT_TO_RUN="airscript"  # Replace with the path to your script

# Bring down the network interface
echo "Bringing down the network interface $INTERFACE..."
ip link set "$INTERFACE" down

# Rename the network interface
echo "Renaming $INTERFACE to $NEW_INTERFACE_NAME..."
ip link set "$INTERFACE" name "$NEW_INTERFACE_NAME"

# Bring up the renamed network interface
echo "Bringing up the network interface $NEW_INTERFACE_NAME..."
ip link set "$NEW_INTERFACE_NAME" up

# Remove the setuid bit from xterm for security reasons
echo "Removing setuid bit from /usr/bin/xterm..."
chmod u-s /usr/bin/xterm

# Set the DISPLAY environment variable
export DISPLAY="$XVFB_DISPLAY"

# Check if Xvfb is already running on the desired display
if pgrep -f "Xvfb $XVFB_DISPLAY" > /dev/null; then
    echo "Xvfb is already running on display $XVFB_DISPLAY. Terminating existing instance..."
    pkill -f "Xvfb $XVFB_DISPLAY"
fi

# Remove any existing Xvfb lock file
LOCK_FILE="/tmp/.X1-lock"
if [ -e "$LOCK_FILE" ]; then
    echo "Removing existing Xvfb lock file..."
    rm -f "$LOCK_FILE"
fi

# Start Xvfb in the background
echo "Starting Xvfb on display $XVFB_DISPLAY with resolution $SCREEN_RESOLUTION..."
Xvfb "$XVFB_DISPLAY" -screen 0 "$SCREEN_RESOLUTION" &

# Give Xvfb time to start
sleep 2

# Start a new tmux session and run the script using xvfb-run
echo "Starting tmux session and running the script..."
tmux new-session -d -s my_session "sudo xvfb-run -a $SCRIPT_TO_RUN"

echo "Script execution initiated in tmux session 'my_session'."