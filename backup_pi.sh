#!/bin/bash
# Backup pi SD card
output_dir=$HOME

# Find disk with linux partition (Raspbian)
export disk=`diskutil list | grep "Linux" | sed 's/.*\(disk[0-9]\).*/\1/' | uniq`
if [ $disk ]; then
    echo $disk
    echo $outpur_dir
else
    echo "Disk not found."
    exit
fi

if [ $# -eq 0 ] ; then
    backup_name='pi'
else
    backup_name=$1
fi
backup_name+="backup"
echo $backup_name

echo "Backing up..."
diskutil unmountDisk /dev/$disk
time sudo dd if=/dev/r$disk bs=4m | gzip -9 > $output_dir/pibackup.img.gz

#rename to the current date
echo "Finished copying backup, renaming file..."
mv -n $output_dir/piback.img.gz $output_dir/$backup_name`date +%Y%m%d`.img.gz
echo "Finished copying backup to ${output_dir}/${backup_name}`date +%Y%m%d`.img.gz"
