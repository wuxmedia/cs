# cs
checks a site's DNS out - showing MX and A records, does a cheeky reverse DNS to see what machine it is on currently, a quick Primary MX A record check to see where the mail is at, then checks basic HTTP status and simple Cert info
Now in colour!

usage: cs [http(s)://domain.com]
-- that's it.

-- requires 'curl' and 'dig'
