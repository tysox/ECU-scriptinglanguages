#!/bin/bash

#User inputs location of file containing filenames
fileprompt=`echo -e "\e[3;93mLocation of file with filenames to check: \e[0m"`
read -p "$fileprompt" file

#If the file doesn't exits, print an error saying so and exit with code 1.
if [ ! -e $file ]
then
    echo -e "\e[3;31mI couldn't find that file.\e[0m"
    exit 1
fi

#Each line in the file forms a part of the variable array "filenames"
mapfile -t filenames < $file

#The "name" variable for the "for" statement is built from the "filenames" variable array.
for name in "${filenames[@]}"
do
    if [ -d "${name[@]}" ]      #If the filename exists and is a directory, tell the user it's a directory.
    then
        echo -n "${name[@]} - "
        echo -e "\e[3;36mThat's a directory\e[0m"

    elif [ -e "${name[@]}" ]    #If the filename exists, tell the user it's a file.
    then
        echo -n "${name[@]} - "
        echo -e "\e[3;32mThat file exists\e[0m"

    else                        #If the filename doesn't exist, tell the user "I don't know what that is".
        echo -n "${name[@]} - "
        echo -e "\e[3;91mI don't know what that is!\e[0m"
    fi
done
