#!/bin/bash
# Backup pi SD card
output_dir=$HOME

# Find disk with linux partition (Raspbian)
export disk=`diskutil list | grep "Linux" | sed 's/.*\(disk[0-9]\).*/\1/' | uniq`
if [ $disk ]; then
    echo "Backing up ${disk} to ${output_dir}."
else
    echo "Disk not found."
    exit
fi

if [ $# -eq 0 ] ; then
    backup_name='pi'
else
    backup_name=$1
fi
backup_name+="_backup"

sudo diskutil unmountDisk /dev/$disk
echo "Beginning backup, this will take some time..."
time sudo dd if=/dev/r$disk bs=4m | gzip -9 > $output_dir/${backup_name}_temp.img.gz

#rename to the current date
echo "Finished copying backup, renaming file..."
mv -n ${output_dir}/${backup_name}_temp.img.gz ${output_dir}/${backup_name}`date +%Y%m%d`.img.gz
echo "Finished copying backup to ${output_dir}/${backup_name}`date +%Y_%m_%d`.img.gz"
