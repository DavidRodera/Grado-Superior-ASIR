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

\imagen[width=1\textwidth]{fotos/img3.png}

\newpage

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

### Aplicación de las reglas de filtrado:

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

::: tip
 Con **sudo iptables -S** listaremos las reglas activas y comprobaremos que las reglas se han añadido correctamente a la cadena INPUT.
:::

## 4. Instalar MySQL

### 4.1. Instalar el servidor MySQL
```terminal
sudo apt upgrade
sudo apt install mysql-server
```
\imagen[width=1\textwidth]{fotos/img9.png}

### 4.2. Acceso a MySQL

Accedemos a la consola de MySQL:
```terminal
sudo mysql -u root -p
```

\imagen[width=1\textwidth]{fotos/img10.png}

\newpage

## 5. Trabajamos con IPtables y MySQL

### 5.1. Configuración de IPtables

Permitimos el tráfico de entrada de MySQL:

```terminal
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
sudo iptables -S
```

### 5.2. Configuración de ficheros

Para poder conectarnos desde otro destino debemos reescribir el archivo *mysqld.cnf*.

```terminal
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```
Haremos que la linea "bind-address" se vuelva un comentario y así se pueda acceder desde cualquier destino.

```nano
#bind-address           = 127.0.0.1
```
Para que se apliquen los cambios, reiniciaremos el servidor MySQL.

```terminal
sudo /etc/init.d/mysql restart
```

\newpage

### 5.3. Verificación

Ingresaremos a MySQL, creamos un usuario y le asignamos el control de las bases de datos: 
```sql
CREATE USER 'usuario'@'ip' IDENTIFIED BY 'contraseña';
GRANT ALL PRIVILEGES ON *.* TO 'davidmarco2'@'ip';
```

\imagen[width=0.8\textwidth]{fotos/img11.png}

Y finalmente, verificamos la conexión desde Ubuntu 20 introduciendo la contraseña:

```terminal
sudo mysql -h ip -u usuario -p
```

\imagen[width=0.8\textwidth]{fotos/img12.png}

\newpage

## 6. PHP

PHP es un lenguaje de servidor diseñado para crear contenido web dinámico integrado con HTML.

### 6.1. Instalación de PHP y módulos de Apache
```terminal
sudo apt update
sudo apt install php libapache2-mod-php php-mysql
```

Verificamos la versión y el estado de Apache:
```terminal
php -v
sudo systemctl status apache2
```

\imagen[width=1\textwidth]{fotos/img13.png}
\imagen[width=1\textwidth]{fotos/img4.png}

\newpage

### 6.2. Creación página web

Creamos una página web de prueba en `/var/www/html/info.php`:
```terminal
sudo nano /var/www/html/info.php
```

```html
<?php
$DateAndTime = date('d.m.Y h:i:s a', time());
?>
<html>
<body>
<h1>Página de David y Marco</h1>
<h2>Fecha Actual: <?=$DateAndTime?></h2>
</body>
</html>
```

Al acceder desde el navegador a `localhost/info.php`, obtenemos:

\imagen[width=1\textwidth]{fotos/img14.png}

::: warning
Para permitir acceso HTTP externo, recordad abrir el puerto 80 en iptables:
`sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT`
:::

# Práctica final: segunda parte

## 1. Prueba ping desde Ubuntu 24 a Ubuntu 20

En esta prueba lanzamos varios paquetes ICMP mediante el comando ping desde la máquina con Ubuntu 24 hacia la IP de la máquina con Ubuntu 20. Con esto comprobamos que hay conectividad física y lógica entre ambas máquinas y que pueden comunicarse a través de la red sin bloqueos.

\imagen[width=0.6\textwidth]{fotos/imgconf.png}
\imagen[width=0.6\textwidth]{fotos/imgconf2.png}
\imagen[width=1\textwidth]{fotos/img15.png}
\imagen[width=1\textwidth]{fotos/img16.png}

\newpage

## 2. Prueba de uso de nmap para obtener información de los equipos y servicios de la red

Utilizamos la herramienta nmap desde un equipo escaneando la IP del otro para descubrir los puertos que tiene abiertos y los servicios que están escuchando. De esta forma podemos ver si el puerto 80 de web, el 3306 de MySQL o el 22 de SSH están activos y qué versión exacta están ejecutando.

\imagen[width=1\textwidth]{fotos/img17.png}
\imagen[width=1\textwidth]{fotos/img17.1.png}

\newpage

## 3. Prueba de conexión tcp-http entre ubuntu 20-ubuntu 24 y vuelta

Aquí comprobamos la comunicación HTTP a nivel de protocolo TCP entre ambas máquinas. Realizamos peticiones de un lado a otro abriendo la web desde el navegador, verificando en los dos sentidos que la conexión se establece correctamente.

\imagen[width=1\textwidth]{fotos/img18.png}

## 4. Analizar tráfico de red con Wireshark para ver web visitada y contraseñas al usar HTTP

### 4.1. Creamos la página de login:

```terminal
sudo nano /var/www/html/login.php
```

```html
<!DOCTYPE html>
<html lang="es">
<head>
<title>Ciudad</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initialscale=1.0">
</head>
<body>
<h1>Página de inicio de sesión de David y Marco</h1><br>
<form action="login2.php" method="POST">
<!-- Email input -->
<input type="email" name="usuario" placeholder="Enter a valid
email address"/>
 <br>
<!-- Password input -->
<input type="password" name="pswd" placeholder="Enter
password" />
<button type="submit" >Enviar</button>
</form>
</div>
</body>
</html>
```

\newpage

### 4.2. Creamos página de recuperar usuario y contraseña:

```terminal
sudo nano /var/www/html/login2.php
```

```html
<?php
$usuario = $_REQUEST["usuario"];
$pswd = $_REQUEST["pswd"];
?>
<!DOCTYPE html>
<html lang="es">
<head>
<title>Página de acceso</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<h4>Página de inicio de sesión de (nombre alumno)</h4><br>
<h5 >Contraseña correcta para el usuario
<?=$usuario?> </h5><br>
</body>
</html>
```

### 4.3. Captura del tráfico a partir de Wireshark

Abrimos Wireshark y nos ponemos a capturar el tráfico de la interfaz de red mientras interactuamos con la web para demostrar cómo HTTP envía todo en texto plano sin ningún tipo de cifrado.

\imagen[width=1\textwidth]{fotos/img19.png}
\imagen[width=1\textwidth]{fotos/img20.png}
\imagen[width=1\textwidth]{fotos/img21.png}

\newpage

## 5. Ejercicio adicional

Para el ejercicio extra hemos modificado el documento login.php añadido unas cuantas lineas donde ciframos la contraseña por completo e impide que la contraseña sea vista a través de internet como por ejemplo en wireshark. Podria haberse hecho de otras formas, como por ejemplo usando ssl o https, pero esta era una manera sencilla donde solo tenias que modificar el html del login.php
