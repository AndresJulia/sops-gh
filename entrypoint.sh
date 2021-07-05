#!/bin/sh -l 
SECRET_REGEX="AES256"
secretFiles=$(ls -R . | awk '
/:$/&&f{s=$0;f=0}
/:$/&&!f{sub(/:$/,"");s=$0;f=1;next}
NF&&f{ print s"/"$0 }'  | grep $1)

for file in $secretFiles
do
	if [ "$(grep -c $SECRET_REGEX $file)" -eq 0 ]; then
		echo "$file left unencrypted, exiting."
		exit 1;
	fi
done