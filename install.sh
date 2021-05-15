#!/bin/bash
#####################################
# Icosium Conky installation script #
#####################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
INSTALL_FILES=(icosium.lua icosiumrc README.md launch-icosium.sh)
DESTINATION=~/.config/conky/icosium-conky

echo "You are about to install Icosium Conky. Any similar files in '$DESTINATION' will be overwritten."
echo -n "Do you want to proceed? [Y/n] "
read -r ANSWER

if [[ "$ANSWER" == [Nn] ]]; then
    echo "Aborting..."
    exit 0
fi

echo "Installing Icosium Conky..."

mkdir -p "$DESTINATION"

for i in "${INSTALL_FILES[@]}"; do
    cp "$i" "$DESTINATION" > /dev/null 2>&1
done

echo "Successfuly Installed."
