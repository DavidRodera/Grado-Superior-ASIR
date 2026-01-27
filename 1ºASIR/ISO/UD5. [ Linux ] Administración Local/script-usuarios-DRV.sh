#!/bin/bash



if [ $# -eq 1 ]
then
	if [ -f $1 ]
	then
		if [ $UID -eq 0 ]
		then
			lineas=$( wc -l $1 | cut -d' ' -f1 )
			if [ $lineas -ne 0 ]
			then
				clear
				echo 'Este es el listado de USUARIOS que se crearán'
				sleep 1
				echo ''
				echo 'NOMBRE	   APELLIDO   CORREO                            USUARIO'
				echo '======================================================================================================='
				cut -d"," -f1,2,5,6 $1 | column -t -s ","
				while IFS=, read -r nombre apellido dni telefono correo usuario
    				do  
					echo $usuario
					sleep 1

    				done < $1
    				
			else
				echo 'ERROR: El parámetro' $1 'no tiene usuarios.'
				exit
			fi
		else
			echo 'ERROR: El parámetro no ha sido ejecutado por root.'
			echo 'Debes introducir: sudo '$0 $1 
			exit
		fi
	else
		echo 'ERROR: El parámetro NO EXISTE'
		exit
	fi
else
	echo 'ERROR: El número de parámetros debe ser 1.'
	echo 'Debes introducir: '$0 '"parametro.csv"'
	exit
fi
