#!/bin/bash


if [ $# -eq 0 ] ; then
  echo "Missing arguments: file"
  echo "Example: ./breach.sh emails.txt"
  exit 1
else
    :
fi

emails=`cat $1`

for i in $emails ; do
sleep 2 ; if [[ -z $(curl -s "https://haveibeenpwned.com/unifiedsearch/$i" -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0' -H $'Accept: */*' -H $'Accept-Language: en-#US,en;q=0.5' | grep -i "pwned" | jq) ]]; then : ; else echo -e "\e[31m[Breached]: \e[32m$i" | tee -a breached_mails.txt; 
fi ;
done
echo -e "\n\nResults saved to breached_emails.txt"
cat breached_mails.txt 2>/dev/null | awk -F ":" '{print $2}' | sed '/^$/d;s/[[:blank:]]//g' > breached_emails.txt
rm breached_mails.txt 2>/dev/null
