#!/bin/bash
# ─────────────────────────────────────────────────────────────────
#  instalar_dependencias.sh — Instala los requisitos para el
#                             generador de PDFs (ASIR)
# ─────────────────────────────────────────────────────────────────

set -e

VERDE='\033[0;32m'
AZUL='\033[0;34m'
NC='\033[0m'

echo -e "${AZUL}⚙  Actualizando índices de paquetes...${NC}"
sudo apt update

echo -e "${AZUL}⚙  Instalando Pandoc, XeLaTeX y paquetes de TeX...${NC}"
sudo apt install -y \
  pandoc \
  texlive-xetex \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-lang-spanish \
  fonts-dejavu-core \
  fonts-open-sans \
  fonts-montserrat \
  fonts-cabin

echo -e "${AZUL}⚙  Actualizando la caché de fuentes del sistema...${NC}"
fc-cache -f -v > /dev/null 2>&1

echo -e "${VERDE}✅ Todas las dependencias han sido instaladas correctamente.${NC}"
