firefox --search "$1"

# Make it float
i3-msg floating enable > /dev/null

# Move it to the center for good measure
i3-msg move position center > /dev/null
