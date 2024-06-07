#!/bin/bash

workspaces=$(i3-msg -t get_workspaces | jq -r '.[] | .name' | sort -n)
workspace_array=($workspaces)

for i in "${!workspace_array[@]}"
do
    current_number=$((i + 1))
    current_name=${workspace_array[$i]}
    
    if [ "$current_name" != "$current_number" ]
    then
        i3-msg "rename workspace \"$current_name\" to \"$current_number\""
    fi
done
