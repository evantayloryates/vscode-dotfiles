#!/bin/sh

# Get the path to the directory where the install.sh script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Concatenate the contents of functions.sh with ~/.bashrc and append the result to ~/.bashrc
cat "${SCRIPT_DIR}/functions.sh" >> ~/.bashrc

# Print a message to confirm that the function was added to the ~/.bashrc file
echo "The gb function has been added to the ~/.bashrc file"