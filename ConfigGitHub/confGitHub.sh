#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

function mostrarMenu(){

	clear
	echo -e "${CYAN}==================================================${NC}"
	echo -e "${AZUL}             🚀 CONFIGURADOR GITHUB"
	echo -e "${CYAN}==================================================${NC}"
	echo -e " ${ROJO}0)${NC} ${AMARILLO}SALIR${NC} 🚪" 
	echo -e " ${ROJO}1)${NC} ${VERDE}CLONAR REPOSITORIO${NC} 📥"
	echo -e " ${ROJO}2)${NC} ${VERDE}INSTAURAR CONFIGURACIÓN (Credenciales/ID)${NC} ⚙️"
	echo -e "${CYAN}==================================================${NC}"
	
}

function salir(){

	echo -n "👋 SALIENDO"
	for i in {1..3}; do
    	echo -n '.'
    	sleep 0.2
	done
	sleep 0.2
	echo ''
	echo ''
	exit

}

function config(){
    echo -e "${AZUL}--- Verificando configuración de GitHub ---${NC}"

    # 1. Obtener datos actuales
    actual_nombre=$(git config --global user.name)
    actual_email=$(git config --global user.email)
    actual_helper=$(git config --global credential.helper)

    # 2. Validar Nombre
    if [ -n "$actual_nombre" ]; then
        echo -e "${VERDE}✅ Nombre configurado: $actual_nombre${NC}"
    else
        read -p "👤 Introduce tu NOMBRE de USUARIO de GitHub: " nuevo_nombre
        git config --global user.name "$nuevo_nombre"
    fi

    # 3. Validar Email
    if [ -n "$actual_email" ]; then
        echo -e "${VERDE}✅ Email configurado: $actual_email${NC}"
    else
        read -p "📧 Introduce tu EMAIL de GitHub: " nuevo_email
        git config --global user.email "$nuevo_email"
    fi

    # 4. Validar Credenciales y Forzar Guardado
    if [[ "$actual_helper" == "store" || "$actual_helper" == "cache" ]]; then
        echo -e "${VERDE}✅ El gestor de credenciales ya está activo ($actual_helper).${NC}"
    else
        echo -e "${AMARILLO}⚠️ Las credenciales no se están guardando.${NC}"
        echo -e "${CYAN}🔧 Activando 'store' y solicitando validación...${NC}"
        
        # Configurar el helper
        git config --global credential.helper store
        
        # Intentar localizar el repositorio para hacer el fetch
        read -p "🔗 Introduce el LINK del REPOSITORIO para validar el Token: " url
        repositorio=$(basename "$url" .git)
        ruta=$(find ~ -maxdepth 3 -type d -name "$repositorio" -print -quit)

        if [ -d "$ruta" ]; then
            cd "$ruta"
            echo -e "${AZUL}👉 Introduce tu usuario y TOKEN a continuación para guardarlos:${NC}"
            git add .
            git commit -m "Instaurando Credenciales en $(hostname)."
            if git push; then
                echo -e "${VERDE}✅ Token validado y guardado correctamente.${NC}"
            else
                echo -e "${ROJO}❌ Error al validar el Token. Revisa si es correcto.${NC}"
            fi
        else
            echo -e "${ROJO}❌ No se encontró la carpeta local de $repositorio.${NC}"
        fi
    fi

    echo ''
    read -p 'Presiona ENTER para volver al menú...' enter
}

function clonar(){

	cd
	read -p "🔗 Introduce el LINK del REPOSITORIO: " url 
	repositorio=$(basename "$url" .git)
	echo ''
	if sudo dpkg -s tree >/dev/null 2>&1;
	then
		tree -d -L 1
		echo ''
		read -p '📂 Indica en que carpeta quieres CLONAR el REPOSITORIO: ' carpeta
		cd $carpeta 2>/dev/null
		if [ $? -eq 0 ]
		then
			echo ''
			git clone $url
			if [ $? -eq 0 ]
			then
				echo ''
				echo -e "${VERDE}✅ REPOSITORIO $repositorio CLONADO con ÉXITO.${NC}"
				echo ''
				read -p '⚙️ DESEAS INSTAURAR la COFIGURACIÓN (Credenciales/ID)? [S/N]: ' si_no
				case $si_no in
				S)
					echo ''
					config
				;;
				s)
					echo ''
					config
				;;
				*)
					echo ''
					exit
				esac
			else
				echo ''
				echo -e "${ROJO}❌ ERROR: NO se ha CLONADO el REPOSITORIO $repositorio.${NC}"
				echo ''
				exit
			fi
		else
			echo ''
			echo -e "${ROJO}❌ ERROR: NO se ha ACCEDIDO al la CARPETA $carpeta.${NC}"
			echo ''
			exit
		fi
	else
		sudo apt install -y tree >/dev/null 2>&1
		tree -d -L 1
		echo ''
		read -p '📂 Indica en que carpeta quieres CLONAR el REPOSITORIO: ' carpeta
		cd $carpeta 2>/dev/null
		if [ $? -eq 0 ]
		then
			echo ''
			git clone $url
			if [ $? -eq 0 ]
			then
				echo ''
				echo -e "${VERDE}✅ REPOSITORIO $repositorio CLONADO con ÉXITO.${NC}"
				echo ''
				read -p '⚙️ DESEAS INSTAURAR la COFIGURACIÓN (Credenciales/ID)? [S/N]: ' si_no
				case $si_no in
				S)
					echo ''
					config
				;;
				s)
					echo ''
					config
				;;
				*)
					echo ''
					exit
				esac
			else
				echo ''
				echo -e "${ROJO}❌ ERROR: NO se ha CLONADO el REPOSITORIO $repositorio.${NC}"
				echo ''
				exit
			fi
		else
			echo ''
			echo -e "${ROJO}❌ ERROR: NO se ha ACCEDIDO al la CARPETA $carpeta.${NC}"
			echo ''
			exit
		fi
	fi
			
}

opcion=1
while [ $opcion -ne 0 ]
do
	mostrarMenu		
	read -p "👉 Selecciona una opción [0-2]: " opcion
	echo ''
	case $opcion in
		0)
			salir
		;;
		1)
			clonar
		;;
		2)
			config
		;;
		*)
			echo 'Debes ELEGIR una OPCIÓN del 0-2'
			echo ''
			read -p 'Pulsa ENTER para volver al Menú Principal...' enter
		;;
	esac
done
