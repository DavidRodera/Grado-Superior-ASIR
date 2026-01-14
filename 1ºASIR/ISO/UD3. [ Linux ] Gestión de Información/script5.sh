#!/bin/bash
clear

echo "Día Laboral"
echo "By David Rodera"
read -p "Escribe un día (1-7) de la semana: " dia

if [ $dia -ge 8 ] || [ $dia -le 0 ]
then
	echo "Eso no es un dÍa de la semana"
elif [ $dia -le 5 ] && [ $dia -ge 1 ]
then
	echo "Es dÍa laboral"
else
	echo "Es fin de semana"
fi

