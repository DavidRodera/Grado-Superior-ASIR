use sakila;
-- David Rodera

-- 1) Queremos conocer cuántas películas hay registradas en la base de datos por cada idioma. Para ello agrupamos las películas según su language_id, contamos cuántas hay en cada grupo, y posteriormente relacionamos ese resultado con la tabla language para mostrar el nombre del idioma. 
SELECT 
    language_id, name, films_in_language
FROM
    (SELECT 
        language_id, COUNT(*) AS films_in_language
    FROM
        film
    GROUP BY language_id) as t
        JOIN
    language USING (language_id)
ORDER BY films_in_language DESC , name;
-- 2) Deseamos saber qué idiomas tienen películas con una duración media superior a 110 minutos. Se calcula la media de la longitud (length) de las películas agrupadas por idioma y se filtran los casos que superan ese umbral.
SELECT 
    language_id, name, avg_length
FROM
    (SELECT 
        language_id, avg(length) AS avg_length
    FROM
        film
    GROUP BY language_id) as t
        JOIN
    language USING (language_id)
ORDER BY avg_length DESC , name;
-- 3) Queremos conocer el rango de precios de reemplazo de las películas por cada idioma, es decir, el coste mínimo y máximo. La subconsulta calcula ambos valores por idioma y la consulta exterior añade el nombre del idioma.
SELECT 
    language_id, name, max_replacement_cost, min_replacement_cost
FROM
    (SELECT 
        language_id, max(replacement_cost) AS max_replacement_cost, min(replacement_cost) AS min_replacement_cost
    FROM
        film
    GROUP BY language_id) as t
        JOIN
    language USING (language_id);
-- 4) Queremos saber qué idiomas tienen al menos una película clasificada con la calificación ’R’. Utilizamos una subconsulta correlacionada, ya que cada fila del exterior (language) evalúa la condición en la tabla film.
SELECT 
    language_id, name
FROM
    language
WHERE
    EXISTS( SELECT 
            *
        FROM
            film
        WHERE
            rating = 'R'
        GROUP BY language_id);
-- 5) Queremos obtener un único valor: cuántos idiomas diferentes existen en la tabla film. Al tratarse de un solo resultado, se utiliza una subconsulta escalar dentro del SELECT.
SELECT 
    films_languages
FROM
    (SELECT 
        COUNT(*) AS films_languages
    FROM
        language) AS t;
-- 6) Queremos saber cuántas películas tienen calificación ’R’. La subconsulta se ejecuta de forma independiente y devuelve un valor único, que se muestra en una columna.
SELECT 
    rating_R
FROM
    (SELECT 
        COUNT(*) AS rating_R
    FROM
        film
    WHERE
        rating = 'R') AS t;
-- 7) Queremos listar los actores que han participado en 30 o más películas. Usamos una CTE (Common Table Expression) que genera una tabla temporal con el número de películas por actor, y luego la consultamos como si fuera una tabla normal.
WITH film_count AS (
	SELECT actor_id, count(actor_id) AS num_films 
    FROM film_actor 
    GROUP BY actor_id)
SELECT actor_id, first_name, last_name, num_films 
FROM actor 
JOIN film_count USING(actor_id) 
WHERE num_films >= 30 
ORDER BY NUM_FILMS DESC, last_name, first_name;
    

    
    
    
    
    