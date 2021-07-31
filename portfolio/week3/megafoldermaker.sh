#!/bin/bash

firstprompt=`echo -e "\e[3;93mFirst folder number: \e[0m"`
lastprompt=`echo -e "\e[3;93mSecond folder number: \e[0m"`
read -p "$firstprompt" first
read -p "$lastprompt" last

#The following six lines are part of the original script, which took arguments instead of user inputs. The two variables needed to be defined by the user in order for the "megamenu.sh" script to execute correctly.
#If there aren't two arguments to the script
#if (( $#!=2 ))
#then
#    #Print an error and exit
#    echo "Error: provide two numbers." && exit 1
#fi

#For every number between the first argument and the last (inclusive).
for ((i = $first; i <= $last; i++))
do
    if [ ! -d "week$i" ]    #If the folder doesn't already exist, create a new folder for that number.
    then
        echo -e "\e[2;3mCreating directory 'week$i'\e[0m"
        mkdir "week$i"
    else
        echo -e "\e[3;31m'week$i' folder already exists.\e[0m"      #If the folder already exists, let the user know.
    fi
done
exit 0
