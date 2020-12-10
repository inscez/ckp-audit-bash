#!/bin/bash
echo "This is only designed for R80.40"
fw ver | grep 'R80.40' -q

if [ $? == 0 ]; then
echo "Running script"

#echo "$1"
ip=$1


if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
        && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
stat=$?
#echo $stat
else echo "The Syslog Server IP is invalid; Please add one using the following syntax: add_syslog_server.sh <IP.Address> " ; exit 1;
fi

if [ $stat -eq 0 ]; then
server=$1
echo "New Syslog Server IP is $server"
clish -c "add syslog log-remote-address $server level info"
if [ $? -eq 0 ]; then  echo "Added server $server"; else echo "Errpr; Could not add server to syslog";  fi
clish -c "save config"
if [ $? -eq 0 ]; then  echo "Saved configuration" ; else echo "Error; could not save confiuration";  fi
echo "Current Logging configuration"
clish -c "show syslog all"

else echo "Error, invalid IP address for the syslog server"; exit 1;
fi
else exit 1;
fi
