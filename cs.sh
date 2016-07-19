#!/bin/bash
### domain overview
#get name from command line:
DOM=$1
echo "$(dig NS "$DOM" +short)"
echo "$(host "$DOM")"
#isitup?
echo "$(http "$DOM" --headers | head -n4)"
