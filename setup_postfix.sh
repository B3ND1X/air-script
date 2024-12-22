#!/bin/bash

LOGFILE="/var/log/postfix_setup.log"

# Log function to capture messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

# Function to check if Postfix is installed
check_postfix_installed() {
    dpkg -l | grep postfix
    if [ $? -ne 0 ]; then
        log_message "Postfix is not installed. Installing..."
        install_postfix
    else
        log_message "Postfix is already installed."
    fi
}

# Function to install Postfix and ensure all dependencies
install_postfix() {
    log_message "Reinstalling Postfix and dependencies..."
    sudo apt-get update
    sudo apt-get remove --purge -y postfix postfix-doc
    sudo apt-get autoremove -y
    sudo apt-get install -y postfix postfix-doc mailutils postfix-utils

    # Verify installation of postfix commands
    log_message "Verifying Postfix commands (postconf, postmap, sendmail)..."
    which postconf &>/dev/null
    if [ $? -ne 0 ]; then
        log_message "Error: postconf not found. Postfix installation failed."
        exit 1
    fi

    which postmap &>/dev/null
    if [ $? -ne 0 ]; then
        log_message "Error: postmap not found. Postfix installation failed."
        exit 1
    fi

    which sendmail &>/dev/null
    if [ $? -ne 0 ]; then
        log_message "Error: sendmail not found. Postfix installation failed."
        exit 1
    fi

    log_message "Postfix installation complete."
}

# Function to configure Postfix to use Gmail SMTP
configure_postfix() {
    log_message "Configuring Postfix to use Gmail SMTP..."
    sudo postconf -e "relayhost = [smtp.gmail.com]:587"
    sudo postconf -e "smtp_use_tls = yes"
    sudo postconf -e "smtp_sasl_auth_enable = yes"
    sudo postconf -e "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd"
    sudo postconf -e "smtp_sasl_security_options = noanonymous"
    sudo postconf -e "myhostname = $(hostname).example.com" # Set your hostname

    log_message "Postfix configured for Gmail SMTP."
}

# Function to configure Gmail credentials for Postfix
configure_postfix_credentials() {
    log_message "Enter your Gmail address:"
    read -r gmail_user
    log_message "Enter your Gmail password (or App Password if 2FA enabled):"
    read -s gmail_password

    # Create the sasl_passwd file for Gmail credentials
    echo "[smtp.gmail.com]:587 $gmail_user:$gmail_password" | sudo tee /etc/postfix/sasl_passwd > /dev/null
    sudo chmod 600 /etc/postfix/sasl_passwd
    sudo postmap /etc/postfix/sasl_passwd

    # Restart Postfix to apply the changes
    restart_postfix
    log_message "Postfix credentials configured and service restarted."
}

# Function to restart Postfix, checking if it's installed and handling errors
restart_postfix() {
    log_message "Checking if Postfix is registered as a service..."
    systemctl list-units --type=service | grep postfix
    if [ $? -ne 0 ]; then
        log_message "Postfix service not found. Attempting to reload systemd..."
        sudo systemctl daemon-reload
        sudo systemctl enable postfix
        sudo systemctl start postfix
    fi

    log_message "Restarting Postfix using systemd..."
    sudo systemctl restart postfix

    if [ $? -eq 0 ]; then
        log_message "Postfix restarted successfully using systemd."
    else
        log_message "Error restarting Postfix with systemd. Attempting to restart with service command..."
        sudo service postfix restart
        if [ $? -eq 0 ]; then
            log_message "Postfix restarted using service command."
        else
            log_message "Error restarting Postfix with service command. Please check manually."
        fi
    fi
}

# Function to send an email using Postfix and Sendmail
send_email() {
    log_message "Enter recipient email address:"
    read -r recipient

    log_message "Enter email subject:"
    read -r subject

    log_message "Enter email message body:"
    read -r message

    log_message "Sending email to $recipient with subject '$subject'..."

    # Send the email using the sendmail command
    echo -e "Subject: $subject\n\n$message" | sendmail "$recipient"

    if [ $? -eq 0 ]; then
        log_message "Email sent successfully!"
    else
        log_message "Error sending email."
    fi
}

# Function to ensure Postfix utilities are available
check_postfix_utilities() {
    echo "Checking for postconf and postmap..."
    which postconf &>/dev/null
    if [ $? -ne 0 ]; then
        log_message "postconf not found! Reinstalling postfix."
        install_postfix
    fi

    which postmap &>/dev/null
    if [ $? -ne 0 ]; then
        log_message "postmap not found! Reinstalling postfix."
        install_postfix
    fi
}

# Function to update system and reinstall postfix
update_system_and_reinstall_postfix() {
    log_message "Updating system and reinstalling Postfix..."
    sudo apt-get update -y
    sudo apt-get remove --purge postfix -y
    sudo apt-get install -y postfix postfix-doc mailutils
}

# Function to configure firewall rules if UFW is active
configure_firewall() {
    if sudo ufw status | grep -q "inactive"; then
        log_message "UFW is inactive. Skipping firewall rules."
    else
        log_message "Opening necessary ports in the firewall..."
        sudo ufw allow 25,587,465/tcp
        sudo ufw reload
    fi
}

# Main script logic
log_message "Welcome to the Postfix setup script."

# Check if Postfix is installed and install if necessary
check_postfix_installed

# Ask if the user wants to configure Gmail credentials for Postfix
log_message "Do you want to configure Gmail credentials for Postfix (Y/n)?"
read -r configure_postfix_choice

if [[ "$configure_postfix_choice" == "Y" || "$configure_postfix_choice" == "y" || "$configure_postfix_choice" == "" ]]; then
    # Configure Postfix credentials
    configure_postfix_credentials
else
    log_message "Skipping Gmail credentials configuration."
fi

# Update system and reinstall Postfix if needed
update_system_and_reinstall_postfix

# Configure Postfix utilities
check_postfix_utilities

# Configure firewall rules
configure_firewall

# Ask for email details and send the email
send_email

log_message "Postfix setup is complete. Check your inbox for the test email and logs."
