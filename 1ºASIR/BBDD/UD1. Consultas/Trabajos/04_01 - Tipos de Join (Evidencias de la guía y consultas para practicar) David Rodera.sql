use ejemplos_tipos_join;

-- 1: Listado de alumnos con sus id_curso (sólo emparejados).
SELECT 
    alumnos.id_alumno, nombre, id_curso
FROM
    alumnos
        INNER JOIN
    matriculas USING (id_alumno)
ORDER BY alumnos.id_alumno , id_curso;
-- 2: Alumnos sin ninguna matrícula (anti-join). 
SELECT 
    alumnos.id_alumno, nombre
FROM
    alumnos
        LEFT JOIN
    matriculas USING (id_alumno)
WHERE
    id_curso IS NULL
ORDER BY alumnos.id_alumno;
-- 3: Matrículas sin alumno (huérfanas).
SELECT 
    id_matricula, matriculas.id_alumno, id_curso
FROM
    matriculas
        LEFT JOIN
    alumnos USING (id_alumno)
WHERE
    alumnos.id_alumno IS NULL
ORDER BY id_matricula;  
-- 4: Cursos del catálogo sin ninguna matrícula.
SELECT 
    cursos.id_curso, nombre_curso
FROM
    cursos
        LEFT JOIN
    matriculas USING (id_curso)
        LEFT JOIN
    alumnos USING (id_alumno)
WHERE
    id_alumno IS NULL
ORDER BY cursos.id_curso;
-- 5: Número de matrículas por alumno (incluye 0).
SELECT 
    alumnos.id_alumno,
    nombre,
    COUNT(matriculas.id_alumno) AS n_matriculas
FROM
    alumnos
        LEFT JOIN
    matriculas USING (id_alumno)
GROUP BY alumnos.id_alumno , nombre order by alumnos.id_alumno;
-- 6:  Alumnos con más de un curso.
SELECT 
    alumnos.id_alumno, nombre, COUNT(matriculas.id_alumno) AS n
FROM
    alumnos
        JOIN
    matriculas USING (id_alumno)
GROUP BY alumnos.id_alumno , nombre
HAVING n > 1
ORDER BY alumnos.id_alumno;
-- 7: FULL OUTER JOIN emulado (alumnos y sus matrículas, incluyendo huérfanas).
SELECT 
    alumnos.id_alumno, nombre, id_matricula, id_curso
FROM
    alumnos
        LEFT JOIN
    matriculas USING (id_alumno) 
UNION SELECT 
    alumnos.id_alumno, nombre, id_matricula, id_curso
FROM
    alumnos
        RIGHT JOIN
    matriculas USING (id_alumno)
WHERE
    alumnos.id_alumno IS NULL
ORDER BY 1 IS NULL , id_alumno , id_matricula;
-- 8: Para cada curso del catálogo, número de alumnos con matrícula válida (alumno y curso existen).
SELECT 
    id_curso, nombre_curso, COUNT(id_alumno) AS n_alumnos
FROM
    cursos
        LEFT JOIN
    matriculas USING (id_curso)
GROUP BY id_curso , nombre_curso
ORDER BY id_curso;

-- Tipo TEST: 
-- 1: B
-- 2: B
-- 3: B 
-- 4: C
-- 5: B
-- 6: B
-- 7: B
-- 8: B
-- 9: B
-- 10: B

use tienda_online;

-- 18: Lista todos los productos que nunca han sido vendidos, es decir, aquellos que no aparecen en ninguna fila de detalle_pedido.
SELECT DISTINCT
    (productos.id_producto), nombre AS producto
FROM
    productos
        LEFT JOIN
    detalle_pedido USING (id_producto)
WHERE
    detalle_pedido.id_producto IS NULL
ORDER BY producto ASC;
-- 19:   