#!/bin/bash
clear

echo "Mayor de 3 números"
echo "By David Rodera"
read -p "Escribe el 1º número: " num1
read -p "Escribe el 2º número: " num2
read -p "Escribe el 3º número: " num3

if [ $num1 -gt $num2 ] && [ $num1 -gt $num3 ]
then
	echo "El número mayor es el 1º"
elif [ $num2 -gt $num1 ] && [ $num1 -gt $num3 ]
then
        echo "El número mayor es el 2º"
else
	echo "El número mayor es el 3º"
fi

