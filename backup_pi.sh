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
backup_name+="pi_backup"
echo $backup_name

diskutil unmountDisk /dev/$disk
echo "Backing up..."
time sudo dd if=/dev/r$disk bs=4m | gzip -9 > $output_dir/piback.img.gz

#rename to the current date
echo "compressing completed - now renaming"
mv -n $output_dir/piback.img.gz $output_dir/$backup_name`date +%Y%m%d`.img.gz
