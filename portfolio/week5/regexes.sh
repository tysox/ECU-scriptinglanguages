#!/bin/bash

#all sed statements
echo -e "\e[4msed statements:\e[0m"
grep -r --colour '\bsed\+\b' ../
echo
#all lines that start with the letter m
echo -e "\e[4mLines that start with the letter m:\e[0m"
grep -r -i --colour '^m' ../
echo
#all lines that contain three digit numbers
echo -e "\e[4mLines that contain three digit numbers:\e[0m"
grep -rE --colour '[[:digit:]]{3}' ../
echo
#all echo statements with at least three words
echo -e "\e[4mecho statements with at least three words:\e[0m"
grep -rE --colour 'echo\s(-[a-zA-Z]+\s)*"(.+\s){3,}.*"' ../
echo
#all lines that would make a good password (use your knowledge of cybersecurity to decide what makes a good password).
echo -e "\e[4mLines that would make a good password:\e[0m"
#This SHOULD work... I don't know why it isn't!
grep -rE --colour '((?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,16})' ../
echo