#!/bin/bash

# Check for SSD connection

if [ -f /mnt/ssd/Iota/docker-compose.yml ]
then
	echo
        exit 0
else
        echo
	echo "SSD not found, trying to mount..."
	echo
	if [ ! -f ~/uuidSSD.ini ]
	then
		echo
                echo "ERROR: File ~/uuidSSD.ini not found!"
                echo
		exit 1
	else
		uuidSSD=$(cat ~/uuidSSD.ini)
		if [ "$uuidSSD" == "" ]
		then
			echo
			echo "ERROR: A uuidSSD.ini file was found, but the content was empty!"
			echo
			exit 1
		fi
	fi
	mount "UUID=$uuidSSD" /mnt/ssd
	counter=1
	while [ true ]
	do
		if [ -f /mnt/ssd/Iota/docker-compose.yml ]
		then
			echo
			echo "SSD Mounted!"
			exit 0
		elif [ $counter -lt 10 ]
		then
			counter=$(($counter+1))
			sleep 0.5
		elif [ $counter -eq 10 ] || [ $counter -gt 10 ]
		then
			echo
			echo "Aborting because of timeout..."
			exit 1
		fi
	done
fi
