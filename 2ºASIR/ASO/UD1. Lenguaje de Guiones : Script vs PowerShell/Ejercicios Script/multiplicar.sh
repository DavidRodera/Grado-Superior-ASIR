#!/bin/bash

read -p "Introduce un número: " num
if ! [[ "$num" =~ ^-?[0-9]+?$ ]]
then
	echo 'Debes introducir un número entero'
	exit 1
fi

for i in {1..10}
do
	echo "$num x $i = $(($num * $i))"
	sleep 0.2
done
