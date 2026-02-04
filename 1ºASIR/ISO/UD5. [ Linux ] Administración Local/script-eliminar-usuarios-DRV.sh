#!/bin/bash

verde='\e[92m'
rojo='\e[91m'
azul='\e[94m'
amarillo='\e[93m'
normal='\033[0m'

function mostrarMenu(){

	clear
	echo -e "========================================================"
	echo -e "            ${azul}🗑️  SCRIPT ELIMINACIÓN USUARIOS 🗑️${normal}"
	echo -e "========================================================"
	echo "  0) ❌ Salir"
	echo '  1) ℹ️  INFORMACIÓN'
	echo "  2) 💀 Eliminar TODOS los usuarios"
	echo '  3) 👤 Eliminar UN USUARIO en concreto'
	echo -e "========================================================"

}

function salir(){

	echo ''
	echo -n '👋 SALIENDO'
	for i in {1..3}; do
	echo -n '.'
	sleep 0.2
	done
	echo ''
	echo ''
	sleep 0.2
	exit

}

function informacion(){

	echo -e "${azul}=== ℹ️  INFORMACIÓN - $1 ===${normal}"
	echo ''
	echo 'Este apartado muestra cuantos USUARIOS del parámetro' $1 'existen.'
	echo ''
	contador=0
	while IFS=, read -r nombre apellido dni telefono correo usuario
    	do  
		cat /etc/passwd | grep $usuario >/dev/null
		if [ $? -eq 0 ]
		then
			contador=$(( $contador + 1 ))
		        echo -e "👤 Usuario ${amarillo}$usuario${normal} ESTÁ CREADO ${verde}✓${normal}"
			sleep 0.2
		fi
	done < $1
	echo ''
	echo 'Hay creados' $contador 'usuarios de los' $lineas 'del parámetro' $1
	echo ''
	read -p '⌨️  Pulsa ENTER para volver al Menú Principal'

}

function borrarTODOS(){

				clear
				echo -e "${rojo}=== 💀 ELIMINACIÓN DE TODOS LOS USUARIOS ===${normal}"
				echo ''
				echo '⚠️  Este es el listado de USUARIOS que se eliminarán:'
				sleep 1
				echo ''
				echo -e "${azul}NOMBRE          APELLIDO       CORREO                          USUARIO${normal}"
				echo '========================================================================'
				cut -d"," -f1,2,5,6 $1 | column -t -s ","
				echo '========================================================================'
				read -p '❓ ¿Desea eliminar estos usuarios [S/N]: ' si_no
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
                        			echo -e "Usuario ${amarillo}$usuario${normal} ${verde}ELIMINADO correctamente ✓${normal}"
						echo ''
						sleep 0.2
					else
						echo -e "El usuario $usuario ${rojo}NO EXISTIA${normal}"
						echo ''
						sleep 0.2
					fi

    					done < $1
    		    	echo -e "${azul}=== 📋 RESUMEN DE LA ELIMINACIÓN ===${normal}"
    		    	echo ''
                    	echo -e "✅ Se han eliminado ${verde}$contador${normal} usuarios."
                    	echo -e "❌ $(( $lineas - $contador )) usuarios no estaban CREADOS."
                    	echo "TOTAL: $lineas"
                    	echo ''
                    	read -p '⌨️  Pulsa ENTER para salir...' enter
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

}

function borrarUNO(){

	clear
	echo -e "${rojo}=== 👤 ELIMINACIÓN DE UN USUARIO ===${normal}"
	echo ''
	read -p '❓ Que USUARIO deseas ELIMINAR: ' usuario
	cat /etc/passwd | grep $usuario >/dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo ''
		read -p "⚠️  ¿Seguro que quieres borrar a ${amarillo}$usuario${normal}? [S/N]: " si_no
		if [ $si_no == 'S' ] || [ $si_no == 's' ]
		then
			sudo userdel -r $usuario 2>/dev/null
			if [ $? -eq 0 ]
			then
				echo -e "USUARIO ${amarillo}$usuario${normal} ${verde}eliminado ✓${normal}"
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			else
				echo -e "${rojo}ERROR: No se ha podido BORRAR el usuario${normal}"
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			fi
		elif [ $si_no == 'N' ] || [ $si_no == 'n' ]
		then
			echo ''
			read -p '⌨️  Pulsa ENTER para volver al Menú Principal'
			return
		fi

	else
		echo -e "${rojo}No existe el USUARIO $usuario${normal}"
		read -p '⌨️  Pulsa ENTER para salir...' enter
		exit
	fi
	
}

if [ $# -eq 1 ]
then
	if [ -f $1 ]
	then
		if [ $UID -eq 0 ]
		then
			lineas=$( wc -l $1 | cut -d' ' -f1 )
			if [ $lineas -ne 0 ]
			then
				opcion=1
				while [ $opcion -ne 0 ]
					do
					mostrarMenu		
					read -p '👉 Selecciona una opción: ' opcion
					echo ''
					case $opcion in
						0)
							salir
						;;
						1)
							informacion $1
						;;
						2)
							borrarTODOS $1
						;;
						3)
							borrarUNO $1
						;;
						*)
							cho -e "${rojo}Debes ELEGIR una OPCIÓN del 0-3${normal}"
							echo ''
							read -p '⌨️  Pulsa ENTER para volver al Menú Principal...' enter
						;;
					esac
				done
			else
				echo -e "${rojo}ERROR: El parámetro $1 no tiene usuarios.${normal}"
				exit
			fi
		else
			echo -e "${rojo}ERROR: El parámetro no ha sido ejecutado por root.${normal}"
			echo 'Debes introducir: sudo '$0 $1 
			exit
		fi
	else
		echo -e "${rojo}ERROR: El parámetro NO EXISTE${normal}"
		exit
	fi
else
	echo -e "${rojo}ERROR: El número de parámetros debe ser 1.${normal}"
	echo "Debes introducir: $0 \"parametro.csv\""
	exit
fi
