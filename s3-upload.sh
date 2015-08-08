#!/bin/bash
source ~/master/.aws-cred
file=$1
linkName=$2
fileName=`basename ${file}`
bucket=mgba
resource="/${bucket}/${fileName}"
contentType="application/x-compressed"
dateValue=`date -R`

stringToSign="PUT\n\n${contentType}\n${dateValue}\nx-amz-acl:public-read\nx-amz-storage-class:REDUCED_REDUNDANCY\n${resource}"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT -T "${file}" \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  -H "x-amz-acl: public-read" \
  -H "x-amz-storage-class: REDUCED_REDUNDANCY" \
  https://${bucket}.s3.amazonaws.com/${fileName}

stringToSign="PUT\n\n\n${dateValue}\nx-amz-acl:public-read\nx-amz-copy-source:${resource}\nx-amz-storage-class:REDUCED_REDUNDANCY\n/${bucket}/${linkName}"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  -H "x-amz-acl: public-read" \
  -H "x-amz-copy-source: ${resource}" \
  -H "x-amz-storage-class: REDUCED_REDUNDANCY" \
  https://${bucket}.s3.amazonaws.com/${linkName}

exit $?
