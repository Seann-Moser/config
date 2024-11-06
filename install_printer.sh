#!/bin/bash

# Function to check if a package is installed
check_package_installed() {
    dpkg -l | grep -qw "$1" || pacman -Qs "$1" > /dev/null 2>&1
}

# Function to install a package
install_package() {
    PACKAGE=$1
    echo "Installing $PACKAGE..."
    sudo pacman -S --noconfirm $PACKAGE
}

# Function to add printer
add_printer() {
    echo "Please enter the printer's name (e.g., OfficePrinter):"
    read PRINTER_NAME
    echo "Please enter the printer's URI (e.g., ipp://192.168.1.100/printers/OfficePrinter):"
    read PRINTER_URI
    echo "Adding printer $PRINTER_NAME..."
    lpadmin -p "$PRINTER_NAME" -v "$PRINTER_URI" -E
    echo "Printer $PRINTER_NAME added successfully!"
}

# Function to print a test page
print_test_page() {
    echo "Would you like to print a test page? (y/n)"
    read PRINT_TEST
    if [[ "$PRINT_TEST" =~ ^[Yy]$ ]]; then
        lp -d "$PRINTER_NAME" /etc/cups/testprint
        echo "Test page printed successfully!"
    else
        echo "Test page skipped."
    fi
}

# Function to list available printers on the network
list_printers() {
    echo "Searching for available printers on the network..."
    PRINTERS=$(lpinfo -v | grep -E 'ipp|lpd|smb')
    if [[ -z "$PRINTERS" ]]; then
        echo "No network printers found."
        return 1
    fi
    echo "Found the following printers:"
    echo "$PRINTERS"
    echo "$PRINTERS" > /tmp/printer_list.txt
}

# Function to set the default printer
set_default_printer() {
    PRINTER_COUNT=$(wc -l < /tmp/printer_list.txt)
    if [ "$PRINTER_COUNT" -eq 1 ]; then
        FIRST_PRINTER=$(head -n 1 /tmp/printer_list.txt)
        PRINTER_NAME=$(echo $FIRST_PRINTER | sed 's/.*\/\(.*\)$/\1/')
        echo "Only one printer found: $PRINTER_NAME. Setting it as the default printer..."
        lpadmin -d "$PRINTER_NAME"
    elif [ "$PRINTER_COUNT" -gt 1 ]; then
        echo "Multiple printers found. You can choose one to set as the default."
        select PRINTER_NAME in $(cat /tmp/printer_list.txt); do
            if [[ -n "$PRINTER_NAME" ]]; then
                echo "Setting $PRINTER_NAME as the default printer."
                lpadmin -d "$PRINTER_NAME"
                break
            else
                echo "Invalid selection, please try again."
            fi
        done
    else
        echo "No printers found to set as default."
    fi
}

# Main script execution starts here

# Check if CUPS is installed
echo "Checking if CUPS is installed..."
if ! check_package_installed "cups"; then
    echo "CUPS is not installed. Installing it now..."
    install_package "cups"
fi

# Start CUPS service
echo "Starting CUPS service..."
sudo systemctl enable --now org.cups.cupsd.service

# List network printers
list_printers
if [ $? -eq 1 ]; then
    echo "No network printers found. Exiting setup."
    exit 1
fi

# Set the default printer
set_default_printer

# Ask for printer details if no printer was found
echo "If you'd like to manually add a printer, you can do so now."
echo "Do you want to add a printer? (y/n)"
read ADD_PRINTER
if [[ "$ADD_PRINTER" =~ ^[Yy]$ ]]; then
    add_printer
fi

# Ask if the user wants to print a test page
print_test_page

# Final message
echo "Printer setup complete!"

