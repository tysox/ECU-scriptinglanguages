#!/bin/bash
#
#Prompt the user to give the name of the folder to be copied.
folderNameprompt=`echo -e "\e[3;93mType the name of the folder you would like to copy: \e[0m"`
read -p "$folderNameprompt" folderName
#
#If the name is a valid directory
if [ -d "$folderName" ]
then
  #copy it to a new location
  newFolderNameprompt=`echo -e "\e[3;93mType the name of the destination folder: \e[0m"`
  read -p "$newFolderNameprompt" newFolderName
  cp -r "$folderName" "$newFolderName"
  echo -e "\e[3;32mDirectory copied.\e[0m"
  exit 0
else
  #otherwise, print an error
  echo -e "\e[3;31mI couldn't find that folder.\e[0m"
  exit 1
fi
