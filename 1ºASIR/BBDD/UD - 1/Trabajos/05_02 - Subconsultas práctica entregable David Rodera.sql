use sakila;
-- David Rodera

-- 1) Película(s) más larga(s) por categoría
SELECT 
    name, title, length
FROM
    film
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id)
WHERE
    length = (SELECT 
            MAX(length)
        FROM
            film
                JOIN
            film_category USING (film_id)
                JOIN
            category USING (category_id))
ORDER BY name ASC;
-- 2) Número de películas sin stock disponible en ninguna tienda
SELECT 
	COUNT(unavaliable_film) AS num_unavailable_films
FROM
	(SELECT
		film_id as unavaliable_film
	FROM
		film
			LEFT JOIN
		inventory USING (film_id)
			LEFT JOIN
		store USING (store_id)
	WHERE store_id IS NULL
	GROUP BY unavaliable_film) AS t;
-- 3) Recaudación mensual por categoría en 2024
SELECT 
    category, month, total
FROM
    (SELECT 
        name AS category,
            SUM(amount) AS total,
            MONTH(payment_date) AS month
    FROM
        payment
    JOIN rental USING (rental_id)
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    GROUP BY category , month) AS t
WHERE
    YEAR(month) = 2024
ORDER BY category ASC , month ASC;
-- 4) Clientes con alquileres pero sin pagos registrados
SELECT 
	customer_id,
	CONCAT(first_name, ' ', last_name) AS customer
FROM 
	customer
WHERE EXISTS (
    SELECT rental_id
    FROM rental
)
AND NOT EXISTS (
    SELECT 
		payment_id
    FROM 
		payment
);
-- 5) Cliente(s) que más ha(n) gastado en cada país
WITH total_spent AS(
    SELECT
        country,
        CONCAT(first_name, ' ', last_name) AS top_customer,
        SUM(amount) AS max_spent
    FROM 
		country
			JOIN 
		city USING (country_id)
			JOIN 
		address USING (city_id)
			JOIN 
		customer USING (address_id)
			JOIN 
		payment USING (customer_id)
    GROUP BY country, customer_id
),
max_per_country AS(
    SELECT
        country,
        MAX(max_spent) AS max_spent
    FROM 
		total_spent
    GROUP BY country
)
SELECT 
    country,
    top_customer,
    max_spent
FROM 
	total_spent
		JOIN 
	max_per_country USING (country, max_spent)
ORDER BY country ASC;
-- 6) Categorías con ingresos superiores a la media global
SELECT 
    name AS category, SUM(amount) AS total_revenue
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY category_id
HAVING SUM(amount) > (SELECT 
        AVG(cat_total)
    FROM
        (SELECT 
            category_id, SUM(amount) AS cat_total
        FROM
            category
        JOIN film_category USING (category_id)
        JOIN film USING (film_id)
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        JOIN payment USING (rental_id)
        GROUP BY category_id) AS t)
ORDER BY total_revenue DESC;