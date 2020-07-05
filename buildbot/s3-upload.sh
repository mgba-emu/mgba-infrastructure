#!/bin/bash
prefix=$1
file=$2
linkName=$3
fileName=`basename ${file}`
bucket=mgba
contentType="${4:-application/x-compressed}"
storageClass=STANDARD
acl="${5:-public-read}"

aws s3 cp --quiet --acl ${acl} --storage-class ${storageClass} --content-type ${contentType} "${file}" "s3://${bucket}/${prefix}${fileName}"

if [ -n "$linkName" ]; then
	aws s3 cp --quiet --acl ${acl} --storage-class ${storageClass} --content-type ${contentType} "s3://${bucket}/${prefix}${fileName}" "s3://${bucket}/${linkName}"
fi
