#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Debes ejecutar $0 con un parámetro"
	exit 1
fi

if [ ! -f "$1" ]
then
	echo "Error: El archivo '$1' no existe o no es válido"
	exit 2
fi

read -p "Introduce una palabra: " word
if [ -z "$word" ]
then
	echo "Debes introducir una palabra"
	exit 3
fi

num_linea=0
coincidencias=0
while IFS= read -r linea
do
	((num_linea++))

	if [[ "$linea" =~ $word ]]
	then
		echo "Línea $num_linea: $linea"
		((coincidencias++))
	fi
done < $1

echo "----------------------------------------"
if [ "$coincidencias" -eq 0 ]
then
	echo "No se encontraron coincidencias para la palabra '$word'."
else
	echo "Se encontraron $coincidencias línea(s) con la palabra '$word'."
fi
