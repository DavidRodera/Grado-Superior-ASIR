#!/bin/bash

clear
echo '========================================================================'
echo '                            MENÚ PRINCIPAL'
echo '========================================================================'
echo '0) Salir'
echo '1) Mostrar los permisos'
echo '2) Cambiar los permisos del archivo en octal'
echo '3) Cambiar los permisos del archivo utilizando la nomenclatura ugo y +-'
echo '4) Cambiar los permisos del archivo utilizando la nomenclatura ugo y ='
echo '5) Cambiar grupo de propietarios de un archivo'
echo '========================================================================'
read -p '¿Qué desea hacer?: ' opcion
echo '========================================================================'
case $opcion in
	0)
		echo 'Has seleccionado la opción "Salir"'
		echo 'Bye, bye'
		echo '========================================================================'
	;;
	1)
		echo 'Has seleccionado la opción "Mostrar los permisos"'
		echo ''
		echo 'Archivos disponibles:'
		echo ''
		ls -R
		echo ''
		read -p 'Introduce el nombre del archivo (recuerda escribir la ruta): ' archivo
		if [ -f $archivo ]
		then
			ls -l $archivo
			echo '========================================================================'

		elif [ -d $archivo ]
		then
			ls -ld $archivo
			echo '========================================================================'

		else
			echo 'El archivo indicado no existe'
			echo '========================================================================'
		fi
	;;
	2)
		echo 'Has seleccionado la opción "Cambiar los permisos del archivo en octal"'
		echo ''
                echo 'Archivos disponibles:'
                echo ''
                ls -R
                echo ''
                read -p 'Introduce el nombre del archivo en el que quieres cambiar los permisos (recuerda escribir la ruta): ' archivo
		echo ''
		echo '========================================================================'
		echo ''
		if [ -f $archivo ]
		then
			echo 'Cambiando permisos al archivo' $archivo
			echo ''
			echo 'Valores de permisos (recuerda que debes de hacer sumas entre los valores de los diferentes permisos):'
			echo ''
			echo 'Valor:           4               2               1                 Primer dígito: Usuario'
			echo '                                                                   Segundo dígito: Grupo de propietarios'
			echo 'Permiso:        Leer          Escribir        Ejecutar             Tercer dígigto: Otros'
			echo ''
			read -p 'Introduce el valor en octal para cambiar los permisos: ' octal
			chmod $octal $archivo
			echo ''
			ls -l $archivo
			echo '========================================================================'

		elif [ -d $archivo ]
                then
                        echo 'Cambiando permisos al directorio' $archivo
                        echo ''
			echo 'Valores de permisos (recuerda que debes de hacer sumas entre los valores de los diferentes permisos):'
                        echo ''
                        echo 'Valor:           4               2               1                 Primer dígito: Usuario'
                        echo '                                                                   Segundo dígito: Grupo de propietarios'
                        echo 'Permiso:        Leer          Escribir        Ejecutar             Tercer dígigto: Otros'
                        echo ''
                        read -p 'Introduce el valor en octal para cambiar los permisos: ' octal
                        chmod $octal $archivo
			echo ''
			ls -ld $archivo
			echo '========================================================================'
		else
			echo 'El archivo indicado no existe'
			echo '========================================================================'
		fi
	;;
	3)
		echo 'Has seleccionado la opción "Cambiar los permisos del archivo en la nomenclatura ugo y +-"'
                echo ''
                echo 'Archivos disponibles:'
                echo ''
		ls -R
                echo ''
                read -p 'Introduce el nombre del archivo en el que quieres cambiar los permisos (recuerda escribir la ruta): ' archivo
                echo ''
		echo '========================================================================'
		echo ''
                if [ -f $archivo ]
                then
                        echo 'Cambiando permisos al archivo' $archivo
                        echo ''
                        echo 'u = usuario, g = grupo de propietarios, o = otros, a = todos'
			echo ''
			echo 'r = leer, w = escribir, x = ejecutar'
			echo ''
			read -p 'Introduce el comando para cambiar los permisos: ' permiso
                        chmod $permiso $archivo
                        echo ''
                        ls -l $archivo
                        echo '========================================================================'

                elif [ -d $archivo ]
                then
                        echo 'Cambiando permisos al directorio' $archivo
                        echo ''
                        echo 'u = usuario, g = grupo de propietarios, o = otros, a = todos'
                        echo ''
                        echo 'r = leer, w = escribir, x = ejecutar'
                        echo ''
                        read -p 'Introduce el comando para cambiar los permisos: ' permiso
                        chmod $permiso $archivo
                        echo ''
                        ls -ld $archivo

                        echo '========================================================================'
                else
                        echo 'El archivo indicado no existe'
                        echo '========================================================================'
                fi
	;;
	4)
		echo 'Has seleccionado la opción "Cambiar los permisos del archivo en la nomenclatura ugo y ="'
                echo ''
                echo 'Archivos disponibles:'
                echo ''
                ls -R
                echo ''
                read -p 'Introduce el nombre del archivo en el que quieres cambiar los permisos: ' archivo
                echo ''
		echo '========================================================================'
		echo ''
                if [ -f $archivo ]
                then
                        echo 'Cambiando permisos al archivo' $archivo
                        echo ''
                        echo 'u = usuario, g = grupo de propietarios, o = otros, a = todos'
                        echo ''
                        echo 'r = leer, w = escribir, x = ejecutar'
                        echo ''
                        read -p 'Introduce a quienes quieres cambiar los permisos: ' personas
			echo ''
			read -p 'Introduce que permisos quieres que haya: ' permisos
                        chmod $personas'='$permisos $archivo
                        echo ''
                        ls -l $archivo
                        echo '========================================================================'
		elif [ -d $archivo ]
                then
                        echo 'Cambiando permisos al archivo' $archivo
                        echo ''
                        echo 'u = usuario, g = grupo de propietarios, o = otros, a = todos'
                        echo ''
                        echo 'r = leer, w = escribir, x = ejecutar'
                        echo ''
                        read -p 'Introduce a quienes quieres cambiar los permisos: ' personas
                        echo ''
                        read -p 'Introduce que permisos quieres que haya: ' permisos
                        chmod $personas'='$permisos $archivo
                        echo ''
                        ls -ld $archivo
                        echo '========================================================================'
                else
                        echo 'El archivo indicado no existe'
                        echo '========================================================================'
                fi
	;;
	5)
		echo 'Has seleccionado la opción "Cambiar grupo de propietarios de un archivo"'
                echo ''
                echo 'Archivos disponibles:'
                echo ''
                ls -R
                echo ''
                read -p 'Introduce el nombre del archivo en el que quieres cambiar los permisos: ' archivo
                echo ''
		echo '========================================================================'
		echo ''
		if [ -f $archivo ]
                then
                        echo 'Cambiando grupo de propietarios al archivo' $archivo
                        echo ''
                        echo 'Grupos de propietarios disponibles'
                        echo ''
			cat grupo
                        echo ''
                        read -p 'Introduce a quienes quieres poner como grupo de propietario: ' grupo
                        echo ''
			cd
			cd Escritorio/
                        sudo chgrp $grupo $archivo
                        echo ''
                        ls -l $archivo
                        echo '========================================================================'
                elif [ -d $archivo ]
                then
                        echo 'Cambiando grupo de propietarios al directorio' $archivo
                        echo ''
                        echo 'Grupos de propietarios disponibles'
                        echo ''
                        cat grupo
                        echo ''
                        read -p 'Introduce a quienes quieres poner como grupo de propietario: ' grupo
                        echo ''
                        cd
                        cd Escritorio/
			sudo chgrp $grupo $archivo
                        echo ''
                        ls -ld $archivo
                        echo '========================================================================'

                else
                        echo 'El archivo indicado no existe'
                        echo '========================================================================'
                fi

esac
