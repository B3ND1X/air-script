# Raspberry Pi Setup Guide

## Table of Contents
1. [Setting Up and Usage of Air Script](#setting-up-and-usage-of-air-script)
2. [How to Set Up a Headless Pi with SSH](#how-to-set-up-a-headless-pi-with-ssh)
    - [Modify the pwn.sh Script](#modify-the-pwnsh-script)
    - [Modify the airmon-ng Check Kill Command](#modify-the-airmon-ng-check-kill-command)
    - [Run the Air Script](#run-the-air-script)
    - [Wireless Adapter Interface Naming and Monitor Mode](#wireless-adapter-interface-naming-and-monitor-mode)
    - [Preventing airodump-ng from Killing Processes](#preventing-airodump-ng-from-killing-processes)
    - [Disabling Power Saving for Better Performance](#disabling-power-saving-for-better-performance)
    - [Reboot the Raspberry Pi](#reboot-the-raspberry-pi)
3. [Setting Up SSH on a Headless Raspberry Pi](#setting-up-ssh-on-a-headless-raspberry-pi)

---

## Setting Up and Usage of Air Script

### Modify the pwn.sh Script:
1. Open the `pwn.sh` script and navigate to line 15.
2. Change the line from:
    ```bash
    cd /home/*/air-script
    ```
    to:
    ```bash
    cd /home/YOURUSERNAME/air-script
    ```
    Replace `YOURUSERNAME` with the username you use to log into your Raspberry Pi.

### Modify the airmon-ng Check Kill Command:
1. Locate the line containing `airmon-ng check kill` and either remove it or comment it out by adding a `#` at the beginning of the line.
2. As of the time of writing, this line is at line 611. Please be aware that this may change if the script is updated.

### Run the Air Script:
1. When running the air script, use the following commands:
    ```bash
    tmux
    sudo airscript
    ```
2. To scroll within tmux, press `Ctrl + B` followed by `[`.
3. To exit the scroll mode, press `q`.

---

## Wireless Adapter Interface Naming and Monitor Mode:

Some wireless adapters may have unusual names, which can make it difficult or frustrating to set the network interface card (NIC) into monitor mode. To rename the interface, use the following commands:

### Rename the Network Interface:
```bash
sudo ip link set YOURINTERFACE down
sudo ip link set YOURINTERFACE name wlan1
sudo ip link set wlan1 up ```


You can replace `wlan1` with any name you prefer. This is just an example.

 **Note:** Although the name of the interface will change to `wlan1`, the interface will still be in monitor mode, even though it may no longer display "mon" in its name. Both monitor and managed modes will appear as `wlan1`.

### Make the Change Permanent:

You can persist this change across reboots by modifying the udev rules or using `systemd.networkd` for automatic configuration.

### Preventing airodump-ng from Killing Processes:

If you experience issues with the airodump-ng process being killed unexpectedly, you can avoid this by downloading and installing a desktop environment or setting up a VNC server for graphical access.

### Disabling Power Saving for Better Performance:

To improve performance, particularly with wireless network interfaces, it can be helpful to disable power-saving features. Use the following steps:

#### Disable CPU Frequency Scaling:
1. Open the config file:
   ```bash
   sudo nano /boot/config.txt

    Add the following line at the end of the file:

    force_turbo=1

Disable Wi-Fi Power Saving:

    If you are using a static IP configuration, edit the network interfaces file:

sudo nano /etc/network/interfaces

Add this line under the wlan0 configuration:

    wireless-power off

Alternatively, if you're using wpa_supplicant, add the following:

sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

Add:

iwconfig wlan0 power off

Disable USB Suspend:

    Edit the rc.local file:

sudo nano /etc/rc.local

Add the following lines before exit 0:

    echo on > /sys/bus/usb/devices/usb1/power/control
    echo on > /sys/bus/usb/devices/usb2/power/control

Disable HDMI Power Saving:

    Edit the config file:

sudo nano /boot/config.txt

Add:

    hdmi_blanking=0

Disable Display Power Management Signaling (DPMS):

    Run the following command to disable DPMS:

    xset -dpms

Reboot the Raspberry Pi:

To apply all the changes, reboot your Raspberry Pi:

sudo reboot

    Important Notes:
    Use power-saving features sparingly: Disabling power-saving can improve performance but may increase energy consumption, so only disable these features when necessary.

How to Set Up a Headless Pi with SSH
Prerequisites:

    A Raspberry Pi (any model)
    A microSD card (8GB or more recommended)
    A computer with an SD card reader
    A network connection (either Wi-Fi or Ethernet)
    A power supply for the Raspberry Pi

Step 1: Prepare the microSD Card

    Download Raspberry Pi OS:
    Visit the official Raspberry Pi Downloads page and download the latest version of Raspberry Pi OS (Raspberry Pi OS Lite is recommended for headless setups).

    Write Raspberry Pi OS to the microSD Card:
    Use a tool like Raspberry Pi Imager, Balena Etcher, or Win32DiskImager to write the downloaded image to the microSD card.
    If using Raspberry Pi Imager, select the Raspberry Pi OS image, choose the target device (your microSD card), and click "Write."
    If using Balena Etcher, select the downloaded image, choose the microSD card as the target, and click "Flash."

    Eject the microSD card once the image has been written successfully.

Step 2: Enable SSH

    Access the Boot Partition:
    Once the image is written, the microSD card will have two partitions: one is the boot partition, and the other is the root filesystem.
    Insert the microSD card into your computer and open the boot partition. This should be accessible as a normal drive on your computer.

    Create an Empty SSH File:
    In the boot partition, create an empty file named ssh (without any extension).
    On Linux/macOS, you can create this file using the following command in the terminal:

    touch /path/to/boot/partition/ssh

    On Windows, simply right-click in the boot directory, select New > Text Document, and rename the file to ssh (no extension). Ensure the file extension is removed.

    Eject the microSD card safely from your computer.

Step 3: Set Up Wi-Fi (if using Wi-Fi)

    Create a wpa_supplicant.conf File:
    In the boot partition, create a file named wpa_supplicant.conf with the following content:

    country=US # Change this to your country code (e.g., GB for the UK, FR for France)
    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    update_config=1
    network={
        ssid="YourWiFiNetworkName"
        psk="YourWiFiPassword"
    }

    Replace "YourWiFiNetworkName" with the name of your Wi-Fi network and "YourWiFiPassword" with your Wi-Fi password.
    Save and close the file.

    Eject the microSD card from your computer.

Step 4: Insert the microSD Card and Power Up the Raspberry Pi

    Insert the prepared microSD card into your Raspberry Pi.

    Connect the Raspberry Pi to your network:
        If using Wi-Fi, ensure your Wi-Fi network is available.
        If using Ethernet, connect an Ethernet cable from your Raspberry Pi to your router.

    Plug in the power supply to boot the Raspberry Pi.

Step 5: Find the Raspberry Pi's IP Address

To connect via SSH, you need to know the Raspberry Pi’s IP address.

    Option 1: Use Your Router's Admin Page
    Log into your router’s admin page (usually accessed by entering 192.168.1.1 or 192.168.0.1 in a browser).
    Look for a list of connected devices and find your Raspberry Pi by its hostname (default is usually raspberrypi).

    Option 2: Use a Network Scanning Tool
    Use tools like Fing (available for Android/iOS) or Advanced IP Scanner (for Windows) to scan your network and identify the IP address of the Raspberry Pi.

    Option 3: Use mDNS (Bonjour) on Linux/macOS
    On a Linux or macOS computer, you can use ping to find the Raspberry Pi by hostname:

    ping raspberrypi.local

Step 6: Connect via SSH

    Open a terminal (Linux/macOS) or Command Prompt (Windows) on your computer.

    Use SSH to connect to your Raspberry Pi. Replace IP_ADDRESS with the actual IP address of your Raspberry Pi:

    ssh pi@IP_ADDRESS

    The default username is pi, and the default password is raspberry.

    If you’re using Windows, you can use an SSH client like PuTTY instead of the terminal.

    First-time login:
    On the first connection, you may receive a warning about the authenticity of the host. Type yes to proceed.
    Enter the default password (raspberry) when prompted.

Step 7: Change the Default Password

Once logged in via SSH, it’s a good practice to change the default password for security.

passwd

Enter the current password (raspberry) and then type a new password twice.
Step 8: Update the System

It's always a good idea to update the system after setting up your Raspberry Pi.

sudo apt update
sudo apt upgrade -y

Reboot the Raspberry Pi:

sudo reboot

Step 9: Optional - Set a Static IP (Optional)

If you’d like to set a static IP address for your Raspberry Pi, follow these steps:

    Edit the dhcpcd.conf file:

sudo nano /etc/dhcpcd.conf

Add the following lines at the end of the file (replace x with appropriate values for your network):

interface wlan0
static ip_address=192.168.x.x/24
static routers=192.168.x.1
static domain_name_servers=8.8.8.8 8.8.4.4

Save and exit the editor (press Ctrl+X, then Y to confirm, and Enter).

Restart the Raspberry Pi:

    sudo reboot

Conclusion

Now, your Raspberry Pi should be fully set up and accessible via SSH on your network. You can access it remotely without needing a monitor, keyboard, or mouse, and perform tasks using the terminal or other software tools.


