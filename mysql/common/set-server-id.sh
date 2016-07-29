#!/bin/bash
ip2dec=$(find . -name "ip2dec.awk")
mysid=$($ip2dec $(ip addr | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}' | awk -F/ '{print $1}'))
echo "Server ID Is: $mysid"
sed -i "s/server-id\ =\ 1/server-id\ =\ $mysid/g" /etc/my.cnf
echo "Done"
