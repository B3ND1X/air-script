![air-script logo](https://raw.githubusercontent.com/B3ND1X/air-script-img/main/IMG_0992.jpg)

## WHAT IS AIR SCRIPT?

Air Script is Wi-Fi pwning Swiss Army knife that also has optional email notifications for when handshakes have been captured. 


Air Script is an automated and automatic way to pwn wifi. 


Automated: Step by step user friendly interface, to improve workflow. Type less, attack more!


Automatic: You can tell Air-Script to hack all wifi networks around you with an Air Script attack. (Attack all option)
Air Script will automatically pwn every network in range in a matter of seconds to minutes without any user input. When Air-Script is done. It will automatically turn off monitor mode, and send you an email notification. (Notifications are optional) Then Air Script will ask you what wordlist to use, and will try to bruteforce the password for you. (When asked for wordlist, click enter or crl + c to skip.)


Air Script is a great tool for lazy people, script kiddies, and anyone who wants to pwn on the go. (Especially without being noticed. 
Easily hide a Pi in your pocket, connect via ssh with mobile hotspot or ad hoc and pwn the world!)


*If on Raspberry Pi, it's recommended to skip bruteforce and transfer handshakes from Pi to PC to decrypt the password.*

*Create or upload your own wordlist to Air Script. More wordlists means a higher chance of getting the password!* 

*Also note you will have to convert .cap files to .hccap yourself if you want to use hashcat* (This will be an automated option in the future)

Use this if you don't know how to convert: https://hashcat.net/cap2hccapx/ (Convert handshake for hashcat, this is optional)


## EMAIL NOTIFICATIONS
Don't want to sit around and pay attention to what's happening? Yeah, me either... That's why Air Script will ask you if you want an email notification when it's done pwning networks. No set up, no fuss, just type in a working email address and air script will do the rest. Your email is never recorded or sent to any server. Don't believe me? Check the code! Air Script is 100% open sourced and safe to use.


## DONT WANT TO USE ONLY AIR SCRIPT?

That's okay, me either! That's why Air Script comes with extra tools! See changelog for a list of added tools.
Air Script comes loaded with a variety of extra tools to improve workflow for hackers, pentesters and security researchers.
Either install all or choose which tools to install to save space. 

*This script comes as is, there is no warranty.*
*By using this script you agree to not hack, pwn or attack anything you do not own or have permission to hack, pwn or attack.*
*Hacking, pwning or attacking things you do not have permission to is illegal and punishable by law. I am not responsible for your actions, or  any damages caused by misuse of Air Script or any of it's tools.*

## IMAGES

![air-scriptv1 0 2](https://user-images.githubusercontent.com/48177481/116521705-4faf7800-a8a2-11eb-8fa0-95825b2506c3.png)
![IMG_0991](https://user-images.githubusercontent.com/48177481/116521724-5342ff00-a8a2-11eb-8bea-75c74b228512.JPG)
![IMG_1010](https://user-images.githubusercontent.com/48177481/116695031-03416680-a98e-11eb-908b-5da887d69f46.jpg)
![IMG1](https://user-images.githubusercontent.com/48177481/116521734-55a55900-a8a2-11eb-9656-27335d9979a3.JPG)


## VIDEO:

[![](https://media.giphy.com/media/oiPISdGcjvaUHDWSK3/giphy.gif)](https://youtu.be/tYfI1idoYtQ)
[![](https://media.giphy.com/media/iqqPx0rj8KLOqqbdmn/giphy.gif)](https://youtu.be/tYfI1idoYtQ)


## Mobile & Raspberry Pi
							               
PLEASE NOTE: 
* NO JAILBREAK is required to SSH to your Pi from iOS device! Just download the "Terminus" app from AppStore	
* NO ROOT is required to SSH to Pi from Android. Download a terminal of your choice from Google Play
* For Raspberry Pi users, it's recommended to select only the tools you need to save on space. 
* Raspberry Pi has not been thoroughly tested but it should work. Keep an eye out for any updates.		
## HOW TO INSTALL:


METHOD 1:

Open Terminal

run commands: 

* cd
* git clone https://github.com/B3ND1X/air-script
* cd air-script 
*  sudo chmod -R 755 *
* sudo ./install.sh


METHOD 2: 

If on a Debian based distro. Feel free to install the air-script Debian package. 

* To install see releases and install the latest release of air-script.deb 


## HOW TO RUN:

* cd air-script
* sudo ./pwn.sh

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



### CHANGELOG

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
