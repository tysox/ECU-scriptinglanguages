#!/bin/bash
veracrypt --filesystem=none /dev/sdb
# It should be noted that in the following line "user" should be replaced with the username.
sudo mount -o umask=000 /dev/mapper/veracrypt1 /home/user/veracrypt1
exit 0
