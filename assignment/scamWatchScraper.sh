#!/bin/bash

#################################################################################
#                                                                               #
# This script is used to obtain current data from the scamwatch.gov.au website  #
# and present it in easy-to-read, pre-formatted tables; as well as a graph      #
# using gnuplot.                                                                #
#                                                                               #
# ATTENTION:  gnuplot is required for full functionality of this script.        #
#                                                                               #
#################################################################################


#Define aliases
url="https://www.scamwatch.gov.au/news-alerts"
categurl="https://www.scamwatch.gov.au/news-alerts?f[0]=scam_category%3A"
dateurl="https://www.scamwatch.gov.au/news-alerts?f[0]=date%3A"

#Create working sub-directory if not already present
if [ ! -d "files" ]
then
    mkdir "files"
fi

#Prevents an annoying warning message from appearing when graphing due to a deprecated feature in gnuplot (the warnings are related to screen display, and executing these commands pose no functional or security risk).
export QT_DEVICE_PIXEL_RATIO=0
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=1
export QT_SCALE_FACTOR=1


##### FUNCTIONS #####
getData()       #Obtain and parse data, keeping only relevant information. Data is re-retreived each time, so that all data are up-to-date.
{
    curl -sg $url | grep '"date-' | tr [:space:] '\n' | grep -E '(count|value=)' | tr -d '\n' | sed -e 's/><span/\n/g' -e 's/"/ /g' -e 's/data-drupal-facet-item-//g' -e 's/value= //g' -e 's/count= //g' > ./files/dates.txt
    curl -sg $url | grep '"scam-category-' | tr '\<' '\n\<' | grep -E '(count|_value)' | sed 's/count=/\ncount=/' | grep -E '(count|_value)' | sed -e 's/span class="facet-item__//' -e 's/>//' -e 's/$/ /' | tr -d '\n' | sed 's/ count/\ncount/g' | sed -e 's/amp;//' -e 's/count=\"//g' -e 's/" value"/ /g' -e 's/ /,/' -e 's/ $//' > ./files/categories.txt
}

dateTable()     #Format date data into a table.
{
    awk 'BEGIN {
        FS=" ";
        print "__________________________";
        print "| \033[34mDate\033[0m | \033[34mNumber of scams\033[0m |";
        print "--------------------------";
    }
    {
        printf("| \033[93m%-4s\033[0m | \033[95m%15s\033[0m |\n", $1, $2);
    }
    END {
        print("__________________________");
    }' ./files/dates.txt
}

categTable()    #Format category data into a table.
{
    awk 'BEGIN {
        FS=",";
        print "________________________________________________________________";
        print "| \033[34mScam category                             \033[0m | \033[34mNumber of scams\033[0m |";
        print "----------------------------------------------------------------";
    }
    {
        printf("| \033[93m%-42s\033[0m | \033[95m%15s\033[0m |\n", $2, $1);
    }
    END {
        print("________________________________________________________________");
    }' ./files/categories.txt
}

printData()     #Combine the tabulated date and category data and display side by side, for easier reading.
{
    paste "./files/dates1.txt" "./files/categories1.txt" | cat
}

graphMenu()     #Display a menu providing options to see the data graphed either in the terminal, or output graphically.
{
    echo
    echo -e "\e[3m>Type '1' to see these data as a graph within the terminal (less precise).\e[0m"
    echo -e "\e[3m>Type '2' to output these data as an external graph (more precise).\e[0m"
    echo -e "\e[3m>Otherwise, press enter to see the main menu.\e[0m"
    read -p "" graph
}

categGraph()    #Displays category data (for a given year) as a bar graph
{
    if [ "$graph" = 1 ]
    then
        gnuplot -p ./files/graphCategoriesDumb.gnu      #In terminal
    elif [ "$graph" = 2 ]
    then
        gnuplot -p ./files/graphCategories.gnu          #Grpahically/externally
    fi
}

dateGraph()     #Displays date data (for a given category) as a bar graph
{
    if [ "$graph" = 1 ]
    then
        gnuplot -p ./files/graphDatesDumb.gnu           #In terminal
    elif [ "$graph" = 2 ]
    then
        gnuplot -p ./files/graphDates.gnu               #Grpahically/externally
    fi
}



############################################################
##################          MAIN          ##################
############################################################

#This initial block clears the terminal and presents the overall aggregate data in two tables side-by-side.
clear >$(tty)
echo -e "\e[3;93mNumber of scams by date and category - ACCC Scamwatch (scamwatch.gov.au)\e[0m"
getData
dateTable > ./files/dates1.txt
categTable > ./files/categories1.txt
printData

#This main block ensures that, until the user chooses to exit the script, the script will keep running.
#The user will always return to these main menu options and asked to make a choice.
until [ ]
do
    #Main Menu
    echo
    echo -e "\e[32mWhat would you like to do?\e[0m"
    echo -e "\e[3m>Type a year to display what scams occurred in a given year (e.g. \"2020\").\e[0m"
    echo -e "\e[3m>Type a scam category to display in what years they occurred (e.g. \"Investments\").\e[0m"
    echo -e "\e[3m>Type \"top\" to see the original, top-level data table shown at the beginning.\e[0m"
    echo -e "\e[3m>Type \"exit\" to exit.\e[0m"
    echo
    read -p "" option
    option=$( tr '[:upper:]' '[:lower:]' <<<"$option" )     #This ignores case-input by converting everything to lower-case

#For all options (except "top", "exit", and the catch-all case) the table of relevant data is displayed, then the user is asked if they would like the data graphed.
    case "$option" in
        20[0-9][0-9])       clear >$(tty); url="${dateurl}${option}";
                            echo -e "\e[3;93mScam categories for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; categTable;
                            graphMenu; categGraph;;

        attempts\ to\ gain\ your\ personal\ information)        clear >$(tty); url="${categurl}29";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;

        buying\ or\ selling)        clear >$(tty); url="${categurl}15";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;

        dating\ [\&\+]\ romance|dating\ and\ romance)       clear >$(tty); url="${categurl}13";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        fake\ charities)        clear >$(tty); url="${categurl}14";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        investments)        clear >$(tty); url="${categurl}24";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        jobs\ [\&\+]\ employment|jobs\ and\ employment)     clear >$(tty); url="${categurl}154";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        threats\ [\&\+]\ extortion|threats\ and\ extortion)     clear >$(tty); url="${categurl}32";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        unexpected\ money)      clear >$(tty); url="${categurl}4";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        unexpected\ winnings)       clear >$(tty); url="${categurl}9";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        other\ scams)       clear >$(tty); url="${categurl}155";
                            echo -e "\e[3;93mBreakdown by year for $option - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                            getData; dateTable;
                            graphMenu; dateGraph;;
        
        #"top" runs the initial data retrieval and table display. I.e.: the code before the beginning of the "until" statment.
        top)        clear >$(tty); url="https://www.scamwatch.gov.au/news-alerts";
                    echo -e "\e[3;93mNumber of scams by date and category - ACCC Scamwatch (scamwatch.gov.au)\e[0m";
                    getData; dateTable > ./files/dates1.txt; categTable > ./files/categories1.txt; printData;;

        #Exits the script with code 0
        exit)       echo -e "\t\e[3;93mGoodbye!\e[0m"; sleep 0.5; exit 0;;

        #It's anticipated that the most common reason for triggering this catch-all case is due to a misspelling, as such the user is prompted to double-check theirs.
        *)          echo -e "\t\e[3;33mNot a valid option (is the spelling correct?)\e[0m"; sleep 0.5;;

    esac
done