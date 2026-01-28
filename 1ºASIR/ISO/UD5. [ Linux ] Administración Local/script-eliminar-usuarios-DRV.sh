#!/bin/bash

verde='\e[92m'
normal='\033[0m'

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
				echo '=== ELIMINACIÓN DE USUARIOS ==='
				echo ''
				echo 'Este es el listado de USUARIOS que se eliminarán'
				sleep 1
				echo ''
				echo 'NOMBRE	   APELLIDO   CORREO                            USUARIO'
				echo '========================================================================'
				cut -d"," -f1,2,5,6 $1 | column -t -s ","
				echo '========================================================================'
				read -p 'Desea eliminar estos usuarios [S/N]: ' si_no
				echo ''
				if [ $si_no == 'S' ] || [ $si_no == 's' ]
				then
					sudo groupadd alumnos_sn 2>/dev/null
                    contador=0
					while IFS=, read -r nombre apellido dni telefono correo usuario
    					do  
					sudo userdel -r $usuario 2>/dev/null
					if [ $? -eq 0 ]
					then
						contador=$(( $contador + 1 ))
                        			echo -e 'Usuario' $usuario 'ELIMINADO correctamente' ${verde}'✓'${normal}
						echo ''
						sleep 0.2
					else
						echo 'El usuario' $usuario 'NO EXISTIA'
						echo ''
						sleep 0.2
					fi

    					done < $1
    		    	echo '=== RESUMEN DE LA ELIMINACIÓN DE USUARIOS ==='
                    	echo 'Se han eliminado' $contador 'usuarios CORRECTAMENTE.'
                    	echo $(( $lineas - $contador )) 'usuarios no estaban CREADOS'
                    	echo 'TOTAL:' $lineas
                    	echo ''
                    	read -p 'Pulsa ENTER para salir...' enter
                    	exit
                    	
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
