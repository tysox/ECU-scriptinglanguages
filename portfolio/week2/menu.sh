#!/bin/bash
#
#Run the passwordProtected script.
./passwordProtected.sh
#
#If the passwordProtected script ran correctly (i.e. user entered correct password), then give the following three options. Otherwise, exit with code 1.
if [ $? -eq 0 ]
then
  echo "Select an option:"
  echo "1. Create a folder"
  echo "2. Copy a folder"
  echo "3. Set a password"
else
  exit 1
fi
#
#Display a blank line for the user to enter an option, assigning this input to the $option var.
read -p "" option
#
case "$option" in
  1) ./foldermaker.sh; exit 0 ;;                       #Selecting 1 runs foldermaker.sh script.
  2) ./foldercopier.sh; exit 0 ;;                      #Selecting 2 runs foldercopier.sh script.
  3) ./setPassword.sh; exit 0 ;;                       #Selecting 3 runs setPassword.sh script.
  *) echo "Not a valid option. Goodbye."; exit 1 ;;    #Selecting anything else returns an error and exits with code 1.
esac
