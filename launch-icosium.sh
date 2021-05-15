#!/bin/bash

LOCATION=~/.config/conky/icosium-conky
CONF_FILE=$LOCATION/icosiumrc
LUA_FILE=$LOCATION/icosium.lua


if [[ -f $CONF_FILE && -f $LUA_FILE ]]; then
    killall conky &> /dev/null
    conky -c "$CONF_FILE"
else
    echo "Error. '$CONF_FILE' doesn't exist"
fi
