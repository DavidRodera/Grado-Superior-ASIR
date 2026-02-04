#!/bin/bash
clear

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

function mostrarMenu(){

	clear
	echo "================================================="
	echo "     SCRIPT REGISTRO DE ACTIVIDAD DE USUARIOS"
	echo "================================================="
	echo -e " ${ROJO}0)${NC}  ${BLANCO}Salir${NC}"
	echo -e " ${VERDE}1)${NC} 📜 Información de ${CYAN}INICIOS de SESIÓN${NC}"
	echo -e " ${VERDE}2)${NC} 👥 Mostrar ${CYAN}USUARIOS CONECTADOS${NC} Actualmente"
	echo -e " ${VERDE}3)${NC} 🔍 Información ${CYAN}Detallada sobre USUARIOS${NC}"
	echo "================================================="

}

function infoIS(){

	echo ''
	echo -e "=== 📜 Información de ${CYAN}INICIOS de SESIÓN${NC} ==="
	echo ''
	echo -e " ${VERDE}0)${NC} Ver ÚLTIMOS INICIOS de SESIÓN de UN USUARIO"
	echo -e " ${VERDE}1)${NC} Ver ÚLTIMOS INICIOS de SESIÓN del SISTEMA"
	echo ''
	read -p 'Selecciona una opción [0-1]: ' opcion
	
	case $opcion in
		0)
			echo ''
			echo '=== Ver ÚLTIMOS INICIOS de SESIÓN de UN USUARIO ==='
			echo ''
			read -p '¿Qué USUARIO deseas Ver?: ' usuario
			if cat /etc/passwd | grep $usuario >/dev/null 2>&1;
			then
				echo ''
				last $usuario
				echo ''
				read -p 'Pulsa ENTER para Salir...' enter
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
							
			else
				echo ''
				echo -e "ERROR: El USUARIO NO EXISTE"
				echo ''
				read -p 'Pulsa ENTER para Salir...' enter
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
			fi
		;;
		1)
			echo ''
			echo '=== Ver ÚLTIMOS INICIOS de SESIÓN del SISTEMA ==='
			echo ''
			last
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
			echo -n '👋 SALIENDO'
			echo ''
			for i in {1..3}; do
			echo -n '.'
			sleep 0.2
			done
			echo ''
			echo ''
			sleep 0.2
			exit
		;;
	esac
}

function usuCON(){

	echo ''
	echo -e "👥 Mostrar ${CYAN}USUARIOS CONECTADOS${NC} Actualmente"
	echo ''
	who 2>/dev/null
	if [ -z $? ]
	then
		usuario=$(whoami)
		echo 'Solo está CONECTADO el usuario' $usuario
		echo ''
		read -p '¿Deseas más INFORMACIÓN? [S/N]: ' si_no
		if [ $si_no == 'S' ] || [ $si_no == 's' ]
		then
			echo ''
			w
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
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
		elif [ $si_no == 'N' ] || [ $si_no == 'n' ]
		then
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
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
		else
			echo 'No se que es '$si_no'debias elegir entre [S/N]'
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
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

		fi
		echo ''
		read -p 'Pulsa ENTER para Salir...' enter
		echo -n '👋 SALIENDO'
		echo ''
		for i in {1..3}; do
		echo -n '.'
		sleep 0.2
		done
		echo ''
		echo ''
		sleep 0.2
		exit
	else
		who
		echo ''
		read -p '¿Deseas más INFORMACIÓN? [S/N]: ' si_no
		if [ $si_no == 'S' ] || [ $si_no == 's' ]
		then
			echo ''
			w
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
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
		elif [ $si_no == 'N' ] || [ $si_no == 'n' ]
		then
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
			echo -n '👋 SALIENDO'
			echo ''
			for i in {1..3}; do
			echo -n '.'
			sleep 0.2
			done
			echo ''
			echo ''
			sleep 0.2
			exit
		else
			echo 'No se que es '$si_no'debias elegir entre [S/N]'
			echo ''
			read -p 'Pulsa ENTER para Salir...' enter
			echo ''
			echo -n '👋 SALIENDO'
			echo ''
			for i in {1..3}; do
			echo -n '.'
			sleep 0.2
			done
			echo ''
			echo ''
			sleep 0.2
			exit

		fi
		read -p 'Pulsa ENTER para Salir...' enter
		echo -n '👋 SALIENDO'
		echo ''
		for i in {1..3}; do
		echo -n '.'
		sleep 0.2
		done
		echo ''
		echo ''
		sleep 0.2
		exit
	fi
		
	

}

function infoUSU(){

	echo ''
	echo -e "🔍 Información ${CYAN}Detallada sobre USUARIOS${NC}"
	echo ''
	read -p '¿Qué USUARIO deseas VER?: ' usuario
	id $usuario
	echo ''
	read -p 'Pulsa ENTER para Salir...' enter
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

function salir(){

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

opcion=1
while [ $opcion -ne 0 ]
do
mostrarMenu		
read -p 'Selecciona una opción [0-3]: ' opcion
echo ''
	case $opcion in
		0)
			salir
		;;
		1)
			infoIS
		;;
		2)
			usuCON
		;;
		3)
			infoUSU
		;;
		*)
			echo 'Debes ELEGIR una OPCIÓN del 0-3'
			echo ''
			read -p 'Pulsa ENTER para volver al Menú Principal...' enter
		;;
	esac
done

