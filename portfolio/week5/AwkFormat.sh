#!/bin/bash

#This script takes an unformatted textfile containing Google server IP addresses and uses awk to display the contents in a nicely formatted table.

echo "Google Server IPs:"   #Print a title

#Take the data from input.txt, and format the data using ":" as the field separator.
awk 'BEGIN {
    FS=":";
    print "________________________________";
    print "| \033[34mServer Type\033[0m | \033[34mIP            \033[0m |";
}
{
    printf("| \033[33m%-11s\033[0m | \033[35m%-14s\033[0m |\n", $1, $2);
}
END {
    print("________________________________");
}' input.txt
exit 0