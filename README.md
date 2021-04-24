Air-Script is an automated and automatic way to pwn wifi. 


Automated: Step by step user friendly interface


Automatic: You can tell Air-Script to hack all wifi networks around you.
When Air-Script is done it will ask which wordlist to use and will crack the password for you.
*If on Pi this step is recommended to be done on PC. Transfer handshakes from Pi to PC.*
To make things easier, do this all over SSH and Air-Script will turn off monitor mode when it finishes scanning, deauth, flood, etc. 
It automatically turns off monitor mode after every step to ensure you can stay connected via SSH. 
Air-Script is a great tool for lazy people, script kiddies, and anyone who wants to pwn on the go. (Especially without being noticed. Easily hide a Pi in your pocket, connect via ssh with mobile hotspot or ad hoc and pwn the world!
 


*This script comes as is, there is no warranty.*
*By using this you agree to not hack WiFi networks you do not own or have permission to hack.*
*Hacking networks you do not have permission to hack is illegal. I am not responsible for your actions.*
	
![alt text](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/Screenshot%202021-04-24%2010%3A47%3A26.png)	
![alt text](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/IMG_0977.PNG)
![alt text](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/IMG_0978.PNG)
![alt text](https://github.com/B3ND1X/air-script-mobile/blob/main/img/IMG1.JPG)
VIDEO:
https://drive.google.com/file/d/1JHz_qeq7M-sfPU6Nh0MtVoqs0EQeNFEt/view?usp=sharing
							               
		
		
HOW TO INSTALL:

Open Terminal

run commands: 

git clone https://github.com/B3ND1X/air-script

chmod -R 755 /home/pi/air-script


HOW TO RUN

sudo ./air-script.sh

HELP:

For iOS SSH: 


Method 1: Jailbreak and get NewTerm2 from your package manager of coice (Cydia, Sileo, etc.)

Method 2: No jailbreak needed, simply go to App Store and download Terminus
