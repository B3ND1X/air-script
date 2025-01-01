#!/bin/bash

# Variables
INTERFACE="YOURINTERFACE"  # Replace with your actual interface name
NEW_NAME="wlan1"
SCRIPT="./pwn.sh"          # Path to the pwn.sh script

# Ensure the INTERFACE variable is not empty
if [[ -z "$INTERFACE" ]]; then
  echo "Error: INTERFACE is not set. Please set it before running the script."
  exit 1
fi

# Set the interface
sudo ip link set "$INTERFACE" down
sudo ip link set "$INTERFACE" name "$NEW_NAME"
sudo ip link set "$NEW_NAME" up
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to rename the interface. Check the interface name or permissions."
  exit 1
fi

# Remove lines containing 'airmon-ng check kill' from pwn.sh
if [[ -f "$SCRIPT" ]]; then
  sed -i '/airmon-ng check kill/d' "$SCRIPT"
  echo "Lines containing 'airmon-ng check kill' have been removed from $SCRIPT."
else
  echo "Error: $SCRIPT not found. Please ensure the file exists."
  exit 1
fi

# Remove setuid permission from xterm
sudo chmod u-s /usr/bin/xterm
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to remove setuid permission from /usr/bin/xterm."
  exit 1
fi

# Run the pwn.sh script using xvfb-run
if [[ -f "$SCRIPT" ]]; then
  sudo xvfb-run "$SCRIPT"
else
  echo "Error: $SCRIPT not found. Please ensure the file exists."
  exit 1
fi

echo "Done, pwn.sh is ready to run."