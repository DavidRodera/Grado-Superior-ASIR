#!/bin/bash

clear

echo "Determinar el valor de un número"
echo "By David Rodera"
read -p "Escribe un número: " numero

if [ $numero -lt 0 ]

then

	echo "El número es negativo"

elif [ $numero -eq 0 ]

then
	
	echo "El número es 0"

elif [ $numero -gt 0 ]

then

	echo "El número es positivo"

fi
