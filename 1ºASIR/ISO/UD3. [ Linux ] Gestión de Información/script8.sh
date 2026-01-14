#!/bin/bash
clear

echo "Año bisiesto"
echo "By David Rodera"
read -p "Escribe un año: " year

if [ $(($year % 4)) -eq 0 ]
then
	echo "Es un año bisiesto"
else
	echo "No es un año bisiesto"
fi
