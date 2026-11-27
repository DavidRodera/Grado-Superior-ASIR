---
tipo: "PRÁCTICA"
title: "Práctica del RA3: Seguridad Perimetral"
author: "David Rodera - José Santos - 08/12/2026"
subject: "Seguridad y Alta Disponibilidad (SAD)"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Práctica RA3. Seguridad y Alta Disponibilidad. ASIR"
---

# 0. Objetivo de la práctica

El objetivo principal de esta práctica es implementar, configurar y auditar distintos mecanismos fundamentales de la seguridad perimetral y el control de accesos en entornos Linux. A través del desarrollo de tres laboratorios prácticos, buscaremos consolidar los conceptos teóricos abordados en clase mediante herramientas estándar de auditoría de contraseñas, detección de intrusiones en red y bastionado de acceso remoto.

## Partes de la práctica

| Práctica | Descripción |
| :--- | :--- |
| **1. Auditoría con John the Ripper** | Descifrado de un hash criptográfico `snefru-128` mediante ataque de diccionario con `rockyou.txt` en Ubuntu 24. |
| **2. Detección IDS con Snort** | Despliegue y configuración de Snort junto a `rsyslog` para detectar tráfico ICMP y escaneos `nmap` en una red NAT. |
| **3. Bastionado de OpenSSH y UFW** | Configuración segura del servicio SSH (puerto personalizado, restricción de usuarios/IPs y cortafuegos UFW). |

\newpage

# Práctica 1: Descifrado de contraseñas con John the Ripper

La auditoría de contraseñas permite evaluar la robustez de las credenciales almacenadas en un sistema frente a ataques de diccionario o fuerza bruta. Dado que los sistemas operativos y aplicaciones no almacenan las claves en texto plano sino mediante funciones *hash* criptográficas, utilizaremos **John the Ripper** para comprobar cómo se puede recuperar una contraseña débil a partir de su resumen criptográfico.

::: warning
Los ejercicios y conocimientos contenidos en esta práctica tienen un propósito exclusivamente formativo dentro de un entorno de laboratorio controlado, por lo que nunca deberán emplearse con fines maliciosos ni fuera de sistemas autorizados.
:::

## Parte 1: Preparación del hash e instalación

### 1.1. Instalación de John the Ripper (Versión Jumbo)

En primer lugar, actualizaremos los repositorios del sistema e instalaremos la versión **Jumbo** de John the Ripper mediante `snap`. A diferencia del paquete estándar disponible en los repositorios oficiales de `apt`, la edición Jumbo incorpora soporte para una gama mucho más amplia de algoritmos de cifrado y *hash*, entre los que se encuentra `snefru-128`.

```terminal
sudo apt update
sudo snap install john-the-ripper
```
\imagen[width=1\textwidth]{fotos/img1.png}

::: note
Usaremos `snap` de Snap Store para instalar la herramienta **john-the-ripper** en vez de `apt` debido a que esta no se encuentra en el repositorio oficial de Ubuntu.
:::

### 1.2. Preparación del hash

A continuación, guardaremos en el archivo `pwdavidjose.txt` el hash **snefru-128** interceptado:

```terminal
echo "416c46988325682c379a0998412f39ea" > pwdavidjose.txt
cat pwdavidjose.txt
```

\newpage

## Parte 2: Descarga del diccionario y ejecución del ataque

### 2.1. Obtención y descompresión del diccionario

Para realizar el ataque del diccionario, descargaremos el listado de contraseñas filtradas rockyou.txt.gz desde el repositorio indicado y lo descomprimiremos:

```terminal
curl -L https://
gunzip rockyou.txt.gz
```

\imagen[width=1\textwidth]{fotos/img3.png}
