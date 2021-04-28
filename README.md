### CHANGELOG
v 1.0.3
* Added Wifiphisher to wifi tools
* Added Zatacker to extra tools
* Added Routerploit to extra tools
* Updated installer and uninstaller
* Small bug fixes and typos


v 1.0.2
* Extra tools option
* Added Zirikatu to tools
* Added uninstall script to remove air-script and or air-script tools
* Cleaned things up


v. 1.0.1


* Anonsurf added to tools
* MAC Changer added tools
* Fluxion added to tools


v 1.0
* Initial Release

<br>
</br>


## WHAT IS AIR SCRIPT?

![air-script logo](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/IMG_0992.jpg)

Air-Script is an automated and automatic way to pwn wifi. 


Automated: Step by step user friendly interface


Automatic: You can tell Air-Script to hack all wifi networks around you.
Air-Script will automatically hack every network in range in a matter of seconds to minutes with out any user input. When Air-Script is done. It will automatically turn off monitor mode, ask which wordlist to use and will crack the password for you.


*If on Raspberry Pi, it's recommended to transfer handshakes from Pi to PC.*

To make things easier, do this all over SSH and Air-Script will turn off monitor mode when it finishes scanning, deauth, flood, etc. 
It automatically turns off monitor mode after every step to ensure you can stay connected via SSH. 


Air-Script is a great tool for lazy people, script kiddies, and anyone who wants to pwn on the go. (Especially without being noticed. 
Easily hide a Pi in your pocket, connect via ssh with mobile hotspot or ad hoc and pwn the world!)

*PLEASE NOTE: If youre on Raspberry Pi over SSH, VNC or Ad Hoc most tools will not work due to being disconnected when being put into monitor mode. ONLY Air-Script Attacks work when connected over SSH or Ad Hoc. Air Script Wifi attacks were specifically built for a headless set up*


*Air-Script being automatic and extremely SSH/Ad Hoc friendly makes it somewhat unique*

*This script comes as is, there is no warranty.*
*By using this you agree to not hack WiFi networks you do not own or have permission to hack.*
*Hacking networks you do not have permission to hack is illegal. I am not responsible for your actions.*

![alt text](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/air-scriptv1.0.2.png)
![alt text](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/IMG_0991.JPG)	
![alt text](https://github.com/B3ND1X/air-script-mobile/blob/main/img/IMG1.JPG)


## VIDEO:
* https://drive.google.com/file/d/1JHz_qeq7M-sfPU6Nh0MtVoqs0EQeNFEt/view?usp=sharing (KALI PC)
* https://drive.google.com/file/d/1F6777GA08joON5ZYYVb8gWt6bt6WNW-d/view?usp=sharing (KALI RASPBERRY PI SSH)
							               
		
		
## HOW TO INSTALL:

Open Terminal

run commands: 

* cd
* git clone https://github.com/B3ND1X/air-script
* cd air-script 
* chmod +x install.sh
* sudo ./install.sh


## HOW TO RUN:

* cd air-script
* sudo ./air-script.sh

## DONT WANT TO USE ONLY AIR SCRIPT?

Thats okay, me either! Thats why Air Script comes with extra tools!


## HOW TO UNINSTALL THIS GARBAGE SCRIPT?!!

It's a shame to see you go. No hard feelings!

* Please go to "Help" (Option 8)
* Select "Uninstall" (Option 4)
