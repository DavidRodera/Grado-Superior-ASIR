#!/bin/bash
clear

echo 'Bienvenido al sistema de gestión de archivos'
echo '==================================='
echo '           MENÚ PRINCIPAL'
echo '==================================='
echo '1. Mostrar contenido del directorio'
echo '2. Multiplicar dos valores'
echo '3. Cambiar permisos de archivo'
echo '4. Cambiar propietario y grupo'
echo '5. Crear archivo con contenido'
echo '6. Salir'
echo '==================================='
read -p 'Selecciona una opción [1-6]: ' opcion

case $opcion in
	1)
		echo ''
		echo 'Has seleccionado la opción "Mostrar contenido del directorio"'
		echo ''
		read -p 'Introduce la ruta del directorio: ' directorio
		if [ -d $directorio ]
		then
			echo ''
			ls $directorio
		else
			echo ''
			echo 'El directorio no existe'
		fi
	;;
	2)
		echo ''
                echo 'Has seleccionado la opción "Multiplicar dos valores"'
                echo ''
		read -p 'Introduce el primer valor: ' valor1
		read -p 'Introduce el segundo valor: ' valor2
		echo ''
		echo 'El resultado es' $(($valor1 * $valor2))

	;;
	3)
		echo ''
                echo 'Has seleccionado la opción "Cambiar permisos de archivo"'
                echo ''
                read -p 'Introduce el nombre del archivo: ' archivo
                echo ''
		if [ -f $archivo ]
                then
                        echo 'Formato: ugo+-'
                        echo ''
                        read -p 'Introduce los permisos quieres cambiar: ' permisos
                        echo ''
                        sudo chmod $permisos $archivo
                        ls -l $archivo
		else
			echo 'El archivo no existe'
		fi
	;;
	4)
		echo ''
                echo 'Has seleccionado la opción "Cambiar propietario y grupo"'
                echo ''
		read -p 'Introduce el nombre del archivo o directorio: ' archivo
		echo ''
		if [ -f $archivo ]
		then
			echo 'Propietarios y grupos disponibles: agustin, root'
			echo ''
			read -p '¿A qué propietario quieres cambiar?: ' own
			read -p '¿A qué propietario quieres cambiar?: ' grp
			echo ''
			sudo chown $own $archivo && sudo chgrp $grp $archivo
			ls -l $archivo
		elif [ -d $archivo ]
                then
                        echo 'Propietarios y grupos disponibles: agustin, root'
                        echo ''
                        read -p '¿A qué propietario quieres cambiar?: ' own
                        read -p '¿A qué propietario quieres cambiar?: ' grp
                        echo ''
                        sudo chown $own $archivo && sudo chgrp $grp $archivo
                        ls -ld $archivo

		else
                        echo 'El archivo o direcrorio no existe'

		fi
	;;
	5)
		echo ''
                echo 'Has seleccionado la opción "Crear archivo con contenido"'
                echo ''
                read -p 'Introduce el nombre del archivo: ' archivo
                echo ''
		read -p 'Que información quieres escribir: ' info
		echo ''
		touch $archivo && echo $info >> $archivo
		echo 'Información escrita'
		echo ''
		cat $archivo
	;;
	6)
		echo ''
                echo 'Has seleccionado la opción "Salir"'
                echo ''
		echo 'Bye, bye'
		exit


esac

