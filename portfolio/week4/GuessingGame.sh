#!/bin/bash

#-----FUNCTIONS-----

#This fxn prints a given error
printError()
{
    echo -e "\033[31mERROR:\033[0m $1"
}

#This fxn ensures a value between 1 and 100 is given.
getNumber()
{
    read -p "$1"
    while (( $REPLY < 1 || $REPLY > 100 ))
    do
        printError "Input must be between 1 and 100"
        read -p "$1"
    done
}

#-----SCRIPT CODE-----

#User is prompted for a number
getNumber "Please type a number between 1 and 100: "

#Tell the user whether their number is above or below the target number (42), and then prompt user for another guess.
#The script will keep doing this until the correct number is guessed.
while (( $REPLY != 42 ))
do
    if [ $REPLY -lt 42 ]
    then
        echo "Too low!"
    elif [ $REPLY -gt 42 ]
        then
            echo "Too high!"
    fi
    getNumber "Please type a number between 1 and 100: "
done

#If the user correctly guesses 42, display a nice flashing sign telling them they're correct.
if [ $REPLY -eq "42" ]
then
    echo -e "\e[1;3;5;32mRIGHT!!\e[0m"
    exit 0
fi