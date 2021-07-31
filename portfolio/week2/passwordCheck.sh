#!/bin/bash
#
#User is asked to input their password.
prompt=`echo -e "\e[36mPlease enter your secret password: \e[0m"`
read -sp "$prompt" secretPassword
#
#The password entered is then used to produced a hash, which is compared to the hash stored in the file produced from setPassword.sh.
 echo $secretPassword | sha256sum -c --status "../week2/$(whoami)/$(whoami).txt"
#
#Was the hash check successful? 0=yes, 1=no.
if [ $? -eq 0 ]
then                #If the hash check was successful (i.e. they match), then an "access granted" message is displayed and the script exits with a code 0.
  echo
  echo -n -e "\e[32mPassword correct:\e[0m"
  echo -e "\e[3;32m access granted.\e[0m"
  exit 0
else                #If the hash check was not successful (i.e. they don't match), then an "access denied" message is displayed and the script exits with a code 1.
  echo
  echo -n -e "\e[1;30;41mPassword incorrect: \e[0m"
  echo -e "\e[1;5;30;41mACCESS DENIED!\e[0m"
  exit 1
fi
