#!/bin/bash
#
#User is asked to enter a password, then a new line is created for ease of reading of terminal output.
read -sp "Enter password : " secretPassword
echo
#
#If the directory doesn't exist, create it. If it does, then do nothing.
if [ ! -d "$(whoami)" ]
then
  mkdir ../week2/$(whoami)
fi
#
#Calculates the hash of the secretPassword var, and prints that value into a "username".txt file, within the folderName dictated.
#The > ensures that if there is a file already there, it's overwritten.
echo $secretPassword | sha256sum > ../week2/$(whoami)/$(whoami).txt
#
#If the script ran correctly, then a success message is displayed. If it didn't, then a different message (and exit code) is displayed.
if [ $? -eq 0 ]
then
  echo "Password saved."
  exit 0
else
  echo "Password not saved: something went wrong."
  exit 1
fi
