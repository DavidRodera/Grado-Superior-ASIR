---
title:   "Tarea 1.3 Usuarios y contraseñas en Linux"

author: "David Rodera"
subject: "Seguridad y Alta Disponibilidad"
date: "2026–2027"
---

## Ejercicio 5. Usuarios

**5.1. Crea dos cuentas de usuario usando el comando useradd con tu nombre y los sufijos del 01 al 02**

\imagen[width=0.7\textwidth]{fotos/img1.png}

**5.2 Haz un pantallazo del fichero /etc/passwd para ver que se han añadido los usuarios**

\imagen[width=0.7\textwidth]{fotos/img2.png}

**5.3 Una vez creado el usuario, vamos a crear una contraseña, pero el paso previo es definir una contraseña segura, para ello usamos openssl que viene incluido con Ubuntu**

\imagen[width=0.7\textwidth]{fotos/img3.png}

Usaremos la primera clave generada para el usuario david01 y la segunda para david02.

**5.4 Ahora creamos un nuevo grupo llamado grupoMiApellido (cada uno su apellido) e incluimos a los dos usuarios creados a ese grupo. Para comprobarlo podemos usar el comando groups [usuario]. Además, también lo podemos comprobar en el fichero etc/group**

\imagen[width=0.7\textwidth]{fotos/img4.png}

\imagen[width=0.7\textwidth]{fotos/img5.png}

## Ejercicio 6. Contraseñas

\imagen[width=0.7\textwidth]{fotos/img6.png}

\imagen[width=0.7\textwidth]{fotos/img7.png}
