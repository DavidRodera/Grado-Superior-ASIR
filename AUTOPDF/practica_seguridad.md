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

La verificación de integridad mediante funciones hash permite garantizar que un archivo no ha sufrido alteraciones durante su almacenamiento o transferencia. En este primer apartado se empleará el algoritmo **SHA-256** para comprobar cómo se genera la huella digital de un fichero y cómo varía ante cualquier mínima modificación.

## Parte 1: Generación y comprobación de integridad

### 1. Creación del archivo de texto

En primer lugar, crearemos un fichero de prueba y verificaremos su contenido:

```terminal
echo "archivo de prueba practica 2" > prueba_integridad.txt
cat prueba_integridad.txt
```

### 2. Generación del hash SHA-256 original

A continuación, obtendremos la huella digital SHA-256 del archivo mediante el comando `sha256sum`, obteniendo una cadena hexadecimal única de 64 caracteres. Este valor lo almacenaremos en un fichero para tomarlo como referencia:

```terminal
sha256sum prueba_integridad.txt > original.txt
cat original.txt
```

\imagen[width=1\textwidth]{fotos/img1.png}

\newpage

### 3. Modificación del archivo y nuevo cálculo del hash

Posteriormente, editaremos el contenido del archivo, generaremos de nuevo el hash SHA-256 y lo compararemos con el del fichero donde guardamos el anterior hash.

```terminal
echo "archivo cambiado de prueba practica 2" > prueba_integridad.txt
cat prueba_integridad.txt
sha256sum prueba_integridad.txt
cat original.txt
```

\imagen[width=1\textwidth]{fotos/img2.png}

## Parte 2: Reflexión y Análisis

::: note
**1. ¿Por qué cambia el hash al modificar el contenido?**

Porque el primer hash que hemos creado es de exactamente los carácteres que estaban escritos previamente. Si modificamos algo, aunque sea una letra o un espacio, el hash cambia completamente.
:::

::: tip
**2. Aplicación en la Vida Real**

Se puede usar para comprobar o certificar que, por ejemplo, unos datos de una empresa no han sido manipulados absolutamente nada.
:::

\newpage

# Práctica 2: Cifrado Simétrico (AES)

El cifrado simétrico es un método criptográfico en el que se emplea una única clave compartida tanto para cifrar como para descifrar la información. En este apartado se utiliza el estándar **AES (Advanced Encryption Standard)** mediante la herramienta `openssl` para proteger mensajes y comprobar su funcionamiento.

## Parte 1: Cifrado del Mensaje

### 1.1. Verificación e instalación de OpenSSL

En primer lugar, se comprobará si el paquete `openssl` se encuentra instalado en el sistema consultando su versión actual:

```terminal
openssl version
```

\imagen[width=0.7\textwidth]{fotos/img3.png}

En caso de no disponer de la herramienta, se actualizan los repositorios e instala el paquete correspondiente:

```terminal
sudo apt-get update
sudo apt-get install openssl
```

\newpage

### 1.2. Cifrado de un mensaje con AES-256

A continuación, cifraremos una cadena de texto utilizando el algoritmo AES con clave de 256 bits en modo CBC (-aes-256-cbc), codificando el resultado en Base64 (-a), añadiendo aleatoriedad (-salt) y derivando la clave mediante PBKDF2 (-pbkdf2). La salida cifrada se redirige al fichero mensaje_cifrado:

```terminal
echo "Este es un mensaje secreto de David y Marco" | openssl enc -aes-256-cbc -a -salt -pass pass:clave -pbkdf2 > mensaje_cifrado
cat mensaje_cifrado
```

\imagen[width=1\textwidth]{fotos/img4.png}

## Parte 2: Descifrado del Mensaje

### 2.1. Descifrado y verificación del mensaje original

Para recuperar el texto en claro, leeremos el contenido del archivo mensaje_cifrado y enviaremos mediante tubería a openssl enc incorporando el parámetro -d (decrypt) junto con la misma contraseña y opciones utilizadas durante el cifrado:

```terminal
echo mensaje_cifrado | openssl enc -aes-256-cbc -d -a -salt -pass pass:clave -pbkdf2
cat mensaje_cifrado
```

\imagen[width=1\textwidth]{fotos/img5.png}
