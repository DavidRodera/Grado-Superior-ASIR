#!/bin/bash
clear

echo "==========================="
echo "MENU PRINCIPAL"
echo "==========================="
echo "1) Crear directorio"
echo "2) Crear archivo"
echo "3) Multiplicar"
echo "4) Salir"
echo "==========================="
read -p "¿Qué desea hacer?: " opcion

case $opcion in
	1)
		read -p "¿Como desea llamar al directorio?: " nombre1
		mkdir $nombre1 2>/dev/null
		if [ $? -eq 0 ]
		then
			echo "Se ha creado el directorio" $nombre1
			 ls -ld $nombre1
		else
			echo "No se ha podido crear el directorio"
		fi
		;;
	2)
		read -p "¿Como desea llamar al archivo?: " nombre2
		read -p "¿Qué extensión quieres?: " extension
		if [ -e $nombre2.$extension ]
		then
			echo "Ya existe el archivo, hasta la proxima"
			exit
		fi
		touch $nombre2.$extension 2>/dev/null
		if [ $? -eq 0 ]
		then
			touch $nombre2.$extension
			echo "Se ha creado el archivo"
			ls -ld $nombre2.$extension
		fi
		;;
	3)
		read -p "Elige el primer número: " num1
		read -p "Elige el segundo número: " num2
		echo "El resultado es" $(($num1*$num2))
		;;
	4)
		echo "Bye, bye"
		;;
esac
