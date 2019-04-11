#!bin/bash
# CloudatCost resize boot and swap partition for 16.04 so do release upgrade doesn't fail

# Original first part of oneLiner

#fdisk -l /dev/sda*; blkid /dev/sd* && swapoff -a && umount /boot && tune2fs -O ^has_journal /dev/sda1 && echo -e "d\n2\nn\np\n2\n2181119\n\nt\n2\n82\nd\n1\nn\np\n1\n\n\np\nw" | fdisk /dev/sda && e2fsck -f /dev/sda1; reboot

# Part 2 run after reboot

#swapoff -a && mkswap -L swap /dev/sda2 &&  umount /boot && e2fsck -f /dev/sda1 && resize2fs /dev/sda1 && tune2fs -j /dev/sda1 && mount /boot; swapon -a; blkid /dev/sd*

# get UUID for swap from 
#blkid /dev/sd*
# copy UUID and replace it in fstab and resume
#nano /etc/fstab
#nano /etc/initramfs-tools/conf.d/resume

# check file system during reboot
#touch /forcefsck;reboot
# Inspect boot and swap should be 1G or 1000M
#fdisk -l /dev/sda*; blkid /dev/sd*;free -h; df -h

# File system is ready for upgrade and for 1604 run these commands first
#apt update; apt install dpkg apt -y

# Answer Y or I to install the package maintainer's version about 5 times
#do-release-upgrade

# Issue that could require research
# look for fix
#update-initramfs: Generating /boot/initrd.img-4.4.0-62-generic
#W: initramfs-tools configuration sets RESUME=UUID=c9f61b59-95aa-45ab-ae18-ee968312edc4
#W: but no matching swap device is available.
#I: The initramfs will attempt to resume from /dev/sda2
#I: (UUID=a3457c9b-6842-497b-8e45-2686ded85323)
#I: Set the RESUME variable to override this.
