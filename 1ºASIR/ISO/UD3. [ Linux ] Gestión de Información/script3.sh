#!/bin/bash

clear

echo "Par o Impar"
echo "By David Rodera"
read -p "Escribe un número: " numero

if [ $(($numero % 2)) -eq 0 ]

then

	echo "ES par"

else
	
	echo "Es impar"

fi


