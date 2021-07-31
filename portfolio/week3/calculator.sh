#!/bin/bash
#
#User inputs first number
xprompt=`echo -e "\e[3;93mFirst number        : \e[0m"`     #N.B. the extra space is so that all three variables (x, y, and op) line up below each other on the CLI for ease of reading.
read -p "$xprompt" x
#
#User inputs operator
opprompt=`echo -e "\e[3;93mOperator (+,-,*,/,^): \e[0m"`
read -p "$opprompt" op
#
#If user entered something other than +,-,*,/,or ^, then an error message prints and the script exits with code 1
if [ "$op" != "+" ] && [ "$op" != "-" ] && [ "$op" != "*" ] && [ "$op" != "/" ] && [ "$op" != "^" ]
then
    echo -e "\e[3;31mNot a valid operator choice\e[0m"
    exit 1
fi
#
#User inputs second number
yprompt=`echo -e "\e[3;93mSecond number       : \e[0m"`     #N.B. the extra space is so that all three variables (x, y, and op) line up below each other on the CLI for ease of reading.
read -p "$yprompt" y
#
#the first number, followed by the operator, followed by the second number are echoed into the bc (calculator) command
#the output is defined as the "$result" var
result=`echo $x$op$y | bc`
#
#the result is displayed on the command line, with a different colour depending on what operation was performed, and script exits with code 0
case $op in
    +) echo -e "\e[1;34mResult = $result\e[0m"; exit 0 ;;     #addition: blue
    -) echo -e "\e[1;32mResult = $result\e[0m"; exit 0 ;;     #subtraction: green
    /) echo -e "\e[1;35mResult = $result\e[0m"; exit 0 ;;     #division: purple
    ^) echo -e "\e[1;33mResult = $result\e[0m"; exit 0 ;;     #power: yellow
    *) echo -e "\e[1;31mResult = $result\e[0m"; exit 0 ;;     #multiplication: red    it should be noted that "*)" is also the catch-all operator for case statements, hence why it's last in the list
esac
