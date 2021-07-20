#!/bin/bash
#
#Ask the user to name the folder(s) to be created.
echo "Type the names of the folders you would like to create: "
#
#Create a variable array, folderName.
read -a folderName
#
#Create multiple directories using the array variable.
mkdir ${folderName[*]}
#
echo "folder: ${folderName[*]} created successfully."
exit 0
