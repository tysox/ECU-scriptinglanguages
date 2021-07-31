#!/bin/bash
#
#Ask the user to name the folder to be created.
folderNameprompt=`echo -e "\e[3;93mType the name of the folders you would like to create: \e[0m"`
read -p "$folderNameprompt" folderName
#
#If the dir doesn't already exist, create it.
if [ ! -d "$folderName" ]
then
  mkdir "$folderName"
  echo -e "\e[3;32mfolder '$folderName' created successfully.\e[0m"
  exit 0
else
  echo -e "\e[3;31mFolder already exists.\e[0m"
  exit 1
fi
