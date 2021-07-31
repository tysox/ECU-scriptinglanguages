#!/bin/bash

#User is first asked to provide the URL of the file they wish to download. This becomes the variable $URL.
URLprompt=`echo -e "\e[3;93mPlease type the URL of a file to download or type 'exit' to quit: \e[0m"`
read -p "$URLprompt" URL

#This loop reads what the $URL variable is, and if it's anything other than "exit" it performs the following functions.
until [ $URL = exit ]
do
    #User provides the directory where they want the file to download.
    folderNameprompt=`echo -e "\e[3;93mPlease type the location you would like to download the file to: \e[0m"`
    read -p "$folderNameprompt" folderName
    
    #The URL is downloaded to the stated directory.
    #Time-stamping is on (to avoid unnecessary downloads and durplications) and most, but not all, of the wget working is silenced.
    wget $URL -N -nv -P ${folderName/\~/$HOME}
                        #^This term on the end takes the orginal $folderName variable and looks to see if there is a tilde ("~") in it.
                        #If there is, it replaces it with $HOME (i.e. "/home/user"), if there isn't, the variable isn't modified).

    #Finally, the user is given the original opening prompt again, to re-set the $URL variable.
    read -p "$URLprompt" URL
done

#If ever $URL="exit", then the script politely says goodbye and exits with code 0.
echo -e "\e[3;35mGoodbye!\e[0m" && exit 0
