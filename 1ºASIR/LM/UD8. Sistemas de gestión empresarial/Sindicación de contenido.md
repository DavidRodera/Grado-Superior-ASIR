---
title:   "Sindicación de Contenidos"
author:  "David Rodera"
subject: "Lenguajes de Marcas"
date:    "Curso 2024–2025"
---

## Accede a varias páginas web y localiza el enlace RSS o Atom, ¿se ven los dos formatos? ¿Qué estándar reconoces? Captura imagen de lo que has encontrado.

En la mayoría de los sitios web actuales se localizan botones con el icono de un punto y ondas (generalmente naranja) que enlazan a archivos **RSS** o **Atom**. Los estándares más reconocidos son **RSS 2.0** y **Atom 1.0**, que son formatos basados en **XML** para la difusión de contenidos.



## Localiza un documento RSS de internet y visualiza su estructura, comenta dicha estructura y elementos que lo componen.

Un documento **RSS** es un archivo **XML** con una estructura jerárquica. Se compone de una declaración de versión, una etiqueta raíz `<rss>`, un elemento `<channel>` que contiene la descripción del sitio (metadatos) y varios elementos `<item>` que representan las noticias o actualizaciones individuales.

## ¿Cuáles son los elementos obligatorios de un elemento channel? Enumera al menos 3 opcionales. Poniendo ejemplos de cada uno de ellos.

Según el estándar **RSS 2.0**, los elementos obligatorios de **channel** son **<title><title>**, **<link><link>** y **<description><description>**

Algunos elementos opcionales son **<language><language>**, **<copyright><copyright>** y **<lastBuildDate><lastBuildDate>**.

## ¿Cuáles son los elementos obligatorios de un elemento item? Enumera al menos 3 opcionales.

Un elemento **item** debe contener al menos un **<title><title>** o una **<description><description>** para ser válido.

Algunos elementos opcionales son **<link><link>**, **<pubDate><pubDate>** y **<guid><guid>**

## ¿Qué es un agregador? Tipos.

Un **agregador** es un software que permite al usuario agrupar las suscripciones de varios canales de noticias en una sola interfaz para su lectura. Hay varios tipos: **Agregadores de escritorio** (instalados localmente), **agregadores web** (servicios online), **extensiones de navegador** y **lectores integrados** en clientes de correo.



## Instala un agregador de escritorio y agrega algunas fuentes. Haz una captura de pantalla para enseñarlo.

Para esta actividad se suelen utilizar programas como **QuiteRSS** o **RSSOwl**, donde se añade la **URL** del canal para recibir las noticias automáticamente.

## ¿Qué significa validar un fichero fuente de un canal?

**Validar** significa verificar que el archivo **XML** cumple con las especificaciones y reglas sintácticas del estándar (**RSS** o **Atom**). Esto asegura que el archivo podrá ser leído correctamente por cualquier **agregador**.

## Indica los elementos de la estructura general básica de un fichero de sindicación de contenido.

La estructura básica incluye:
- **Declaración XML**
- **Elemento raíz**
- **Sección de metadatos**
- **Sección de contenidos**

## ¿Con qué etiquetas se designan a las distintas secciones de un canal en RSS?, ¿Y en Atom?

- En **RSS**: El contenedor principal es **channel** y cada noticia es un **item**.
- En **Atom**: El contenedor principal es **feed** y cada noticia es una **entry**.
