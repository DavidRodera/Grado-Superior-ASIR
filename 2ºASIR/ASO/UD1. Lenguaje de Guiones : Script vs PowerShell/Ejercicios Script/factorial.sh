#!/bin/bash

read -p "Introduce un número: " num
if ! [[ "$num" =~ ^[0-9]+?$ ]]
then
	echo 'Debes introducir un número entero positivo'
	exit 1
fi

num_inicial=$num
total=1
while [ "$num" -gt 1 ];
do
	total=$(($total * $num))
	num=$((num - 1))
done	

echo $num_inicial"! = $total"
