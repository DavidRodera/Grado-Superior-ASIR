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

Al emplear la clave correcta y los mismos parámetros criptográficos, la terminal devuelve exactamente el mensaje original sin alteraciones.

\newpage

## Parte 3: Reflexión

::: warning
**1. ¿Ǫué ocurre si intentas descifrar el mensaje con una clave incorrecta?**

Claramente no te va a dejar descifrarlo, ya que funciona solo usando la clave correcta con la se cifró, devuelviendo el comando un error de descifrado (bad decrypt). 
:::

::: note
**2. ¿Por qué es importante mantener la clave en secreto en el cifrado simétrico?**

Porque en cifrado simétrico hay una sola clave para cifrar y descifrar. Con lo cual si alguien consigue la clave podrá acceder.
:::

::: tip
**3. Aplicaciones del Cifrado Simétrico en la Vida Real**

Se aplica dentro de la fase de transferencia de datos en conexiones HTTPS/TLS.
:::

\newpage

# Práctica 3: Cifrado Asimétrico (RSA)

El cifrado asimétrico utiliza un par de claves matemáticamente vinculadas: una **clave pública** (que puede distribuirse libremente para cifrar mensajes) y una **clave privada** (que debe custodiarse en secreto para descifrarlos). En este apartado se implementa el algoritmo **RSA** mediante `openssl` para generar el par de claves y proteger la confidencialidad de un mensaje.

## Parte 1: Generación de Claves RSA

### 3.1.1. Generar la clave privada

En primer lugar, generaremos una clave privada RSA con una longitud de 2048 bits mediante el subcomando `genpkey`, almacenándola en el fichero `clave_privada.pem`:

```terminal
openssl genpkey -algorithm RSA -out clave_privada.pem -pkeyopt rsa_keygen_bits:2048
```

\imagen[width=1\textwidth]{fotos/img6.png}

### 3.1.2. Generar la clave pública

A partir de la clave privada generada previamente, extraeremos su correspondiente clave pública en formato PEM (clave_publica.pem) para poder compartirla con terceros:

```terminal
openssl rsa -in clave_privada.pem -pubout -out clave_publica.pem
```

\imagen[width=1\textwidth]{fotos/img7.png}

## Parte 2: Cifrar un Mensaje con la Clave Pública

### 3.2.1. Cifrado y almacenamiento del mensaje

A continuación, se cifra una cadena de texto en claro utilizando la clave pública del destinatario (-inkey clave_publica.pem -pubin) mediante openssl pkeyutl, guardando la salida binaria resultante en el archivo mensaje_cifrado.bin:

```terminal
echo "Mensaje secreto para ti" | openssl pkeyutl -encrypt -inkey clave_publica.pem -pubin -out mensaje_cifrado.bin
```

El fichero mensaje_cifrado.bin contendrá los datos protegidos y únicamente podrá ser revertido empleando la clave privada asociada.

\imagen[width=1\textwidth]{fotos/img8.png}

## Parte 3: Descifrar el Mensaje con la Clave Privada

### 3.3.1. Descifrado y verificación

Para recuperar el contenido original, ejecutaremos la operación inversa (-decrypt) pasando como parámetro la clave privada (clave_privada.pem) y el fichero cifrado de entrada:

```terminal
openssl pkeyutl -decrypt -inkey clave_privada.pem -in mensaje_cifrado.bin
```

Tras ejecutar el comando, la salida estándar devolverá el texto original en claro (Mensaje secreto para ti), confirmando que el proceso de cifrado y descifrado asimétrico se ha completado con éxito.

\imagen[width=1\textwidth]{fotos/img8.1.png}

\newpage

## Parte 4: Reflexión y preguntas

::: tip
**1. ¿Qué diferencia encuentras entre el cifrado simétrico y el asimétrico?**

La más clara es que no se usa la misma clave para cifrar que para descifrar, con lo cual, es más seguro.
:::

::: warning
**2. ¿Por qué es más seguro usar RSA en el intercambio de claves?**

El emisor cifra la clave de sesión con la clave pública del receptor, que puede circular libremente por un canal inseguro, y solo el receptor puede descifrarla con su clave privada. Así se evita el problema del cifrado simétrico, que exige compartir previamente un secreto.
:::

\newpage

# Práctica 4: Despliegue de CA y Certificados SSL/TLS mediante máquinas virtuales en Linux

En este apartado implementaremos una infraestructura de clave pública (**PKI**) local dentro de una máquina virtual Linux. El objetivo es crear una Autoridad Certificadora (**CA**) propia, emitir un certificado digital para un servidor web seguro (**HTTPS**) y verificar cómo un cliente local valida tanto la cadena de confianza como la autenticidad del servidor mediante el protocolo **TLS Handshake**.

## 1. Diseño del Esquema Técnico

\imagen[width=0.9\textwidth]{fotos/img21.png}

## 2. Justificación Teórica Razonada

Primero creamos la CA en la propia máquina virtual. Generamos su clave privada ca.key y con ella un certificado autofirmado, ca.crt. Como nadie avala a la CA, tenemos que decirle al sistema que se fíe de ella.

Después creamos las claves del servidor. servidor.key es privada y no sale de la máquina. A partir de ella hicimos servidor.csr, una petición con la clave pública y el nombre servidor.local. La CA la firmó con ca.key y nos devolvió servidor.crt. Esa firma garantiza que la clave pública pertenece a ese nombre. Con esos archivos configuramos Apache para que sirviera HTTPS.

La primera prueba la hicimos sin instalar la CA y curl falló con el error 60, porque el cliente no reconocía a quien firmó el certificado. Al importar ca.crt al almacén de confianza, el cliente pudo comprobar la firma y la conexión funcionó.

Con la firma no basta, porque el certificado es público y cualquiera podría copiarlo. Por eso, durante el handshake, el servidor firma datos de la conexión con servidor.key y el cliente lo verifica con la clave pública del certificado. Solo quien tiene la clave privada puede hacerlo, así que el servidor demuestra que es el auténtico. Luego ambos acuerdan una clave de sesión y el tráfico se cifra con AES.

Por último, cambiamos servidor.key por una clave falsa. Apache dio key values mismatch y no arrancó: sin la clave privada auténtica no hay handshake posible.

## 3. Despliegue de Comandos en Linux (Paso a Paso)

### Paso 1 y 2. Creación de la Autoridad Certificadora (CA)

Dentro del directorio de trabajo ~/ca-practica, se genera la clave privada de la CA (ca.key de 4096 bits) y su certificado raíz autofirmado (ca.crt) con una validez de 10 años (3650 días):

\imagen[width=1\textwidth]{fotos/img9.png}

### Paso 3. Generación de clave privada y CSR del servidor

Se crea la clave privada del servidor (servidor.key de 2048 bits) y se genera la solicitud de firma de certificado (servidor.csr) indicando el Common Name servidor.local:

\imagen[width=1\textwidth]{fotos/img10.png}

### Paso 4. Definición de la extensión SAN (Subject Alternative Name)

Dado que los clientes modernos y curl validan la identidad del servidor frente al campo SAN y no únicamente frente al CN, se crea el archivo de configuración ext.cnf:

\imagen[width=1\textwidth]{fotos/img11.png}

### Paso 5. Firma del certificado del servidor por parte de la CA

La CA firma la solicitud servidor.csr utilizando ca.key y ca.crt, incorporando las extensiones de ext.cnf para emitir el certificado final servidor.crt, y se verifica su validez con openssl verify:

\imagen[width=1\textwidth]{fotos/img12.png}

### Paso 6, 7 y 8. Instalación en Apache2, resolución local y activación de SSL

Se copian el certificado y la clave privada a las rutas del sistema (/etc/ssl/certs/ y /etc/ssl/private/), se añade la entrada 127.0.0.1 servidor.local en /etc/hosts, se configuran las directivas SSLCertificateFile y SSLCertificateKeyFile en /etc/apache2/sites-available/default-ssl.conf y se reinicia el servicio web:

\imagen[width=1\textwidth]{fotos/img13.png}

\newpage

Configuración aplicada en /etc/apache2/sites-available/default-ssl.conf:

\imagen[width=1\textwidth]{fotos/img14.png}

Comprobación de sintaxis y reinicio del servicio Apache2:

\imagen[width=1\textwidth]{fotos/img15.png}

\newpage

## 4. Puesta a Prueba y Verificación

### Paso 9. Prueba inicial sin CA de confianza (Fallo esperado)

Al realizar una petición HTTPS antes de instalar la CA raíz en el sistema, curl devuelve el error curl: (60) SSL certificate problem: self signed certificate y openssl s_client muestra Verify return code: 18 (self signed certificate) al no reconocer al emisor:

\imagen[width=1\textwidth]{fotos/img16.png}

### Paso 10. Importación de la CA en el Trust Store local

Se copia el certificado raíz ca.crt al directorio /usr/local/share/ca-certificates/ y se actualiza el almacén de certificados del sistema operativo:

\imagen[width=1\textwidth]{fotos/img17.png}

### Paso 11. Verificación del Handshake y cadena de confianza

Tras actualizar el Trust Store, se comprueba la conexión TLS con openssl s_client, obteniendo Verify return code: 0 (ok), lo que acredita que la firma y el handshake se validan correctamente:

\imagen[width=1\textwidth]{fotos/img18.png}

### Paso 12 y 13. Comprobación de pareja clave-certificado y simulación de fallo con clave falsa

En primer lugar, se verifica mediante el módulo MD5 que servidor.crt y servidor.key pertenecen al mismo par criptográfico (ambos hashes coinciden en 4c1db5fe6291c53b37e55669b8769810). A continuación, se genera una clave privada falsa (falsa.key) y se sobrescribe /etc/ssl/private/servidor.key para simular un servidor que intenta presentar un certificado sin poseer su clave privada auténtica. Al intentar reiniciar Apache2, el servicio falla al detectar la incoherencia entre el certificado y la clave:

\imagen[width=1\textwidth]{fotos/img19.png}

\imagen[width=1\textwidth]{fotos/img20.png}
