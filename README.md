# Air Script

![Air Script Logo](https://user-images.githubusercontent.com/48177481/178115591-d92f47f8-bbf7-4a06-8106-500d61b3fcd2.jpeg)

## What is Air Script?
![1A47ABD8-879A-41F3-9BA9-5F0E41ED7135](https://user-images.githubusercontent.com/48177481/178115591-d92f47f8-bbf7-4a06-8106-500d61b3fcd2.jpeg)
Air Script is an automated tool designed to facilitate Wi-Fi network penetration testing. It streamlines the process of identifying and exploiting Wi-Fi networks by automating tasks such as network scanning, handshake capture, and brute-force password cracking. Key features include:


Automated Attacks: Air Script can automatically target all Wi-Fi networks within range, capturing handshakes without user intervention. Upon completion, it deactivates monitor mode and can send optional email notifications to inform the user. Air Script also automates Wi-Fi penetration testing by simplifying tasks like network scanning, handshake capture, and password cracking on selected networks.

Brute-Force Capabilities: After capturing handshakes, the tool prompts the user to either provide a wordlist for attempting to crack the Wi-Fi passwords, or it uploads captured Wi-Fi handshakes to the WPA-sec project. This website is a public repository where users can contribute and analyze Wi-Fi handshakes to identify vulnerabilities. The service attempts to crack the handshake using its extensive database of known passwords and wordlists.

Email Notifications: Users have the option to receive email alerts upon the successful capture of handshakes, allowing for remote monitoring of the attack’s progress.

Additional Tools: Air Script includes a variety of supplementary tools to enhance workflow for hackers, penetration testers, and security researchers. Users can choose which tools to install based on their needs.

Compatibility: The tool is compatible with devices like Raspberry Pi, enabling discreet operations. Users can SSH into the Pi from mobile devices without requiring jailbreak or root access.

Ethical Use: Always ensure you have authorization to test the networks you are targeting.

Disclaimer: Air Script is intended for educational purposes and authorized penetration testing only. Unauthorized use against networks without explicit permission is illegal and unethical.

Data Sharing: By uploading handshakes, you are sharing information with a public platform, which could pose ethical and privacy concerns if done without consent.

This software is a powerful tool for security researchers, but unauthorized use is both unethical and illegal.

## Email Notifications

Don’t want to monitor the process continuously? Air Script can send you an email notification once it’s done "pwning" networks. No setup required—just enter a valid email address, and Air Script will handle the rest!

**Update:** Postfix now requires you to log into a Gmail account. Feel free to use a burner account for this. For help with setup, run `./setup_postfix` or use the help option.

---

## Submit Handshakes Online

To submit your captured handshakes for cracking, visit [WPA-sec](https://wpa-sec.stanev.org/) and obtain a key. Once you have your key, place it into the `key.txt` file.

- **Cracking Logic Update**: Users can now upload capture files to crack handshakes online.
- Captured files are sent to [WPA-sec](https://wpa-sec.stanev.org/) and you will receive an email if any passwords are found.

---

## Don’t Want to Use Only Air Script?

That’s perfectly fine! Air Script comes with a variety of additional tools to enhance your workflow. You can choose to install all tools or select only the ones you need to save space. For the full list, refer to the changelog.

---

## Mobile & Raspberry Pi

**Note**:  
- **No Jailbreak** is required to SSH into your Raspberry Pi from an iOS device! Just download the "Terminus" app from the App Store.  
- **No Root** is required to SSH into your Raspberry Pi from an Android device. Simply download a terminal app from the Google Play Store.  
- For Raspberry Pi users, we recommend only installing the tools you need to save space.

---

## How to Install

### Method 1:

1. Open a terminal.
2. Run the following commands:

    ```bash
    cd
    git clone https://github.com/B3ND1X/air-script
    cd air-script
    sudo chmod +x install.sh
    sudo ./install.sh
    ```

### Method 2:

If you’re using a Debian-based distro, you can install Air Script using the Debian package.

- Download the latest release from the [Releases page](https://github.com/B3ND1X/air-script/releases) and install the `air-script.deb` package.
- **Note**: This is a pre-release and may have issues. It’s not recommended for production use.

---

## How to Run

Once installed, you can run Air Script with the following command:

```bash
cd air-script
sudo ./pwn.sh
```

Alternatively, you can run it from any directory with:

```bash
sudo airscript
```

If installed as a `.deb` package, you can find Air Script in your system’s application menu.

---

## How to Uninstall

1. Open the help menu: `Help` (Option 8).
2. Select `Uninstall` (Option 4).

If you installed the `.deb` package:

```bash
sudo apt remove air-script
```

---

## Help

For support or assistance, you can:

1. Select `Help` (Option 8).
2. Email me at [liam@liambendix.com](mailto:liam@liambendix.com).

---

## Images

![Air Script Interface](https://user-images.githubusercontent.com/48177481/178114991-719f18d2-52a4-481d-b68d-df460a122e34.png)
![Wi-Fi Network Capture](https://user-images.githubusercontent.com/48177481/178114995-5237cabc-afcd-4eef-a5bc-d6796e10fdc5.jpeg)
![Brute-Force Cracking](https://user-images.githubusercontent.com/48177481/178115000-c358b504-f5ba-4f60-9e3b-27d9e1388d42.jpeg)
![Air Script in Action](https://user-images.githubusercontent.com/48177481/178115004-2ae3f097-c0d4-4f85-acf4-1cd135533416.gif)
![Email Notification](https://user-images.githubusercontent.com/48177481/178115007-07096162-6b75-4e41-b713-af08b56e0c28.gif)

---

## Requirements

- A device with a compatible Linux distribution (e.g., Kali Linux)
- Wireless network interface controller (NIC) that supports raw monitoring mode & packet injection
- NIC capable of sniffing 802.11a, 802.11b, and 802.11g packets

---

## Changelog

**v2.0.6**
- Cracking logic updated: Users can choose to crack handshakes locally or upload capture files for online cracking.
- Capture files sent to [WPA-sec](https://wpa-sec.stanev.org) for password cracking with email notifications.

**v2.0.5**
- Fixed Air Script attacks.
- Added a postfix setup script.
- More efficient attack methods with client MAC address extraction.

**v2.0.4**
- Loop added for attacks until valid EAPOL data is found.

**v2.0.3**
- Added a function to validate `.cap` files with EAPOL data before cracking or sending email notifications.

**v2.0.2 - v1.0.1**
- Multiple bug fixes, new features, and tool additions as listed in the full changelog above.

---

## License

This project is licensed under the terms of the MIT License.

---

This version of your README should be more concise, organized, and easy to follow for users of varying technical expertise. Let me know if you need further adjustments or additions!
