#!/bin/bash
read -p "Type the name of the folders you would like to create: " folderName
mkdir "$folderName"
echo "folder: $folderName created successfully."
exit 0
