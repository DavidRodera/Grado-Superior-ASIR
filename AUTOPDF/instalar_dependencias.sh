#!/bin/bash
# ─────────────────────────────────────────────────────────────────
#  instalar_dependencias.sh — Instala los requisitos para el
#                             generador de PDFs (ASIR)
#                             Compatible con Ubuntu 20.04, 22.04, 24.04+
# ─────────────────────────────────────────────────────────────────

set -e

VERDE='\033[0;32m'
AZUL='\033[0;34m'
AMARILLO='\033[1;33m'
ROJO='\033[0;31m'
NC='\033[0m'

echo -e "${AZUL}⚙  Detectando sistema operativo y arquitectura...${NC}"
ARCH=$(dpkg --print-architecture)
UBUNTU_VER=$(lsb_release -rs 2>/dev/null || echo "desconocida")
echo -e "   Sistema: Ubuntu ${UBUNTU_VER} (${ARCH})"

echo -e "${AZUL}⚙  Actualizando índices de paquetes...${NC}"
sudo apt-get update -qq

echo -e "${AZUL}⚙  Instalando utilidades base, XeLaTeX y paquetes de TeX...${NC}"
sudo apt-get install -y \
  wget \
  unzip \
  ca-certificates \
  fontconfig \
  texlive-xetex \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-lang-spanish \
  fonts-dejavu-core \
  fonts-open-sans \
  fonts-cabin

# 1. Gestión de la fuente Montserrat (apt en Ubuntu 22.04+ o descarga directa en 20.04)
if apt-cache show fonts-montserrat >/dev/null 2>&1; then
  echo -e "${AZUL}⚙  Instalando fuente Montserrat desde repositorios oficiales...${NC}"
  sudo apt-get install -y fonts-montserrat
else
  echo -e "${AMARILLO}⚠  Paquete fonts-montserrat no disponible en Ubuntu ${UBUNTU_VER}. Descargando manualmente...${NC}"
  TMP_FONT_DIR=$(mktemp -d)
  wget -qO "${TMP_FONT_DIR}/montserrat.zip" "https://github.com/JulietaUla/Montserrat/archive/refs/heads/master.zip"
  unzip -q "${TMP_FONT_DIR}/montserrat.zip" -d "${TMP_FONT_DIR}"
  sudo mkdir -p /usr/local/share/fonts/montserrat
  sudo cp "${TMP_FONT_DIR}"/Montserrat-master/fonts/ttf/*.ttf /usr/local/share/fonts/montserrat/
  rm -rf "${TMP_FONT_DIR}"
fi

# 2. Gestión de Pandoc (instala v3.1.11.1 oficial si la del sistema es < 3.0 o no existe)
PANDOC_TARGET="3.1.11.1"
INSTALAR_PANDOC_DEB=true

if command -v pandoc >/dev/null 2>&1; then
  CURRENT_PANDOC=$(pandoc --version | head -n1 | awk '{print $2}')
  MAJOR_VER=$(echo "$CURRENT_PANDOC" | cut -d. -f1)
  if [ "$MAJOR_VER" -ge 3 ] 2>/dev/null; then
    echo -e "${VERDE}✔  Pandoc ${CURRENT_PANDOC} ya instalado y compatible.${NC}"
    INSTALAR_PANDOC_DEB=false
  else
    echo -e "${AMARILLO}⚠  Pandoc ${CURRENT_PANDOC} detectado (antiguo). Actualizando a ${PANDOC_TARGET}...${NC}"
  fi
else
  echo -e "${AZUL}⚙  Instalando Pandoc ${PANDOC_TARGET}...${NC}"
fi

if [ "$INSTALAR_PANDOC_DEB" = true ]; then
  if [ "$ARCH" = "amd64" ] || [ "$ARCH" = "arm64" ]; then
    TMP_PANDOC=$(mktemp --suffix=.deb)
    wget -qO "${TMP_PANDOC}" "https://github.com/jgm/pandoc/releases/download/${PANDOC_TARGET}/pandoc-${PANDOC_TARGET}-1-${ARCH}.deb"
    sudo dpkg -i "${TMP_PANDOC}"
    rm -f "${TMP_PANDOC}"
  else
    echo -e "${AMARILLO}⚠  Arquitectura ${ARCH} sin paquete .deb oficial; instalando desde apt...${NC}"
    sudo apt-get install -y pandoc
  fi
fi

echo -e "${AZUL}⚙  Actualizando la caché de fuentes del sistema...${NC}"
fc-cache -f -v > /dev/null 2>&1

echo -e "${VERDE}✅ Todas las dependencias han sido instaladas correctamente.${NC}"
echo -e "   • Pandoc: $(pandoc --version | head -n1)"
echo -e "   • XeLaTeX: $(xelatex --version | head -n1)"
