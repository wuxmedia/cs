#!/bin/bash
### domain overview tool
if [ "$*" == "" ]; then
    echo "Please supply a domain to check"
    exit 1
fi
#get name from command line and strip http(s):// from it and any trailing slashes:
DOM=$(echo "$1" | sed 's~http[s]*://~~g' | sed 's:/*$::' )
echo -e "NAME SERVERS:"
dig NS "$DOM" +short
echo -e "CF NAME SERVERS:"
dig NS @ns1.cloudflare.com "$DOM" +short
echo -e "CF A RECORDS:"
dig A @ns1.cloudflare.com "$DOM" +short
echo -e 'HOST:' 
host "$DOM"
echo -e 'DNSSEC?:' 
dig DS "$DOM" +short
whois "$DOM" | grep DNSSEC | head -n1
echo -e 'HTTP REQUEST:'
curl --max-time 5 -sI "$DOM" | grep -e "HTTP" -e "Location"
curl --max-time 5 -sI "$DOM" | grep -ie "x-kinsta-cache"
echo -e 'SSL INFO:'
echo|openssl s_client -servername $DOM -connect $DOM:443 2>/dev/null | openssl x509 -noout -text | grep -e DNS: -e Subject: -e "Not "  -e Issuer: | sed -e 's/^[ \t]*//'
