#!/bin/bash
#
#Ask the user to name the folder to be created.
read -p "Type the name of the folders you would like to create: " folderName
#
#If the dir doesn't already exist, create it.
if [ ! -d "$folderName" ]
then
  mkdir "$folderName"
  echo "folder: $folderName created successfully."
  exit 0
else
  echo "Folder already exists."
  exit 1
fi
