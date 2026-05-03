#!/bin/bash
# ─────────────────────────────────────────────────────────────────
#  instalar_dependencias.sh — Configura el entorno para AUTOPDF
# ─────────────────────────────────────────────────────────────────

set -e

VERDE='\033[0;32m'
ROJO='\033[0;31m'
AZUL='\033[0;34m'
NC='\033[0m'

echo -e "${AZUL}🚀 Iniciando la instalación de dependencias para AUTOPDF...${NC}"

# 1. Actualizar repositorios
echo -e "${AZUL}🔄 Actualizando lista de paquetes...${NC}"
sudo apt update

# 2. Instalar Pandoc y herramientas de PDF
echo -e "${AZUL}📦 Instalando Pandoc y poppler-utils...${NC}"
sudo apt install -y pandoc poppler-utils

# 3. Instalar Motores LaTeX y paquetes necesarios
echo -e "${AZUL}🎓 Instalando TexLive y paquetes necesarios...${NC}"
sudo apt install -y \
  texlive-xetex \
  texlive-fonts-recommended \
  texlive-latex-extra \
  texlive-lang-spanish \
  texlive-science \
  texlive-latex-recommended \
  texlive-luatex \
  texlive-purescript \
  ghostscript

# 4. Instalar Fuentes del Sistema
echo -e "${AZUL}🔤 Instalando fuentes (Montserrat, Cabin, Open Sans, DejaVu)...${NC}"
sudo apt install -y fonts-montserrat fonts-cabin fonts-open-sans fonts-dejavu

# 5. Configurar Fuentes (Descarga directa para asegurar compatibilidad con la plantilla)
echo -e "${AZUL}📁 Configurando fuentes para la plantilla...${NC}"

instalar_fuente() {
    local nombre=$1
    local url=$2
    local destino=$3
    if [ ! -d "$destino" ]; then
        echo -e "${AZUL}  -> Descargando $nombre...${NC}"
        sudo mkdir -p "$destino"
        curl -L "$url" -o "/tmp/$nombre.zip"
        sudo unzip -q -j "/tmp/$nombre.zip" -d "$destino"
        rm "/tmp/$nombre.zip"
    else
        echo -e "${VERDE}  -> $nombre ya instalado.${NC}"
    fi
}

# Necesitamos unzip para las fuentes
sudo apt install -y unzip curl

# Montserrat (OTF - Requerido por la plantilla)
instalar_fuente "Montserrat" "https://github.com/JulietaUla/Montserrat/releases/download/v7.222/Montserrat-7.222.zip" "/usr/share/fonts/opentype/montserrat"

# Cabin (OTF - Requerido por la plantilla)
instalar_fuente "Cabin" "https://github.com/impallari/Cabin/archive/refs/heads/master.zip" "/usr/share/fonts/opentype/cabin"

# Open Sans (TTF - Requerido por la plantilla)
instalar_fuente "OpenSans" "https://github.com/googlefonts/opensans/archive/refs/heads/main.zip" "/usr/share/fonts/truetype/open-sans"

# Actualizar caché de fuentes
echo -e "${AZUL}♻️ Actualizando caché de fuentes del sistema...${NC}"
sudo fc-cache -fv

# 6. Permisos de ejecución para los scripts
echo -e "${AZUL}🔑 Asignando permisos de ejecución...${NC}"
chmod +x extraer_contenido.sh
chmod +x generar_pdf.sh

echo -e "${VERDE}✅ ¡Todo listo! Ya puedes generar tus PDFs con: ./generar_pdf.sh archivo.md${NC}"
