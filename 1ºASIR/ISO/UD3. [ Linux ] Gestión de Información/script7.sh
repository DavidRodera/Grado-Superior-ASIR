#!/bin/bash
clear

echo "Signo Zodiacal"
echo "By David Rodera"
echo "----------------------------
	1) Enero
	2) Febrero
	3) Marzo
	4) Abril
	5) Mayo
	6) Junio
	7) Julio
	8) Agosto
	9) Septiembre
	10) Octubre
	11) Noviembre
	12) Diciembre"
read -p "Escribe un mes: " mes

if [ $mes -le 0 ] || [ $mes -ge 13 ]
then
	echo "Ese mes no existe"
elif [ $mes -le 6 ]
then
	echo "Pertenece al 1º semestre"
else
	echo "Pertenece al 2º semestre"
fi
