---
tipo: "PRÁCTICA"
title: "Práctica del RA2: Criptografía y Certificados Digitales"
author: "Parte 2: Cifrado de la información · David Rodera - Marco Gallego"
subject: "Seguridad y Alta Disponibilidad (SAD) - 18/11/2026"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Práctica RA2 · Seguridad y Alta Disponibilidad · ASIR"
---

# 0. Objetivo de la práctica

El objetivo principal de esta práctica es implementar y analizar diversos métodos fundamentales de la criptografía mediante una serie de ejercicios prácticos. A través de su desarrollo, se busca aplicar y consolidar los conceptos teóricos abordados en clase, comprendiendo el funcionamiento interno y la utilidad de cada algoritmo o técnica criptográfica.

## Partes de la práctica

| Práctica | Descripción |
| :---: | :---: |
| 1. Hash SHA-256 | Creación y verificación de integridad de archivos mediante el algoritmo SHA-256 con `sha256sum`. |
| 2. Cifrado simétrico AES | Cifrado y descifrado de mensajes mediante el algoritmo AES-256-CBC con `openssl`. |
| 3. Cifrado asimétrico RSA | Generación de par de claves RSA y cifrado/descifrado de información mediante `openssl`. |
| 4. CA y certificados SSL/TLS | Despliegue de una Autoridad Certificadora (CA) y un servidor web HTTPS en Linux con validación de handshake SSL/TLS. |

\newpage

# Práctica 1: Creación y Verificación de un Hash con SHA-256
