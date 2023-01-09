#!/bin/sh

# Copyright: luthor112
# Based on S01a-unionfs-live-cd.sh by Bernd Schubert
# BSD license, see LICENSE file for details

FUSE_OPT="-o allow_other,use_ino,suid,dev,nonempty"
CHROOT_PATH="/tmp/unionfs"
UNION_OPT="-ocow,statfs_omit_ro,chroot=$CHROOT_PATH,max_files=32768"
MOUNT_PATH="/tmp/union"
X_DISPLAY="127.0.0.1:0"

chattr -i $CHROOT_PATH
chattr -i $MOUNT_PATH
rm -rf $CHROOT_PATH
rm -rf $MOUNT_PATH

mkdir -p $CHROOT_PATH
chattr +i $CHROOT_PATH
mount -t ramfs ramfs $CHROOT_PATH

mkdir -p $CHROOT_PATH/root
mkdir -p $CHROOT_PATH/rw
mkdir -p $MOUNT_PATH
chattr +i $MOUNT_PATH

mount --bind / $CHROOT_PATH/root

unionfs-fuse $FUSE_OPT $UNION_OPT /rw=RW:/root=RO $MOUNT_PATH

mount -t proc proc $MOUNT_PATH/proc
cp -L /etc/resolv.conf $MOUNT_PATH/resolv.conf

cd $MOUNT_PATH
mkdir oldroot
pivot_root . oldroot

rm /etc/resolv.conf
cp -a /resolv.conf /etc/resolv.conf
DISPLAY=$X_DISPLAY bash