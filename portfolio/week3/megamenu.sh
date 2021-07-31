#!/bin/bash

#THIS SCRIPT ASSUMES YOU HAVE ALREADY RUN THE setPassword.sh SCRIPT IN THE WEEK 2 DIRECTORY.
#IF YOU HAVEN'T ALREADY, YOU WILL NEED TO DO SO BEFORE RUNNNING THIS SCRIPT.

#Run the passwordProtected script.
../week2/passwordCheck.sh
#
#If the passwordProtected script ran correctly (i.e. user entered correct password), then give the following options. Otherwise, exit with code 1.
if [ $? -ne 0 ]
then
  exit 1
fi
#
#Display a menu requesting user to make a choice from the available options
until [ ]     #Whenever a script completes, display this menu again.
do
  echo
  echo -e "\t\e[3;4;35;100mSelect an option:\e[0m"
  echo
  echo -e "\e[2;92m 1. Create a folder:\e[0m"
  echo -e "\e[2;92m 2. Copy a folder:\e[0m"
  echo -e "\e[2;92m 3. Set a password:\e[0m"
  echo -e "\e[2;92m 4. Calculator:\e[0m"
  echo -e "\e[2;92m 5. Create 'week' folders:\e[0m"
  echo -e "\e[2;92m 6. Check filenames:\e[0m"
  echo -e "\e[2;92m 7. Download a file:\e[0m"
  echo -e "\e[2;92m 8. Exit:\e[0m"
  #
  #Display a blank line for the user to enter an option, assigning this input to the $option var.
  read -p "" option


  case "$option" in
    1) ../week2/foldermaker.sh;;                        #Selecting 1 runs foldermaker.sh script.
    2) ../week2/foldercopier.sh;;                       #Selecting 2 runs foldercopier.sh script.
    3) ../week2/setPassword.sh;;                        #Selecting 3 runs setPassword.sh script.
    4) ../week3/calculator.sh;;                         #Selecting 4 runs calculator.sh script.
    5) ../week3/megafoldermaker.sh;;                    #Selecting 5 runs megafoldermaker.sh script.
    6) ../week3/filenames.sh;;                          #Selecting 6 runs filenames.sh script.
    7) ../week3/downloader.sh;;                         #Selecting 7 runs downloader.sh script.
    8) echo -e "\e[3;35mGoodbye!\e[0m" ; exit 0;;       #Selecting 8 exits the script with code 0.
                                                        #Selecting anything else returns an error and exits with code 1.
    *) echo -n -e "\e[1;33mNot a valid option - \e[0m" ; echo -e "\e[3;35mGoodbye.\e[0m" ; exit 0;;
  esac
done
