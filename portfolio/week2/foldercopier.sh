#!/bin/bash
#
#Prompt the user to give the name of the folder to be copied.
read -p "Type the name of the folder you would like to copy: " folderName
#
#If the name is a valid directory
if [ -d "$folderName" ]
then
  #copy it to a new location
  read -p "Type the name of the destination folder: " newFolderName
  cp -r "$folderName" "$newFolderName"
  echo "Directory copied."
  exit 0
else
  #otherwise, print an error
  echo "I couldn't find that folder."
  exit 1
fi
