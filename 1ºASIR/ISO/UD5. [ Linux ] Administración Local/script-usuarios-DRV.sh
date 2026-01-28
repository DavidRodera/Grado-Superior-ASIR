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
				echo '========================================================================'
				cut -d"," -f1,2,5,6 $1 | column -t -s ","
				echo '========================================================================'
				read -p 'Desea crear estos usuarios [S/N]: ' si_no
				echo ''
				if [ $si_no == 'S' ] || [ $si_no == 's' ]
				then
					sudo groupadd alumnos_sn 2>/dev/null
					while IFS=, read -r nombre apellido dni telefono correo usuario
    					do  
					sudo useradd $usuario -c "Usuario temporal Academia Sierra Nevada - [$nombre $apellido]" -d /home/aula3/$usuario -m -s /bin/bash -g alumnos_sn -e 2026-01-29 -f 0 2>/dev/null
					if [ $? -eq 0 ]
					then
						echo 'Usuario' $usuario 'CREADO correctamente ✓' 
						echo ''
						sleep 0.5
					else
						echo 'El usuario' $usuario 'YA EXISTIA'
						echo ''
						sleep 0.5
					fi

    					done < $1
				else
					echo -n 'SALIENDO'
					for i in {1..3}; do
				    	echo -n '.'
				    	sleep 0.5
					done
					sleep 0.2
					exit

				fi
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
