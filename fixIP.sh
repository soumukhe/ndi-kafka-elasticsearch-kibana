#!/bin/bash

if [[ $# -eq 0 ]] ; then
	echo ""
	echo "please run script with the IP as parameter"
	echo "e.g.  ./fixIP 10.10.140.10"
	echo "you can get the ip of the vm by  ip a"
	echo ""
        exit 1
fi

sed -i "s/X.X.X.X/$1/g" docker-compose.yaml
