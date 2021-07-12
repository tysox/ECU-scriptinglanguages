#!/bin/bash
veracrypt --filesystem=none /dev/sdb
sudo mount -o umask=000 /dev/mapper/veracrypt1 /home/user/veracrypt1
exit 0
