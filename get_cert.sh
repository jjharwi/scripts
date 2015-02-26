#!/bin/bash

openssl s_client -connect $1:636 2>/dev/null </dev/null | openssl x509 -noout -text | egrep 'Not\ Before|Not\ After|Subject\:|Issuer\:' 
