#!/bin/bash

function mostrarMenu(){

	clear
	echo "=================================================================="
	echo "                        GESTIÓN APPS LINUX"
	echo "=================================================================="
	echo "0) Salir"
	echo "1) Gestionar repositorios (apt)"
	echo '2) Instalar archivos .deb (dpkg)'
	echo '3) Gestionar aplicaciones desde la interfaz gráfica (synaptic)'
	echo '4) OP'
	echo "=================================================================="
}

function apt(){

	echo -n 'ENTRANDO'
	for i in {1..3}; do
    	echo -n '.'
    	sleep 0.5
	done
	sleep 0.2
	clear
	echo '===================================='
	echo '    GESTIONAR REPOSITORIOS - apt'
	echo '===================================='
	echo '0) Regresar al Menú Principal'
	echo '1) Realizar update'
	echo '2) Instalar aplicación'
	echo '3) Desinstalar aplicación'
	echo '===================================='
	read -p 'Selecciona una opción: ' opcion_apt
	
function installapt(){

			echo ''
			echo '=== INSTALAR APLICACIÓN ==='
			echo ''
			read -p 'Introduce el nombre de la aplicación que deseas instalar: ' app_ins
			echo ''
			if sudo apt show $app_ins 2>/dev/null | grep -q 'Package:'; 
			then
				echo 'La aplicación '$app_ins' está disponible'
				sudo apt show "$app_ins" | sed -n '1p;2p;4p;5p'
				echo ''
				read -p 'Deseas instalar esa aplicación? [S/N] ' si_no
				if [ $si_no == 'S' ] || [ $si_no == 's' ]
				then
						echo ''
						sudo apt install $app_ins
						echo ''
						echo 'Aplicación instalada'
						echo ''fdrv
						sudo apt list --installed | grep -w $app_ins
						echo ''
						read -p 'Pulsa ENTER para volver al Menú Principal...' enter
				elif [ $si_no == 'N' ] || [ $si_no == 'n' ]
				then
					echo ''
					read -p 'Pulsa ENTER para volver al Menú Principal...' enter
					return
					return
				else
					echo ''
					echo 'No se que es '$si_no'debias elegir entre [S/N]'
					echo ''
					read -p 'Pulsa ENTER para volver al Menú Principal...' enter
					return
				fi
			else
				echo 'La aplicación '$app_ins' no está disponible'
				echo ''
				read -p 'Pulsa ENTER para volver al Menú Principal...' enter
				return
			fi

}

function uninstallapt(){

			echo ''
			echo '=== DESINSTALAR APLICACIÓN ==='
			echo ''
			read -p 'Introduce el nombre de la aplicación que deseas desinstalar: ' app_unins
			echo ''
			if sudo apt list --installed 2>/dev/null | grep -w "$app_unins"
			then
				echo ''
				echo 'La aplicación '$app_unins' está disponible para desinstalarse'
				echo ''
				read -p 'Deseas desinstalar esa aplicación? [S/N] ' si_no
				if [ $si_no == 'S' ] || [ $si_no == 's' ]
				then
						echo ''
						sudo apt purge $app_unins
						sudo apt autoremove $app_unins
						echo ''
						echo 'Aplicación desinstalada'
						echo ''
						sudo apt list --installed | grep -w $app_unins
						echo ''
						read -p 'Pulsa ENTER para volver al Menú Principal...' enter
				elif [ $si_no == 'N' ] || [ $si_no == 'n' ]
				then
					echo ''
					read -p 'Pulsa ENTER para volver al Menú Principal...' enter
					return
					return
				else
					echo ''
					echo 'No se que es '$si_no'debias elegir entre [S/N]'
					echo ''
					read -p 'Pulsa ENTER para volver al Menú Principal...' enter
					return
				fi
			else
				echo ''
				echo 'La aplicación '$app_ins' no está disponible para desinstalarse'
				echo ''
				read -p 'Pulsa ENTER para volver al Menú Principal...' enter
				return
			fi

}
	
	case $opcion_apt in
		0)
			echo ''
			echo -n 'VOLVIENDO al MENÚ PRINCIPAL'
			for i in {1..3}; do
		    	echo -n '.'
		    	sleep 0.5
			done
			sleep 0.2
			return
		;;
		1)
			echo ''
			echo '=== REALIZAR UPDATE ==='
			echo ''
			sudo apt update
			echo ''
			echo 'UPDATE realizado'
			sleep 0.7
			read -p 'Pulsa ENTER para volver al Menú Principal...' enter
			return
			return
		;;
		2)
			installapt
		;;
		3)
			uninstallapt
		;;
			
	esac

}

function dpkg(){

	echo '=== INSTALAR ARCHIVOS .deb - dpkg ==='
	echo ''
	read -p 'Introduce la ruta de la carpeta donde se encuentran los archivos (Ejemplo: /home/tu_usuario/...): ' ruta
	cd && cd $ruta
	echo ''
	echo 'Archivos .deb DISPONIBLES:'
	ls -1 *.deb
	read -p 'Cuál archivo .deb deseas INSTALAR?: ' arch_deb
	if [ -e $arch_deb ];
	then
		

}

opcion=1
while [ $opcion -ne 0 ]
	do
	mostrarMenu		
	read -p 'Selecciona una opción: ' opcion
	echo ''
	case $opcion in
		1)
			apt
		;;
		2)
			dpkg
	esac
done


