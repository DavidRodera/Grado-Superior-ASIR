#!/bin/bash
set -e

VERDE='\033[0;32m'
AZUL='\033[0;34m'
AMARILLO='\033[1;33m'
NC='\033[0m'

ARCH=$(dpkg --print-architecture)
UBUNTU_VER=$(lsb_release -rs 2>/dev/null || echo "desconocida")

echo -e "${AZUL}⚙  Actualizando índices de paquetes...${NC}"
sudo apt-get update -qq

echo -e "${AZUL}⚙  Instalando XeLaTeX mínimo y fuentes necesarias (sin extras pesados)...${NC}"
sudo apt-get install -y --no-install-recommends \
  wget \
  unzip \
  ca-certificates \
  fontconfig \
  texlive-xetex \
  texlive-latex-recommended \
  texlive-lang-spanish \
  fonts-dejavu-core \
  fonts-open-sans \
  fonts-cabin

# Montserrat (apt en Ubuntu 22.04+ o descarga directa en 20.04)
if apt-cache show fonts-montserrat >/dev/null 2>&1; then
  sudo apt-get install -y --no-install-recommends fonts-montserrat
else
  TMP_FONT_DIR=$(mktemp -d)
  wget -qO "${TMP_FONT_DIR}/montserrat.zip" "https://github.com/JulietaUla/Montserrat/archive/refs/heads/master.zip"
  unzip -q "${TMP_FONT_DIR}/montserrat.zip" -d "${TMP_FONT_DIR}"
  sudo mkdir -p /usr/local/share/fonts/montserrat
  sudo cp "${TMP_FONT_DIR}"/Montserrat-master/fonts/ttf/*.ttf /usr/local/share/fonts/montserrat/
  rm -rf "${TMP_FONT_DIR}"
fi

# Pandoc 3.1.11.1 oficial (solo si no tienes ya v3+)
PANDOC_TARGET="3.1.11.1"
INSTALAR_PANDOC_DEB=true

if command -v pandoc >/dev/null 2>&1; then
  MAJOR_VER=$(pandoc --version | head -n1 | awk '{print $2}' | cut -d. -f1)
  if [ "$MAJOR_VER" -ge 3 ] 2>/dev/null; then
    INSTALAR_PANDOC_DEB=false
  fi
fi

if [ "$INSTALAR_PANDOC_DEB" = true ]; then
  TMP_PANDOC=$(mktemp --suffix=.deb)
  wget -qO "${TMP_PANDOC}" "https://github.com/jgm/pandoc/releases/download/${PANDOC_TARGET}/pandoc-${PANDOC_TARGET}-1-${ARCH}.deb"
  sudo dpkg -i "${TMP_PANDOC}"
  rm -f "${TMP_PANDOC}"
fi

sudo apt-get clean
fc-cache -f > /dev/null 2>&1

echo -e "${VERDE}✅ Instalación ligera completada.${NC}"
