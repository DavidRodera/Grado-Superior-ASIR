#!/bin/bash

if [ $UID -ne 0 ];
then
	echo 'Debes acceder al script como administrador'
	echo ''
	exit
fi

clear
while true;
do
read -p 'Introduce el programa en ejecución: ' programa
echo ''
if pidof $programa &>/dev/null;
then
	echo 'El programa esta en ejecución'
	echo ''
	id=$(pidof $programa)
	break
else
	echo 'El programa no está en ejecución'
	echo ''
fi
done 

while true;
do
read -p 'Introduce la señal a enviar (1-64): ' num
echo ''
if [ $num -ge 1 ] && [ $num -le 64 ];
then
	echo "Señal $num a $programa"
	echo -n "Ejecutando señal"
	for i in {1..3}; do
	echo -n '.'
	sleep 0.2
	done
	echo ''
	break
else
	echo 'La señal debe de ser un número entre 1 y 64'
	echo ''
fi
done 

kill $num $id 2>/dev/null
if [ $? -eq 0 ];
then
	echo ''
	echo 'Señal ejecutada con éxito'
else
	echo ''
	echo 'Error al ejecutar la señal'
	exit
fi
