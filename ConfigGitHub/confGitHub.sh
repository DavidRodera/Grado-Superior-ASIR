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

	read -p "🔗 Introduce el LINK del REPOSITORIO: " url 
	read -p "👤 Introduce tu NOMBRE de USUARIO de GitHub: " nombreusuario
	read -p "📧 Introduce el EMAIL de tu cuenta de GitHub: " email 
	echo ''
	repositorio=$(basename "$url" .git)
	ruta=$(find ~ -type d -name "$repositorio" -print -quit)
	cd "$ruta" 2>/dev/null
	if [ $? -eq 0 ]
	then
		if [ $(git config --global user.name | wc -l) == 1 ]; 
		then
			echo -e "${VERDE}✅ Nombre ya configurado.${NC}"
			if [ $(git config --global user.email | wc -l) == 1 ]; 
			then
				echo -e "${VERDE}✅ Email ya configurado.${NC}"
				if [ $(git config --global credential.helper) == 'store' ] || [ $(git config --global credential.helper) == 'cache' ];
				then
					echo -e "${VERDE}✅ Helper ya configurado y llaves ya guardadas.${NC}"
				else
					git config --global credential.helper store
					echo -e "${CYAN}👉 Para guardar las llaves, introduce tu usuario y Token una vez:${NC}"
					git fetch origin >/dev/null 2>&1
					if [ $? -eq 0 ]; then
						echo -e "${VERDE}✅ Helper configurado y llaves guardadas.${NC}"
						echo ''
						read -p 'Pulsa ENTER para volver al Salir...' enter
						echo ''
						exit
					else
						echo -e "${ROJO}❌ Error al validar el Token.${NC}"
						echo ''
						read -p 'Pulsa ENTER para volver al Salir...' enter
						echo ''
						exit
					fi
				fi
			else
				git config --global user.email $email
				if [ $? -eq 0 ]; 
				then
					echo -e "${VERDE}✅ Email configurado.${NC}"
					if [ $(git config --global credential.helper) == 'store' ] || [ $(git config --global credential.helper) == 'cache' ];
					then
						echo -e "${VERDE}✅ Helper ya configurado y llaves ya guardadas.${NC}"
					else
						git config --global credential.helper store
						echo -e "${CYAN}👉 Para guardar las llaves, introduce tu usuario y Token una vez:${NC}"
						git fetch origin >/dev/null 2>&1
						if [ $? -eq 0 ]
						then
							echo -e "${VERDE}✅ Helper configurado y llaves guardadas.${NC}"
							echo ''
							read -p 'Pulsa ENTER para volver al Salir...' enter
							echo ''
							exit
						else
							echo -e "${ROJO}❌ Error al validar el Token.${NC}"
							echo ''
							read -p 'Pulsa ENTER para volver al Salir...' enter
							echo ''
							exit
						fi
					fi
				else
					echo -e "${ROJO}❌ Error al configurar el email.${NC}"
					echo ''
					read -p 'Pulsa ENTER para volver al Salir...' enter
					echo ''
					exit
				fi
			fi
		else
			git config --global user.name $nombreusuario
			if [ $? -eq 0 ]; 
			then
				echo -e "${VERDE}✅ Nombre configurado.${NC}"
				if [ $(git config --global user.email | wc -l) == 1 ]; 
				then
					echo -e "${VERDE}✅ Email ya configurado.${NC}"
					if [ $(git config --global credential.helper) == 'store' ] || [ $(git config --global credential.helper) == 'cache' ];
					then
						echo -e "${VERDE}✅ Helper ya configurado y llaves ya guardadas.${NC}"
					else
						git config --global credential.helper store
						echo -e "${CYAN}👉 Para guardar las llaves, introduce tu usuario y Token una vez:${NC}"
						git fetch origin >/dev/null 2>&1
						if [ $? -eq 0 ]
						then
							echo -e "${VERDE}✅ Helper configurado y llaves guardadas.${NC}"
							echo ''
							read -p 'Pulsa ENTER para volver al Salir...' enter
							echo ''
							exit
						else
							echo -e "${ROJO}❌ Error al validar el Token.${NC}"
							echo ''
							read -p 'Pulsa ENTER para volver al Salir...' enter
							echo ''
							exit
						fi
					fi
				else
					git config --global user.email $email
					if [ $? -eq 0 ]; 
					then
						echo -e "${VERDE}✅ Email configurado.${NC}"
						if [ $(git config --global credential.helper) == 'store' ] || [ $(git config --global credential.helper) == 'cache' ];
						then
							echo -e "${VERDE}✅ Helper ya configurado y llaves ya guardadas.${NC}"
						else
							git config --global credential.helper store
							echo -e "${CYAN}👉 Para guardar las llaves, introduce tu usuario y Token una vez:${NC}"
							git fetch origin >/dev/null 2>&1
							if [ $? -eq 0 ]
							then
								echo -e "${VERDE}✅ Helper configurado y llaves guardadas.${NC}"
								echo ''
								read -p 'Pulsa ENTER para volver al Salir...' enter
								echo ''
								exit
							else
								echo -e "${ROJO}❌ Error al validar el Token.${NC}"
								echo ''
								read -p 'Pulsa ENTER para volver al Salir...' enter
								echo ''
								exit
							fi
						fi
						
					else
						echo -e "${ROJO}❌ Error al configurar el email.${NC}"
						echo ''
						read -p 'Pulsa ENTER para volver al Salir...' enter
						echo ''
						exit
					fi
				fi
			else
				echo -e "${ROJO}❌ Error al configurar el nombre.${NC}"
				echo ''
				read -p 'Pulsa ENTER para volver al Salir...' enter
				echo ''
				exit
			fi
		fi
	else
		echo -e "${ROJO}❌ No se encontró la carpeta $proyecto${NC}"
		echo ''
		read -p 'Pulsa ENTER para volver al Salir...' enter
		echo ''
	    exit
	fi

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
