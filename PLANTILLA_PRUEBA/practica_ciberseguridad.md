---
tipo: "PRÁCTICA"
title: "Práctica del RA1: Seguridad y Alta Disponibilidad"
author: "David Rodera - Marco Gallego"
subject: "Seguridad y Alta Disponibilidad (SAD)"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Práctica RA1 · Seguridad y Alta Disponibilidad · ASIR"
---

# 0. Objetivo de la práctica

Vamos a desplegar un entorno de servidor web completo, donde aplicar configuraciones de seguridad de red fundamentales y utilizar herramientas de auditoría y monitorización para demostrar la necesidad de securizar las comunicaciones.

## Partes de la práctica

### 1ª Parte: Infraestructura de servicios mínima
Entorno de red aislado y virtualizado.

| Componente | Descripción |
| :--- | :--- |
| **Doble Máquina Virtual** | Configurar un entorno cliente-servidor para simular un segmento de red controlado y aislado. |
| **Pila LAMP (Apache, MySQL, PHP)** | Instalar y levantar servicios web y de base de datos que son el núcleo de cualquier aplicación en un entorno real. |
| **MySQL con Acceso Remoto** | Configurar el servicio de base de datos para que sea accesible desde otra máquina de la red. |

### 2ª Parte: Seguridad activa y monitorización de red

| Herramienta / Componente | Descripción |
| :--- | :--- |
| **Iptables (Firewall)** | Aplicar reglas de filtrado de paquetes para abrir puertos específicos (80 para HTTP, 3306 para MySQL). |
| **Nmap** | Utilizar una herramienta de escaneo de puertos y descubrimiento de servicios para identificar la topología de la red y los servicios abiertos en el servidor (puertos 80 y 3306, versión del SO). |
| **Wireshark** | Capturar y examinar el tráfico de red. Permite la demostración visual y práctica de la vulnerabilidad de HTTP al realizar un login donde la contraseña es visible en texto plano. |
| **Ejercicio Adicional** | Proponer y aplicar una solución de securización para que la contraseña no sea visible en Wireshark (migración o cifrado lado cliente). |

\newpage

# Práctica final: Primera parte

::: note
**Nota inicial:** La práctica hace referencia a Ubuntu 20 y Ubuntu 24. Donde se mencione Ubuntu 20, reutilizaremos la máquina virtual de prácticas anteriores, y para Ubuntu 24 podemos instalar Ubuntu 22 o 24 según vuestra preferencia.
:::

## 1. Instalar Ubuntu 24

Primero descargamos la máquina Ubuntu 24 desde [releases.ubuntu.com/noble](https://releases.ubuntu.com/noble/).
Una vez descargada la ISO, creamos la máquina virtual en VirtualBox y configuramos un usuario y contraseña.

\imagen[width=0.85\textwidth]{fotos/img1.png}
\imagen[width=0.85\textwidth]{fotos/img2.png}
\imagen[width=0.5\textwidth]{fotos/img0_instalacion.png}

Una vez hecho esto, procedemos a instalar Apache en Ubuntu 24.


