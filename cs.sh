#!/bin/bash
### domain overview tool
#get name from command line and strip http(s):// from it:
DOM=$(echo "$1" | sed 's~http[s]*://~~g')
echo -e "\e[35mName Servers: \e[39m"
dig NS "$DOM" +short
echo -e '\e[35mHOST:\e[39m' 
host "$DOM"
echo -e '\e[35mREVERSE LOOKUP:\e[39m'
host $(dig A "$DOM" +short)
echo -e '\e[35mPRIMARY MX LOOKUP:\e[39m'
dig A +short $(dig MX "$DOM" +short | grep -oE '[^ ]+$' | head -n1)
echo -e '\e[35mHTTP REQUEST:\e[39m'
curl --max-time 5 -sI "$DOM" | grep -e "HTTP" -e "Location"

