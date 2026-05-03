---
title:   "[ ACT-7 ] Control de configuraciones"

author: "David Rodera"
subject: "Implantación de Sistemas Operativos"
date: "2024–2025"
---

# Instalación de Windows Server 2019, principales acciones/decisiones realizadas

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-000.png}

Se detallan las acciones y decisiones iniciales tomadas durante la instalación, como la
elección de la versión con "Experiencia de escritorio" para contar con una interfaz
gráfica (GUI).

# Instalar rol y características asociadas a Directorio Activo

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-001.png}

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-002.png}

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-003.png}

Describe el proceso de añadir los Servicios de dominio de Active Directory (AD DS) y la
configuración del servidor como el primer controlador de dominio de un nuevo bosque
llamado "rodera.local".

# Configuración de Red mediante "Interfaz Gráfica", IP estática en el Servidor (2019)

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-004.png}

Muestra cómo asignar una dirección IP estática (192.168.1.126) y el servidor DNS local
en el servidor a través de las propiedades de TCP/IPv4.

# Configuración de Red mediante "cmd", IP estática en el Cliente (Windows 7)

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-005.png}

Configuración de Red mediante "cmd": Explica la asignación de una IP estática
(192.168.1.127) en un cliente Windows 7 utilizando comandos netsh.

# Configuración de Red mediante "powershell", IP estática en el Cliente (Windows 10)

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/[ ACT-7 ] Control de configuraciones David Rodera_images/img-006.png}

Ilustra el uso del comando New-NetIpAddress para configurar la red de forma manual en un
cliente Windows 10.

6. Prueba de conectividad: Ping entre
Cliente vs Servidor y viceversa

Consiste en verificar la comunicación entre los equipos (cliente vs servidor) para asegurar
que la red está correctamente configurada.

7. Especificar nombre al servidor con la
estructura

Se define el nombre del equipo como "server_david" dentro de las propiedades del
sistema para identificarlo en la red.

8. Ordenador cliente añadido correctamente
al dominio.

Confirmación visual de que los equipos clientes se han unido correctamente al dominio
gestionado por el servidor.

9. Chuleta generada con IA, resumiendo los
principales conceptos en el directorio activo

10. Crear Estructura de ejemplo de usuarios
utilizando el comando DsQuery(Cada
alumno se creará una propia)

11. Crear una carpeta compartida en el
servidor, que sea utilizado por un
usuario(como unidad H) al hacer sesión en
un ordenador cliente.

Explica la configuración de un recurso compartido en el servidor para que aparezca
automáticamente como unidad de red (unidad H) al iniciar sesión el usuario.

Conclusiones
Este trabajo demuestra la correcta implementación de una infraestructura de red bajo
Windows Server 2019, logrando la integración técnica de clientes Windows 7 y 10
mediante configuraciones por GUI, CMD y PowerShell. La validación del dominio, junto
con la automatización de usuarios vía DsQuery y la gestión de recursos compartidos,
confirma un despliegue eficiente y funcional del Directorio Activo. El proyecto evidencia
así el dominio de las herramientas esenciales para la administración centralizada y la
conectividad profesional en sistemas operativos en red.

Bibliografía
Información impartida en clase
Página recomendada por el profesor → SOMEBOOKS
IA para generar la chuleta para resumir los conceptos de un Active Directory → Gemini


