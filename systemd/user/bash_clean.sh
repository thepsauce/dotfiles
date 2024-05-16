#!/bin/bash

# double reverse with tac to keep command recency
tac ~/.bash_history | awk '!x[$0]++' | tac > /tmp/hist

mv -f /tmp/hist ~/.bash_history

rm -f /tmp/hist
