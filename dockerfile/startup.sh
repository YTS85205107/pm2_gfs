#!/bin/bash
bool=0
echo "10.2.166.11       U6011" >> /etc/hosts
echo "10.2.166.12       U6012" >> /etc/hosts
while [ $bool -ne 1 ]; do
    host=U60$(shuf -i 11-12 -n 1)
    echo $host
    ping -W 1 -c1 $host
    SUCCESS=$?
    if [[ $SUCCESS < 1 ]]; then
        mount -t glusterfs $host:/tsreward /pm2
        pm2-runtime start /pm2/pm2.json
        bool=1
    fi 
done