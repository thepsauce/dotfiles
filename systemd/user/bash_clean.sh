#!/bin/bash

tmp="$(mktemp)"
file="$HOME/.bash_history"

# double reverse with tac to keep command recency
tac "$file" | awk '!x[$0]++' | tac > "$tmp"

# time stamps are enabled, remove lines starting with '#' but
# keep the last of a sequence
cat "$tmp" | awk '{
    if ($0 ~ /^#/) {
        hash_line = $0
    } else {
        if (hash_line != "") {
            print hash_line
        }
        print
        hash_line = ""
    }
}' > "$file"

rm -f "$tmp"
