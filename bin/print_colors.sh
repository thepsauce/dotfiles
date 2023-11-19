#!/bin/bash

for color in {0..255}; do
    printf "\x1b[48;5;%sm%3s\e[0m" "$color" "$color"
    if ((color % 16 == 15)); then
        echo
    else
        printf " "
    fi
done

echo

