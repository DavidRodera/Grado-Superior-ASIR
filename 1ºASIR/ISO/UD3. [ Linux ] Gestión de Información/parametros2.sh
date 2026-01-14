#!/bin/bash
clear
parametros=$*
	read -p 'Desea cambiar los propietarios a '$arch': [S/N] ' si_no
	if [ $si_no == 'S' ] || [ $si_no == 's' ]
	then
		read -p 'Indica los nuevos propietarios : ' own
		sudo chown $own':'$own $arch 2>/dev/null
		if [ $? -eq 0 ]
		then
			echo 'Cambiando propietarios.....'
			ls -l $arch	
		else
			echo 'ERROR; algo ha fallado'
		fi
	elif [ $si_no == 'N' ] || [ $si_no == 'n' ]
	then
		echo ''
	else
		echo 'No se que es '$si_no'debias elegir entre [S/N]'

	fi
