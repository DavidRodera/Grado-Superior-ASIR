#!/bin/bash

url="https://github.com/DavidRodera/Grado-Superior-ASIR.git"
repositorio=$(basename "$url" .git)
ruta=$(find /home/$(whoami) -type d -name "$repositorio" -print -quit)
cd $ruta
if [ $? -eq 0 ]
then
	git pull
	if [ $? -eq 0 ]
	then
		echo ''
		echo 'Repositorio actualizado correctamente'
	else
		echo ''
		echo 'ERROR al actualizar el repositorio'
	fi
else
	exit
fi
