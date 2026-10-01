#!/bin/bash

if [ $UID -ne 0 ]
then
	echo "Debes ejecutar como root (sudo $0)"
	exit 1
fi

read -p 'Introduce tu nombre: ' nombre
if [ -z "$nombre" ]
then
	echo 'Hola, mundo'
	exit 2
else
	echo "Hola, $nombre"
	exit 3
fi
