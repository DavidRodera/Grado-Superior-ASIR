---
tipo: "GUÍA DE REFERENCIA"
title: "Guía completa de Diseño, Configuración e Interconexión de una Red"
author: "David Rodera"
subject: "Servicios en Red e Internet (SRI)"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Guía de Configuración de Red · Guía ASIR"
---

# 0. Introducción

En este proyecto vamos a recrear y desplegar paso a paso la infraestructura de red corporativa que se muestra en el esquema, integrando de forma práctica los conceptos clave abordados en las cuatro unidades de la asignatura: **Interconexión y Enrutamiento**, **Acceso y Administración Remota (SSH)**, **Servicio de Direccionamiento Dinámico (DHCP)** e **Introducción a la Resolución de Nombres (DNS)**.

\imagen[width=1\textwidth]{fotos/img1.jpeg}

El objetivo principal es simular un entorno corporativo realista compuesto por tres sedes o departamentos independientes (*Departamento de Informática*, *Departamento de Física* y *Departamento de Biología)*, interconectados mediante enrutadores Linux y aislados en subredes específicas (192.168.100.0/24, 10.0.200.0/24, 10.0.100.0/24 y la red de tránsito 10.0.1.0/24).

A lo largo de la presentación, explicaremos de forma intuitiva cómo levantar esta topología en VirtualBox utilizando máquinas virtuales como si fuesen equipos y routers reales, analizando en cada etapa qué es cada servicio o función, para qué sirve y cómo se implementa mediante comandos y archivos de configuración en Linux.

\newpage

# 1. Creación y Preparación de las MVs

## 1.1 Clonación de Máquinas Base

Para agilizar el despliegue y asegurar un entorno homogéneo, la creación de cada equipo y router del esquema se realiza mediante la clonación de una máquina base clonadora preconfigurada.

Proceso de clonación:

1. En VirtualBox, seleccionamos la máquina base, hacemos clic derecho y elegimos **Clonar**.

2. **Asignamos el nombre correspondiente** según su función en el esquema (por ejemplo: *Router1*, *Router2 Servidor DHCP*, *Cliente DHCP*, etc.).

3. Política de dirección MAC: Seleccionamos explícitamente la opción **"Generar nuevas direcciones MAC para todos los adaptadores de red"**.

::: note
**¿Por qué elegimos generar nuevas direcciones MAC?**

Si mantuviéramos las direcciones MAC originales, todas las máquinas clonadas tendrían el mismo identificador físico de red. Esto provocaría conflictos severos a nivel de Enlace de Datos (Capa 2), ya que los switches virtuales no sabrían a qué máquina entregar las tramas, y el servicio DHCP no podría identificar ni asignar direcciones IP de forma única a cada equipo.
:::

Captura 2
