#!/bin/bash
#get name from command line and strip http(s):// from it:
DO=$1
DOM=$(echo "$DO" | sed 's~http[s]*://~~g')
echo -e "\e[35mName Servers: \e[39m"
dig NS "$DOM" +short
echo -e '\e[35mHOST:\e[39m' 
host "$DOM"
echo -e '\e[35mREVERSE LOOKUP:\e[39m'
host $(dig A $DOM +short)
echo -e '\e[35mHTTP REQUEST:\e[39m'
curl -sI $DOM | grep -e "HTTP" -e "Location"
