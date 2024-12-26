![1A47ABD8-879A-41F3-9BA9-5F0E41ED7135](https://user-images.githubusercontent.com/48177481/178115591-d92f47f8-bbf7-4a06-8106-500d61b3fcd2.jpeg)
## WHAT IS AIR SCRIPT?

Air Script is Wi-Fi pwning Swiss Army knife that also has optional email notifications for when handshakes have been captured. 


Air Script is an automated and automatic way to pwn wifi. 


### Automated: Step by step user friendly interface, to improve workflow. Type less, attack more!


### Automatic: You can tell Air-Script to hack all wifi networks around you with an Air Script attack. (Attack all option)
Air Script will automatically pwn every network in range in a matter of seconds to minutes without any user input. When Air-Script is done. It will automatically turn off monitor mode, and send you an email notification. (Notifications are optional) Then Air Script will ask you what wordlist to use, and will try to bruteforce the password for you. (When asked for wordlist, click enter or crl + c to skip.)


Air Script is a great tool for lazy people, script kiddies, and anyone who wants to pwn on the go. (Especially without being noticed. 
Easily hide a Pi in your pocket, connect via ssh with mobile hotspot or ad hoc and pwn the world!)


*If on Raspberry Pi, it's recommended to skip bruteforce and transfer handshakes from Pi to PC to decrypt the password.*

*Create or upload your own wordlist to Air Script. More wordlists means a higher chance of getting the password!* 

*Also note you will have to convert .cap files to .hccap yourself if you want to use hashcat* (This will be an automated option in the future)

Use this if you don't know how to convert: https://hashcat.net/cap2hccapx/ (Convert handshake for hashcat, this is optional)


## EMAIL NOTIFICATIONS
Don't want to sit around and pay attention to what's happening? Yeah, me either... That's why Air Script will ask you if you want an email notification when it's done pwning networks. No set up, no fuss, just type in a working email address and air script will do the rest.

*Postfix now requires to sign into a gmail account, feel free to make a burner account fot this. For help with setting up run ./setup_postfix or use help option.*


## DONT WANT TO USE ONLY AIR SCRIPT?

That's okay, me either! That's why Air Script comes with extra tools! See changelog for a list of added tools.
Air Script comes loaded with a variety of extra tools to improve workflow for hackers, pentesters and security researchers.
Either install all or choose which tools to install to save space. 

## Mobile & Raspberry Pi
							               
PLEASE NOTE: 
* NO JAILBREAK is required to SSH to your Pi from iOS device! Just download the "Terminus" app from AppStore	
* NO ROOT is required to SSH to Pi from Android. Download a terminal of your choice from Google Play
* For Raspberry Pi users, it's recommended to select only the tools you need to save on space. 		
## HOW TO INSTALL:


METHOD 1:

Open Terminal

run commands: 

<pre>
* cd
* git clone https://github.com/B3ND1X/air-script
* cd air-script 
* sudo chmod +x install.sh 
* sudo ./install.sh
</pre>

METHOD 2: 

If on a Debian based distro. Feel free to install the air-script Debian package. 

* To install see releases and install the latest release of air-script.deb 

*Please note: this is a pre-release and might have issues it is not reccomended to install.* 


## HOW TO RUN:

<pre>
* cd air-script
* sudo ./pwn.sh
OR 
* sudo aircrack (from any directory)  
</pre>

*If installed as a deb package, you can find air-script in your toolbar under applications.*


## HOW TO UNINSTALL THIS GARBAGE SCRIPT?!!

It's a shame to see you go. No hard feelings!

* Please go to "Help" (Option 8)
* Select "Uninstall" (Option 4)

If you installed deb package: 

* sudo apt remove air-script 


## HELP 

* Select 'Help' (option 8)
* Email for support (liam@liambendix.com)


## IMAGES

![image](https://user-images.githubusercontent.com/48177481/178114991-719f18d2-52a4-481d-b68d-df460a122e34.png)
![image](https://user-images.githubusercontent.com/48177481/178114995-5237cabc-afcd-4eef-a5bc-d6796e10fdc5.jpeg)
![image](https://user-images.githubusercontent.com/48177481/178115000-c358b504-f5ba-4f60-9e3b-27d9e1388d42.jpeg)
![image](https://user-images.githubusercontent.com/48177481/178115004-2ae3f097-c0d4-4f85-acf4-1cd135533416.gif)
![image](https://user-images.githubusercontent.com/48177481/178115007-07096162-6b75-4e41-b713-af08b56e0c28.gif)


### REQUIREMENTS 


* A device with a compatible Linux distribution, such as Kali Linux
* Wireless network interface controller (NIC) that supports raw monitoring mode
* NIC capable of sniffing 802.11a, 802.11b, and 802.11g packets


### CHANGELOG

v 2.0.5
* Fixed all air-script attacks
* Fixed postfix and added a postfix setup script
* Added more efficient attack method by extracting client MAC address on an AP and sending deAuth packets to target to capture handshakes faster

v 2.0.4
* Added loop for attacking until valid EAPOL data is found. 
v 2.0.3
* Added function to check for valid .cap files with EAPOL data present before decrypting handshakes or sending email notifications

v 2.0.2
* Bug fixes

v 2.0.1
* Bug fixes
* Changes to install script
* Removed the following tools: (they will be added to a separate script, check back later)
* Hakku
* Trity
* Xerxes
* Katana
* BeeLogger
* Ezsploit
* TheFatRat
* Sn1per

v 2.0.0
* Bug fixes
* Added shortcut/launcher option in install script 
* Added img directory 


v 1.0.9
* Bug fixes
* Fixed macchanger
* Added option to select which network interface to change/show MAC address

v 1.0.8 
* Select which network interface to use
* Bug fixes

v 1.0.7
* Find Air Script from any directory by typing "air-script"
* Huge update for install script
* Updated uninstall script
* Small bugs fixed 

v 1.0.6
* Small bug fixes
* Updated install script

v 1.0.5
* Email notifications for when Air Script is done attacking
* Other small bug fixes and improvements

v 1.0.4
* Small bug fixes and typos
* Added Fluxion
* Added Wifite & Wifite2
* Added Fern
* Added Airogeddon
* Added Morpheus
* Added Hakku
* Added Trity
* Added Cupp
* Added Dracnmap
* Added KickThemOut
* Added Ghost-Phisher
* Added Xerxes
* Added Katana
* Added Websploit
* Added BeeLogger
* Added Ezsploit
* Added TheFatRat
* Added Angry IP Scanner
* Added Sn1per
* Updated installer(Option to install all or select what to install to save space)
* Updated Uninstaller 


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

* Anonsurf added to tools
* MAC Changer added tools
* Fluxion added to tools


v 1.0
* Initial Release
