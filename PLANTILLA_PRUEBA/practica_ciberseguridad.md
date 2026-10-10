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

\imagen[width=0.7\textwidth]{fotos/img1.png}
\imagen[width=0.7\textwidth]{fotos/img2.png}
\imagen[width=0.5\textwidth]{fotos/img0_instalacion.png}

Una vez hecho esto, procedemos a instalar Apache en Ubuntu 24.

## 2. Instalar Apache

¿Qué es Apache? **Apache HTTP Server** es un software de servidor web gratuito y de código abierto para plataformas Unix con el cual se ejecutan cerca del 46% de los sitios web de todo el mundo. Es mantenido y desarrollado por la Apache Software Foundation. Permite servir contenido web y es uno de los servidores más confiables desde su lanzamiento en 1995.

### Comandos a ejecutar:

```terminal
sudo apt update
sudo apt install apache2
```

\imagen[width=0.9\textwidth]{fotos/img3.png}
\imagen[width=1\textwidth]{fotos/img4.png}

## 3. Instalar iptables

**IPtables** es la herramienta estándar en Linux que proporciona seguridad al sistema a través del filtrado de tráfico, NAT y control de conexiones. Trabaja con tres bloques principales:

- **Reglas**: Instrucciones que indican qué hacer con los paquetes (Accept, Reject, Drop).
- **Cadenas**: Lista de reglas aplicadas según el sentido del tráfico (`INPUT`, `OUTPUT`, `FORWARD`).
- **Tablas**: Agrupan cadenas según su función (`filter`, `NAT`, `mangle`).

Para asegurarnos de que las reglas no se pierdan al reiniciar el sistema, instalamos el paquete `iptables-persistent`:

```terminal
sudo apt install iptables-persistent
```

\imagen[width=1\textwidth]{fotos/img5.png}
\imagen[width=1\textwidth]{fotos/img6.png}

\newpage

### Aplicación de las reglas de filtrado

```terminal
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
sudo iptables -S
```

Permitiremos el tráfico de entrada por el puerto 3306 TCP, que es el que utiliza el servidor de base de datos MySQL.

\imagen[width=1\textwidth]{fotos/img7.png}

```terminal
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -S
```

 Abriremos el puerto 80 TCP (HTTP).

\imagen[width=1\textwidth]{fotos/img8.png}

::: note
 Con **sudo iptables -S** listaremos las reglas activas y comprobaremos que las reglas se han añadido correctamente a la cadena INPUT.
:::

\imagen[width=0.85\textwidth]{fotos/img11.png}

## 4. Instalar MySQL

### 4.1. Instalar el servidor MySQL
```terminal
sudo apt upgrade
sudo apt install mysql-server
```
\imagen[width=1\textwidth]{fotos/img9.png}

### 4.2. Acceso a MySQL y definición de usuario

Accedemos a la consola de MySQL:
```terminal
sudo mysql -u root -p
```

\imagen[width=1\textwidth]{fotos/img10.png}

\newpage

Creamos un usuario y le asignamos el control de las bases de datos: 
```sql
CREATE USER 'usuario'@'10.0.1.2' IDENTIFIED BY 'contraseña';
GRANT ALL PRIVILEGES ON *.* TO 'davidmarco2'@'10.0.1.2';
```

\imagen[width=0.7\textwidth]{fotos/img11.png}

Verificamos la conexión introduciendo la contraseña:
```terminal
sudo mysql -h ip -u davidmarco2 -p
```

Comprobamos el funcionamiento ejecutando consultas de prueba:
```sql
SHOW DATABASES;
SELECT NOW();
```

\imagen[width=0.7\textwidth]{fotos/img12.png}

## 5. Trabajamos con IPtables y MySQL

### Consideraciones previas:
- **Tráfico Input**: Tráfico que entra desde cualquier máquina hacia nuestro sistema.
- **Tráfico Output**: Tráfico que sale desde nuestro sistema hacia el exterior.

::: tip
**Recordatorio de iptables:**
- `-A INPUT`: Añade la regla al final de la cadena de entrada.
- `-p tcp`: Aplica la regla al protocolo TCP.
- `--dport 3306`: Selecciona el puerto de destino 3306.
- `-j ACCEPT`: Permite el tráfico entrante.
:::

```terminal
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
sudo iptables -S
```

Permitiremos el tráfico de entrada por el puerto 3306 TCP, que es el que utiliza el servidor de base de datos MySQL.

\imagen[width=1\textwidth]{fotos/img7.png}

```terminal
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -S
```

 Abriremos el puerto 80 TCP (HTTP).

\imagen[width=1\textwidth]{fotos/img8.png}

::: note
 Con **sudo iptables -S** listaremos las reglas activas y comprobaremos que las reglas se han añadido correctamente a la cadena INPUT.
:::

\imagen[width=0.85\textwidth]{fotos/img11.png}

