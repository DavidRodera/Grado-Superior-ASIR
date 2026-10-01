#!/bin/bash

read -p "Introduce un número: " num
if ! [[ "$num" =~ ^-?[0-9]+?$ ]]
then
	echo 'Debes introducir un número entero'
	exit 1
fi

while true;
do
	echo $num
	num=$(($num - 1))
	sleep 1
if [ $num -eq 0 ]
then
	echo "Despegue!"
	break
fi
done
