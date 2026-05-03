Implantación de Sistemas Operativos

[ ACT-8 ] Control de
configuraciones

David Rodera

Índice
1. Exportar un usuario existente​
2. Importar un usuario existente​
3. Borrar usuario​
4. Modificar usuario​
5. Añadir usuario a un grupo​

3
4
5
6
7

1. Exportar un usuario existente

Se ha realizado la exportación de un usuario específico mediante la herramienta de
línea de comandos ldifde. Utilizando el parámetro -d, se definió el nombre distintivo
(DN) del usuario "Guillermo" dentro de la estructura de unidades organizativas
(Primero, ASIR, GS, Informática) del dominio rodera.local. El resultado se guardó en el
archivo Guillermo.ldf, generando un registro con atributos técnicos como objectClass,
objectGUID y userAccountControl.

2. Importar un usuario existente

Se ha procedido a la exportación de la estructura del directorio (incluyendo clases de
objeto como top, domain y domainDNS para el dominio rodera.local) hacia un archivo
llamado David26.ldf utilizando el comando ldifde.

3. Borrar usuario

Se ha configurado un archivo LDIF (David26_borrar.ldf) con la instrucción changetype:
delete para eliminar al usuario con el nombre distintivo (DN) David26 ubicado en la
unidad organizativa de Informática.

4. Modificar usuario

Se han realizado múltiples cambios sobre el usuario David26 mediante el archivo
David26_modificar.ldf, incluyendo la adición de una descripción ("David26"), la
eliminación

del

(home-phone).

atributo home-fax y el reemplazo del número de teléfono

5. Añadir usuario a un grupo

Se ha modificado el objeto de grupo ISO para añadir como nuevo miembro al usuario
David26 utilizando el archivo de configuración David26_añadir_grupo.ldf y ejecutando la
herramienta de importación/exportación de directorios.

