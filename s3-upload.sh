#!/bin/bash
source ~/master/.aws-cred
prefix=$1
file=$2
linkName=$3
fileName=`basename ${file}`
bucket=mgba
resource="/${bucket}/${prefix}${fileName}"
contentType="application/x-compressed"
dateValue=`date -R`
storageClass=STANDARD

stringToSign="PUT\n\n${contentType}\n${dateValue}\nx-amz-acl:public-read\nx-amz-storage-class:${storageClass}\n${resource}"
echo $stringToSign
echo $storageClass
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT -T "${file}" --retry 3 \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  -H "x-amz-acl: public-read" \
  -H "x-amz-storage-class: ${storageClass}" \
  https://${bucket}.s3.amazonaws.com/${prefix}${fileName} || exit $?

if [ -n "$linkName" ]; then
	stringToSign="PUT\n\n\n${dateValue}\nx-amz-acl:public-read\nx-amz-copy-source:${resource}\nx-amz-storage-class:STANDARD\n/${bucket}/${linkName}"
	signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
	curl -X PUT --retry 3 \
	  -H "Host: ${bucket}.s3.amazonaws.com" \
	  -H "Date: ${dateValue}" \
	  -H "Authorization: AWS ${s3Key}:${signature}" \
	  -H "x-amz-acl: public-read" \
	  -H "x-amz-copy-source: ${resource}" \
	  -H "x-amz-storage-class: ${storageClass}" \
	  https://${bucket}.s3.amazonaws.com/${linkName} || exit $?
fi
