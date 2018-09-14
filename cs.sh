#!/bin/bash
### domain overview tool
if [ "$*" == "" ]; then
    echo "Please supply a domain to check"
    exit 1
fi
#get name from command line and strip http(s):// from it and any trailing slashes:
DOM=$(echo "$1" | sed 's~http[s]*://~~g | sed 's:/*$::' )
echo -e "\e[35mNAME SERVERS: \e[39m"
dig NS "$DOM" +short
echo -e '\e[35mHOST:\e[39m' 
host "$DOM"
echo -e '\e[35mREVERSE LOOKUP:\e[39m'
host $(dig A "$DOM" +short)
echo -e '\e[35mPRIMARY MX LOOKUP:\e[39m'
dig A +short $(dig MX "$DOM" +short | sort -n  | head -n1) | head -n1
echo -e '\e[35mHTTP REQUEST:\e[39m'
curl --max-time 5 -sI "$DOM" | grep -e "HTTP" -e "Location"
echo -e '\e[35mSSL INFO:\e[39m'
echo|openssl s_client -servername $DOM -connect $DOM:443 2>/dev/null | openssl x509 -noout -text | grep -e DNS: -e Subject: -e "Not "  -e Issuer: | sed -e 's/^[ \t]*//'
