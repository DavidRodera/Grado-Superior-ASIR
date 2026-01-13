use sakila;
-- David Rodera

-- 1: Clientes con al menos un alquiler.
SELECT DISTINCT
    customer_id, first_name, last_name
FROM
    customer
        JOIN
    store USING (store_id)
        JOIN
    rental USING (customer_id)
WHERE
    store_id = 1
ORDER BY customer_id;
-- 2: Todos los clientes y sus alquileres.
SELECT 
    customer_id,
    first_name,
    last_name,
    COUNT(rental.customer_id) AS n_rentals
FROM
    customer
        JOIN
    store USING (store_id)
        LEFT JOIN
    rental USING (customer_id)
WHERE
    store_id = 1
GROUP BY customer_id , first_name , last_name
ORDER BY customer_id;
-- 3: Actores y sus películas.
SELECT 
    actor_id, first_name, last_name, film_id, title
FROM
    actor
        LEFT JOIN
    film_actor USING (actor_id)
        LEFT JOIN
    film USING (film_id)
ORDER BY actor_id; 
 -- 4: Categorías y películas.
 SELECT 
    category_id, name, film_id, title
FROM
    category
        LEFT JOIN
    film_category USING (category_id)
        LEFT JOIN
    film USING (film_id) 
UNION SELECT 
    category_id, name, film_id, title
FROM
    category
        RIGHT JOIN
    film_category USING (category_id)
        RIGHT JOIN
    film USING (film_id)
WHERE
    category.category_id AND film_id IS NULL
ORDER BY category_id , film_id;
-- 5: Películas y sus actores.
SELECT 
    film_id, title, actor_id, first_name, last_name
FROM
    film
        LEFT JOIN
    film_actor USING (film_id)
        LEFT JOIN
    actor USING (actor_id)
ORDER BY film_id , actor_id; 