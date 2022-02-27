#!/bin/bash

read -p "Writing zeroes is bad to the sd card; use this sparingly!. Press y to confirm if you want to continue." -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    time="$(date +%s)"
    zero_file=$HOME/zero_file
    echo "Writing zeroes to pi at $(date)."
    dd if=/dev/zero of=${zero_file}
    echo "Completed writing zeroes; took $(($(date +%s)-time)) seconds. File size is $(ls -lh $zero_file | awk '{print  $5}')"
    sync
    sync
    echo "Deleting zero file"
    rm $HOME/zero_file
    sync
    sync
    echo "Complete."
fi
