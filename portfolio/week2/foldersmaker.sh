#!/bin/bash
echo "Type the names of the folders you would like to create: "
read -a folderName
mkdir ${folderName[*]}
echo "folder: ${folderName[*]} created successfully."
exit 0
