---
tipo: "PRÁCTICA"
title: "Práctica Integradora"
author: "David Rodera"
subject: "Administración de Sistemas Operativos"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Práctica Integradora · ASO"
---

# Bloque A - Procesos

### 1. Identifica el proceso del contenedor en el host. Obtén el PID del proceso principal del contenedor mi-apache-php. Compáralo con ps y pstree.


\imagen[width=1\textwidth]{fotos3/img1.png}

\imagen[width=0.9\textwidth]{fotos3/img2.png}

\imagen[width=0.7\textwidth]{fotos3/img3.png}

Estos comandos permiten identificar un contenedor de forma jerárquica desde Docker hasta el sistema operativo: **docker inspect** obtiene el PID principal del contenedor mi-apache-php (2195); **ps** muestra los detalles de dicho proceso, incluyendo su proceso padre (2170) y el comando de ejecución (httpd -DFOREGROUND); y **pstree** visualiza en forma de árbol el proceso principal junto con sus procesos hijos generados por Apache.

### 2. Estados y ciclo de vida. Arranca, para y destruye el contenedor. Documenta los estados (Up, Exited) y el PID en cada fase.
