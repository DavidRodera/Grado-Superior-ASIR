#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
user=$(whoami)

mostrarMenu(){
    clear
    echo "========================================="
    echo -e "${CYAN}    🚀 GITHUB AUTOMATOR - MI TERMINAL ${NC}"
    echo "========================================="
    echo -e " ${VERDE}1)${NC} ${AMARILLO}[CLONE]${NC}  Clonar Repositorio 📥"
    echo -e " ${VERDE}2)${NC} ${AMARILLO}[PULL]${NC}   Actualizar Repositorio 🔄"
    echo -e " ${VERDE}3)${NC} ${AMARILLO}[PUSH]${NC}   Publicar mis Cambios 📤"
    echo -e " ${VERDE}4)${NC} ${AMARILLO}[STATUS]${NC} Ver Estado Actual 🔍"
    echo -e " ${VERDE}5)${NC} ${AMARILLO}[EXIT]${NC}   Salir 🚪"
    echo "========================================="

}

function clone(){

	clear
	echo ''
	echo -e " ${CYAN}=== 📥 DESCARGAR REPOSITORIO ===${NC}"
	echo ''
	echo -e " ${VERDE}0)${NC} 📥 Volver al Menú"
	echo -e " ${VERDE}1)${NC} 📥 Clonar Repositorio ASIR"
	echo -e " ${VERDE}2)${NC} 📥 Clonar Otro Repositorio"
	echo ''
	read -p '👉 Selecciona una OPCIÓN: ' opcion
	
	case $opcion in
		0)
			echo ''
			echo -n '🔙 VOLVIENDO'
			for i in {1..3}; do
			echo -n '.'
			sleep 0.2
			done
			echo ''
			echo ''
			sleep 0.2
			return
		;;
		1)
			echo ''
			echo ' === 📥 Descargar Repositorio ASIR ==='
			url='https://github.com/DavidRodera/Grado-Superior-ASIR.git'
			repo=$(basename "$url" .git)
			echo ''
			cd "/home/$user"
			tree -d -L 1
			echo ''
			read -p "📁 Donde quieres CLONAR $repo: " carpeta
			if [ -d $carpeta ]
			then
				echo ''
				cd $carpeta
				git clone $url
				if [ $? -eq 0 ]
				then
					echo ''
					echo -e "${VERDE}REPOSITORIO $repo DESCARGADO CON ÉXITO ✓${NC}"
					echo ''
					read -p '⌨️  Pulsa ENTER para salir...' enter
					exit
				elif [ -d $repo ]
				then
					echo ''
					echo -e "${ROJO} ERROR: El REPOSITORIO YA EXISTE X${NC}"
					echo ''
					read -p '⌨️  Pulsa ENTER para salir...' enter
					exit
				else
					echo ''					
					echo -e "${ROJO} ERROR: NO se ha podido CLONAR el REPOSITORIO X${NC}"
					echo ''
					read -p '⌨️  Pulsa ENTER para salir...' enter
					exit
				fi
			else
				echo ''
				echo -e "${ROJO}ERROR: La CARPETA $carpeta NO EXISTE. X${NC}"
				echo ''
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			fi
		;;
		2)
			echo ''
			echo ' === 📥 DESCARGAR OTRO REPOSITORIO ==='
			echo ''
			read -p "👉 Introduce la URL del REPOSITORIO: " url
			repo=$(basename "$url" .git)
			echo ''
			cd "/home/$user"
			tree -d -L 1
			echo ''
			read -p "📁 Donde quieres CLONAR $repo: " carpeta
			if [ -d $carpeta ]
			then
				echo ''
				cd $carpeta
				git clone $url
				if [ $? -eq 0 ]
				then
					echo ''
					echo -e "${VERDE}REPOSITORIO $repo DESCARGADO CON ÉXITO ✓${NC}"
					echo ''
					read -p '⌨️  Pulsa ENTER para salir...' enter
					exit
				elif [ -d $repo ]
				then
					echo ''
					echo -e "${ROJO}ERROR: El REPOSITORIO YA EXISTE X${NC}"
					echo ''
					read -p '⌨️  Pulsa ENTER para salir...' enter
					exit
				else
					echo ''					
					echo -e "${ROJO}ERROR: NO se ha podido CLONAR el REPOSITORIO X${NC}"
					echo ''
					read -p '⌨️  Pulsa ENTER para salir...' enter
					exit
				fi
			else
				echo ''
				echo -e "${ROJO}ERROR: La CARPETA $carpeta NO EXISTE. X${NC}"
				echo ''
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			fi
		;;
	esac
}

function pull(){

	echo ''
	echo '=== SINCRONIZAR CAMBIOS 🔄 ==='
	url='https://github.com/DavidRodera/Grado-Superior-ASIR.git'
	proyecto=$(basename "$url" .git)
	echo ''
	cd "/home/$user"
	tree -d -L 1
	echo ''
	read -p "📁 En que CARPETA se ubica el REPOSITORIO $repo: " carpeta
	if [ -d $carpeta ]
	then
		cd $carpeta
		ls -ld "$proyecto" >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			cd $proyecto
			salida=$(git pull 2>&1)
			resultado=$?
			echo "$salida"
			if echo "$salida" | grep -q "Already up to date\|Ya está actualizado"; then
				echo ''
				echo -e "${VERDE}✅ El proyecto $proyecto YA ESTABA ACTUALIZADO${NC}"
				echo ''
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			elif [ $resultado -eq 0 ]; then
				echo ''
				echo -e "${VERDE}✅ El proyecto $proyecto ha sido ACTUALIZADO${NC}"
				echo ''
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			else
				echo ''
				echo -e "${ROJO}❌ Error al actualizar el proyecto $proyecto${NC}"
				echo ''
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			fi
		else
			echo ''
			echo -e "${ROJO}ERROR: El REPOSITORIO $proyecto NO SE ENCUENTRA EN $carpeta. X${NC}"
			echo ''
			read -p '⌨️  Pulsa ENTER para salir...' enter
			exit
		fi
	else
		echo ''
		echo -e "${ROJO}ERROR: La CARPETA $carpeta NO EXISTE. X${NC}"
		echo ''
		read -p '⌨️  Pulsa ENTER para salir...' enter
		exit
	fi

}

function push(){

	echo ''
	echo '=== PUBLICAR MIS CAMBIOS 📤 ==='
	url='https://github.com/DavidRodera/Grado-Superior-ASIR.git'
	proyecto=$(basename "$url" .git)
	echo ''
	cd "/home/$user"
	tree -d -L 1
	echo ''
	read -p "📁 En que CARPETA se ubica el REPOSITORIO $repo: " carpeta
	if [ -d $carpeta ]
	then
		cd $carpeta
		ls -ld "$proyecto" >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			cd $proyecto
			git pull >/dev/null 2>&1
			git add .
			git commit -m "⬆️ ASIR: Subida de nuevos materiales y prácticas"
			echo ''
			echo 'Usuario: DavidRodera'
			echo ''
			git push 2>/dev/null
			if [ $? -eq 0 ]
			then
				echo ''
				echo -e "${VERDE}✅ CAMBIOS PUBLICADOS con ÉXITO${NC}"
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			else
				echo ''
				echo -e "${ROJO}❌ ERROR al PUBLICAR los CAMBIOS{NC}"
				read -p '⌨️  Pulsa ENTER para salir...' enter
				exit
			fi
			
			
		else
			echo ''
			echo -e "${ROJO}ERROR: El REPOSITORIO $proyecto NO SE ENCUENTRA EN $carpeta. X${NC}"
			echo ''
			read -p '⌨️  Pulsa ENTER para salir...' enter
			exit
		fi
	else
		echo ''
		echo -e "${ROJO}ERROR: La CARPETA $carpeta NO EXISTE. X${NC}"
		echo ''
		read -p '⌨️  Pulsa ENTER para salir...' enter
		exit
	fi

}

function status(){

	echo ''
	echo '=== VER ESTADO ACTUAL 🔍 ==='
	url='https://github.com/DavidRodera/Grado-Superior-ASIR.git'
	proyecto=$(basename "$url" .git)
	echo ''
	cd "/home/$user"
	tree -d -L 1
	echo ''
	read -p "📁 En que CARPETA se ubica el REPOSITORIO $repo: " carpeta
	if [ -d $carpeta ]
	then
		cd $carpeta
		ls -ld "$proyecto" >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			echo ''
			cd $proyecto
			git status
			echo ''
			read -p '⌨️  Pulsa ENTER para volver al Menú Principal...' enter
			return

		else
			echo ''
			echo -e "${ROJO}ERROR: El REPOSITORIO $proyecto NO SE ENCUENTRA EN $carpeta. X${NC}"
			echo ''
			read -p '⌨️  Pulsa ENTER para salir...' enter
			exit
		fi
	else
		echo ''
		echo -e "${ROJO}ERROR: La CARPETA $carpeta NO EXISTE. X${NC}"
		echo ''
		read -p '⌨️  Pulsa ENTER para salir...' enter
		exit
	fi
	

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
	while [ $opcion -ne 5 ]
	do
	mostrarMenu		
	read -p '👉 Selecciona una opción [1-5]: ' opcion
	echo ''
		case $opcion in
			1)
				clone
			;;
			2)
				pull
			;;
			3)
				push
			;;
			4)
				status
			;;
			5)
				salir
			;;
			*)
				echo -e "${AMARILLO}Debes ELEGIR una OPCIÓN del 1-5${NC}"
				echo ''
				read -p '⌨️  Pulsa ENTER para volver al Menú Principal...' enter
			;;
		esac
	done
