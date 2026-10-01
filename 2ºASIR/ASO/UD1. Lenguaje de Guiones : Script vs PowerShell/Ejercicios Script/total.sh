#!/bin/bash

total=0
while true;
do
	read -p "Introduce un número: " num
	total=$(($total + $num))
	echo "Total = $total"
if [ "$num" == "fin" ]
then
	break
fi
done
