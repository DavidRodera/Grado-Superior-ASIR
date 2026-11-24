---
tipo: "PRÁCTICA · IAW"
title: "Tarea 3: Práctica pila LAMP"
author: "David Rodera"
subject: "IAW (Implantación de Aplicaciones Web)"
curso: "2ºASIR"
footer: "David Rodera · IAW (2ºASIR) · Práctica pila LAMP"
---

# Enunciado de la práctica

::: note
Siguiendo el documento adjunto en la unidad sobre la pila LAMP, vamos a arrancar los servicios de la pila LAMP de forma manual.

En una máquina virtual, ya que necesitamos tener permisos de administrador, vamos a ir arrancando los servicios a través del terminal.

En la tarea se os pide crear un documento donde expliquéis con vuestras palabras qué es la pila LAMP y los pasos necesarios (y los comandos) para arrancar los servicios.
:::

# 1. ¿Qué es la pila LAMP?

Cuando hablamos de la pila **LAMP**, nos referimos a un conjunto de cuatro tecnologías de software libre que se complementan entre sí para convertir un equipo en un servidor capaz de alojar páginas y aplicaciones web dinámicas. Cada letra de sus siglas representa una capa distinta de esta arquitectura:

| Capa | Tecnología | Función principal en el servidor |
| :--- | :--- | :--- |
| **L** | \textcolor{azulProfundo}{**Linux**} | Sistema operativo base (en nuestro caso, Ubuntu) que aporta el entorno de ejecución, la gestión de red y el control de permisos. |
| **A** | \textcolor{azulProfundo}{**Apache**} | Servidor web HTTP encargado de recibir las peticiones de los navegadores y devolver las páginas solicitadas. |
| **M** | \textcolor{azulProfundo}{**MySQL**} | Sistema gestor de bases de datos relacionales donde se almacena y consulta la información persistente de la aplicación. |
| **P** | \textcolor{azulProfundo}{**PHP**} | Lenguaje interpretado en el lado del servidor que procesa la lógica dinámica, consulta la base de datos y construye el HTML final. |

::: tip
La gran ventaja de trabajar con esta pila por separado —en lugar de recurrir a paquetes todo-en-uno— es que podemos administrar, asegurar y reiniciar cada demonio de manera independiente desde el sistema operativo.
:::

# 2. Despliegue y arranque manual de los servicios

Para llevar a cabo la instalación con privilegios de administración (`sudo`), hemos trabajado desde el terminal de una máquina virtual Ubuntu (`10.0.2.15`), levantando y comprobando cada servicio paso a paso.

## Paso 1: Capa web (Apache y cortafuegos UFW)

### 1. Instalación y arranque manual de Apache
En primer lugar, actualizamos la lista de paquetes disponibles en los repositorios e instalamos el servidor web `apache2`:

```terminal
sudo apt update
sudo apt install apache2
```

Una vez instalado, iniciamos el servicio de forma manual con `sudo systemctl start apache2` y comprobamos mediante `sudo systemctl status apache2` que el demonio queda activo y a la escucha de peticiones:

\imagen[width=0.85\textwidth]{fotos/img1.png}

### 2. Configuración y activación del cortafuegos UFW
Para controlar qué tráfico puede entrar al servidor, revisamos los perfiles de aplicaciones en UFW, habilitamos el perfil `"Apache"` (que abre el puerto **80/TCP** para tráfico HTTP sin abrir aún el 443 al no tener certificado SSL), permitimos `OpenSSH` como buena práctica antes de encender el firewall y activamos el servicio:

\imagen[width=0.8\textwidth]{fotos/img2.png}

### 3. Comprobación de red y acceso desde el navegador
Consultamos la dirección IP asignada a nuestra interfaz de red mediante el comando resumido `ip -br a`:

```terminal
ip -br a
```

Tras confirmar que nuestra máquina responde en la dirección `10.0.2.15`, abrimos el navegador web y accedemos a `http://10.0.2.15`, verificando que Apache sirve correctamente su página predeterminada de bienvenida:

\imagen[width=0.85\textwidth]{fotos/img3.jpg}

\newpage

## Paso 2: Capa de datos (MySQL y asegurado)

### 1. Instalación y puesta en marcha de MySQL Server
A continuación, instalamos el paquete del motor de bases de datos `mysql-server`:

```terminal
sudo apt install mysql-server
```

Arrancamos el demonio manualmente con `sudo systemctl start mysql` y revisamos su estado con `sudo systemctl status mysql` para asegurarnos de que el servidor está operativo:

\imagen[width=0.85\textwidth]{fotos/img4.png}

### 2. Asegurado de la instalación
Para cerrar configuraciones por defecto que no son recomendables en un entorno real, ejecutamos el asistente interactivo `sudo mysql_secure_installation`:

* **Validación de contraseñas (`n`):** Se omitió activar este componente porque Ubuntu autentica al usuario administrativo `root` mediante el plugin `auth_socket` vinculado al sistema.
* **Limpieza y restricciones (`y`):** Se confirmó la eliminación de los usuarios anónimos, el bloqueo del acceso remoto para `root`, el borrado de la base de datos de prueba `test` y la recarga inmediata de los privilegios.

\imagen[width=0.85\textwidth]{fotos/img5.png}

### 3. Verificación de acceso a la consola administrativa
Comprobamos que podemos entrar al monitor de MySQL desde el terminal utilizando `sudo mysql` (saliendo posteriormente con `exit;`):

\imagen[width=0.85\textwidth]{fotos/img6.png}

\newpage

## Paso 3: Capa de procesamiento (PHP e integración con Apache)

### 1. Instalación de PHP y sus conectores
Por sí solo, Apache únicamente entrega archivos estáticos. Para que sea capaz de interpretar código PHP y comunicarse con MySQL, instalamos tres paquetes esenciales: el intérprete base (`php`), el módulo de integración para Apache (`libapache2-mod-php`) y el controlador de bases de datos (`php-mysql`):

```terminal
sudo apt install php libapache2-mod-php php-mysql
```

### 2. Comprobación de versión y recarga del servidor web
Verificamos la versión instalada (`PHP 7.4.3`) y recargamos la configuración de Apache para que cargue el nuevo módulo sin interrumpir el servicio:

\imagen[width=0.85\textwidth]{fotos/img7.png}

## Paso 4: Prueba funcional de ejecución PHP en Apache

### 1. Creación de un archivo de diagnóstico
Para comprobar en la práctica que Apache ejecuta código PHP dinámicamente, creamos un pequeño archivo `info.php` dentro de la carpeta raíz del servidor web (`/var/www/html`) llamando a la función `phpinfo()`:

```terminal
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
```

Al abrir `http://10.0.2.15/info.php` en el navegador, el servidor interpreta el código y nos devuelve la ficha completa con la configuración activa de PHP 7.4 y el módulo `apache2handler`:

\imagen[width=0.85\textwidth]{fotos/img8.jpg}

### 2. Retirada del archivo de prueba por seguridad

::: warning
Una vez comprobado que toda la pila LAMP funciona de manera coordinada, debemos borrar el archivo `info.php` del directorio público del servidor. Dejarlo accesible expondría rutas internas, versiones exactas y parámetros sensibles de configuración.
:::

```terminal
sudo rm /var/www/html/info.php
```