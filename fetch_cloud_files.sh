#!/bin/bash

echo -n "Enter the API Key for CloudFiles: "
read APIKEY
echo -n "Enter the filename to download: "
read FILENAME

TMPFILE=$(mktemp)

curl -X GET https://identity.api.rackspacecloud.com/v1.0 -H "X-Auth-User: incidentservice" -H "X-Auth-Key: ${APIKEY}" -H "Content-Type: application/xml" -H "Accept: application/xml" -D - 2>/dev/null|awk '/X-Auth-Token:/ || /X-Storage-Url:/ {print $2}' > ${TMPFILE} 

TOKEN=`awk '!/^https:/ {print $0}' ${TMPFILE}`
STURL=`awk '/^https:/ {print $0}' ${TMPFILE} |sed "s/.$//"`
rm ${TMPFILE}

curl -O -X GET ${STURL}/storage-cloud/${FILENAME} -H "X-Auth-Token:${TOKEN}"

MAILMSG=$(mktemp)
echo "Your file, $FILENAME, has been attached to this message." > ${MAILMSG}

mail -s "File from Cloud" -a ${FILENAME} you@wherever.com < ${MAILMSG}
rm ${MAILMSG}
