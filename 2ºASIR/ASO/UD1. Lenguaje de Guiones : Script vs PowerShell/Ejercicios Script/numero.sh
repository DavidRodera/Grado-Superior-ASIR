#!/bin/bash

read -p "Introduce un número: " num
if ! [[ "$num" =~ ^-?[0-9]+?$ ]]
then
	echo 'Debes introducir un número entero'
	exit 1
fi

if [ "$(($num % 2))" -eq 0 ]
then
	echo "El número $num es par"
	exit 2
else
	echo "El número $num es impar"
	exit 3	
fi
