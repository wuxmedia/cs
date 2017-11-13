#!/bin/bash
#get name from command line:
DOM=$1
echo -e "\e[35mName Servers: \e[39m"
echo "$(dig NS "$DOM" +short)"
echo -e '\e[35mHOST:\e[39m' 
echo "$(host "$DOM")"
echo -e '\e[35mREVERSE LOOKUP:\e[39m'
echo "$(host $(dig A $DOM +short))"
echo -e '\e[35mHTTP REQUEST:\e[39m'
echo "$(curl -I $DOM 2> /dev/null| grep -e "HTTP" -e "Location" )"
