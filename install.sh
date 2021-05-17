#!/bin/bash
#####################################
# Icosium Conky installation script #
#####################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
INSTALL_FILES=(icosium.lua icosiumrc README.md launch-icosium.sh)
DESTINATION=~/.config/conky/icosium-conky
STARTUP_DIR=~/.config/autostart
LAUNCH_SCRIPT=$DESTINATION/launch-icosium.sh


# Install in ~/.config/conky directory
echo "You are about to install Icosium Conky."
echo "Any similar files in '$DESTINATION' will be overwritten."
echo -n "Do you want to proceed? [Y/n] "
read -r ANSWER

if [[ "$ANSWER" == [Yy] ]]; then
    echo "Installing Icosium Conky..."
    mkdir -p "$DESTINATION"
    for i in "${INSTALL_FILES[@]}"; do
        cp "$i" "$DESTINATION" > /dev/null 2>&1
    done
    echo "Successfuly Installed."
else
    echo "Aborting..."
    exit 0
fi


# Launch it at startup

echo -n "Do you want to launch Icosium Conky at startup ? [Y/n] "
read -r ANSWER2

if [[ "$ANSWER2" == [Yy] ]]; then
    echo "creating startup file"
    mkdir -p "$STARTUP_DIR"

cat >> $STARTUP_DIR/icosium-conky.desktop <<EOF
[Desktop Entry]
Categories=System;
Exec=cd "$DESTINATION" && conky -c "$DESTINATION/icosiumrc" &
Name=Icosium
Path="$DESTINATION"
StartupNotify=true
Terminal=false
Type=Application
EOF

else
    echo "Abort launch at startup"
    exit 0
fi


# Launch it now

echo -n "Do you want to launch it now ? [Y/n] "
read -r ANSWER3

if [[ "$ANSWER3" == [Yy] ]]; then
    echo "launching Icosium conky"
    bash "$LAUNCH_SCRIPT"
else
    exit 0
fi

