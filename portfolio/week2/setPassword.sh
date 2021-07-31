#!/bin/bash
#
#User is asked to enter a password, then a new line is created for ease of reading of terminal output.
secretPasswordprompt=`echo -e "\e[3;93mEnter password : \e[0m"`
read -sp "$secretPasswordprompt" secretPassword
echo
#
#If the directory doesn't exist, create it. If it does, then do nothing.
if [ ! -d "../week2/$(whoami)" ]
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
  echo -e "\e[3;32mPassword saved.\e[0m"
  exit 0
else
  echo -e "\e[1;3;31mPassword not saved: something went wrong.\e[0m"
  exit 1
fi
