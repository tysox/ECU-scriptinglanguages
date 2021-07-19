#!/bin/bash
veracrypt --filesystem=none /dev/sdb
# It should be noted that in the following line "$(whoami)" will be replaced with the current user's username, or alternatively, you can just replace it with your usename.
sudo mount -o umask=000 /dev/mapper/veracrypt1 /home/$(whoami)/veracrypt1
exit 0
