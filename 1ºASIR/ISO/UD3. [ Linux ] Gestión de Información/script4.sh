#!/bin/bash

clear

echo "Aprobado o Suspenso"
echo "By David Rodera"
read -p "Escribe una nota: " nota

if [ $nota -ge 5 ]

then

	echo "Estarías aprobado"

elif [ $nota -lt 5 ]

then 

        echo "Estarías suspenso"

elif [ $nota -lt 0 -o $nota -gt 10 ]

then

	echo "No puedes tener esa nota"

fi

