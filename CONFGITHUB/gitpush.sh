#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
NC='\033[0m'

url=""
repositorio=$(basename "$url" .git)
ruta=$(find /home/$(whoami) -type d -name "$repositorio" -print -quit)
cd $ruta
if [ $? -eq 0 ]
then
	git push
	echo ''
	git add .
	git commit -m '⬆️ ASIR: Subida de nuevos materiales y prácticas'
	git push
	if [ $? -eq 0 ]
	then
		echo ''
		echo -e "${VERDE}✅ Cambios publicados correctamente.${NC}"
	else
		echo ''
		echo -e "${ROJO}❌ Error al publicar los cambios del Repositorio.${NC}"
	fi
else
	exit
fi
