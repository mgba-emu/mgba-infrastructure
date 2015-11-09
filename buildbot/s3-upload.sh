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
if [ "$1" = "nightly"]
  extraHeader=-H "x-amz-storage-class: REDUCED_REDUNDANCY"
fi

stringToSign="PUT\n\n${contentType}\n${dateValue}\nx-amz-acl:public-read\nx-amz-storage-class:REDUCED_REDUNDANCY\n${resource}"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT -T "${file}" \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  -H "x-amz-acl: public-read" \
  $extraHeader \
  https://${bucket}.s3.amazonaws.com/${prefix}${fileName}

ret=$?

if [ -n "$linkName" ]; then
	stringToSign="PUT\n\n\n${dateValue}\nx-amz-acl:public-read\nx-amz-copy-source:${resource}\nx-amz-storage-class:REDUCED_REDUNDANCY\n/${bucket}/${linkName}"
	signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
	curl -X PUT \
	  -H "Host: ${bucket}.s3.amazonaws.com" \
	  -H "Date: ${dateValue}" \
	  -H "Authorization: AWS ${s3Key}:${signature}" \
	  -H "x-amz-acl: public-read" \
	  -H "x-amz-copy-source: ${resource}" \
	  $extraHeader \
	  https://${bucket}.s3.amazonaws.com/${linkName}

	ret=$?
fi

exit $ret
