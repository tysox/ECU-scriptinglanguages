#!/bin/bash
#
#Decrypts the drive (after asking for and receiving the correct password, which still appears on screen as a prompt) but doesn't mount it.
veracrypt --filesystem=none /dev/sdb
#
#Tells the system to mount the drive, with full access, from the first path to the second path.
#It should be noted that in the following line "$(whoami)" will be replaced with the current user's username. Alternatively, you can just replace it with your usename.
sudo mount -o umask=000 /dev/mapper/veracrypt1 /home/$(whoami)/veracrypt1
exit 0
