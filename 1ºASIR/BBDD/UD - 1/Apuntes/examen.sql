-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
use sakila;
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
SELECT 
    first_name,
    last_name,
    COUNT(film_actor.actor_id) AS num_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY first_name , last_name;
-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
SELECT 
    first_name,
    last_name,
    COUNT(film_actor.actor_id) AS num_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY first_name , last_name
HAVING num_films >= 20;
-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
SELECT 
    name, COUNT(film_id) AS num_films
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY name;
-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
SELECT 
    name, ROUND(AVG(length)) AS film_length
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY name
HAVING film_duration > 110;
-- 5:  Para cada película, muestra cuántas copias hay en el inventario.
SELECT 
    title, COUNT(inventory.film_id) AS num_copies
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY title;
-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.
SELECT 
    title, COUNT(inventory.film_id) AS num_copies
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY title
HAVING num_copies >= 5;
-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
SELECT 
    inventory.inventory_id,
    COUNT(rental.rental_id) AS num_rentals
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY inventory.inventory_id;
-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.
SELECT 
    first_name, last_name, COUNT(customer_id) AS num_rentals
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY first_name , last_name;
-- 9:  Lista los clientes con 30 o más alquileres acumulados.
SELECT 
    first_name, last_name, COUNT(customer_id) AS num_rentals
FROM
    customer
        JOIN
    r ental USING (customer_id)
GROUP BY first_name , last_name
HAVING num_rentals >= 30;
-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
SELECT 
    first_name, last_name, SUM(amount) AS total_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY first_name , last_name;
-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.
SELECT 
    first_name, last_name, SUM(amount) AS total_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY first_name , last_name
HAVING total_amount >= 200;
-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.
SELECT 
    first_name,
    last_name,
    COUNT(payment.staff_id) AS num_payments_processed
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY first_name , last_name;
-- 13:  Para cada empleado, muestra el importe total procesado.
SELECT 
    first_name, last_name, SUM(payment.amount) AS total_amount
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY first_name , last_name;
-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.
SELECT 
    store_id, COUNT(inventory_id) AS num_items
FROM
    store
        JOIN
    inventory USING (store_id)
GROUP BY store_id;
-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
SELECT 
    store_id, COUNT(customer_id) AS num_customers
FROM
    store
        JOIN
    customer USING (store_id)
GROUP BY store_id;
-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
SELECT 
    store_id, COUNT(staff_id) AS num_staffs
FROM
    store
        JOIN
    staff USING (store_id)
GROUP BY store_id;
-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
SELECT 
    address, COUNT(store_id) AS num_stores
FROM
    address
        JOIN
    store USING (address_id)
GROUP BY address;
-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.
SELECT 
    address, COUNT(staff_id) AS num_staffs
FROM
    address
        JOIN
    staff USING (address_id)
GROUP BY address;
-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.
SELECT 
    address, COUNT(customer_id) AS num_customers
FROM
    address
        JOIN
    customer USING (address_id)
GROUP BY address;
-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.
SELECT 
    city, COUNT(address_id) AS num_address
FROM
    city
        JOIN
    address USING (city_id)
GROUP BY city;
-- 21:  Para cada país, cuenta cuántas ciudades existen.
SELECT 
    country, COUNT(city_id) AS num_cities
FROM
    country
        JOIN
    city USING (country_id)
GROUP BY country;
-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
SELECT 
    name, ROUND(AVG(length)) AS film_length
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY name
HAVING film_duration BETWEEN 90 AND 120;
-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
SELECT 
    film_id, COUNT(rental.rental_id) AS num_rentals
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY film_id;
-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
SELECT 
    first_name,
    last_name,
    COUNT(payment.customer_id) AS num_payments_2005
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY first_name , last_name;
-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
SELECT 
    film_id, ROUND(AVG(rental_rate), 2) AS rental_rate
FROM
    inventory
        JOIN
    film USING (film_id)
GROUP BY film_id;
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
SELECT 
    first_name, last_name, ROUND(AVG(length)) AS film_length
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
GROUP BY first_name , last_name;
-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
SELECT 
    city, COUNT(customer_id) AS num_customers
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city;
-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
SELECT 
    title, COUNT(actor_id) AS num_actors
FROM
    film
        JOIN
    film_actor USING (film_id)
        JOIN
    actor USING (actor_id)
GROUP BY title;
-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
SELECT 
    category_id, COUNT(film.film_id) AS num_films
FROM
    film_category
        JOIN
    film USING (film_id)
GROUP BY category_id;
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
SELECT 
    store_id, COUNT(rental_id) AS num_rentals
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    rental USING (inventory_id)
GROUP BY store_id;
-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
SELECT 
    first_name, last_name, COUNT(film_id) AS num_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
GROUP BY first_name , last_name
HAVING num_films > 15;
-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
SELECT 
    name, COUNT(film_id) AS num_films
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY name;
-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
SELECT 
    title, COUNT(rental_id) AS num_rentals
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY title;
-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
SELECT 
    first_name, last_name, SUM(amount) AS total_amount_2005
FROM
    customer
        JOIN
    rental USING (customer_id)
        JOIN
    payment USING (rental_id)
WHERE
    YEAR(rental_date) = 2005
GROUP BY first_name , last_name
HAVING total_amount_2005 >= 150;
-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.
SELECT 
    store_id, SUM(amount) AS total_amount
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
GROUP BY store_id;
-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
SELECT 
    city, COUNT(staff_id) AS num_staffs
FROM
    staff
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city;
-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
SELECT 
    city, COUNT(store_id) AS num_stores
FROM
    store
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city;
-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.
SELECT 
    first_name,
    last_name,
    ROUND(AVG(length)) AS film_length_2006
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    YEAR(release_year) = 2006
GROUP BY first_name , last_name;
-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.
SELECT 
    name, ROUND(AVG(length)) AS film_length
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY name
HAVING film_length > 120; 
-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
SELECT 
    name, SUM(rental_rate) AS total_rental_rate
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY name;
-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
SELECT 
    first_name,
    last_name,
    COUNT(rental_date) AS rental_date_weekend
FROM
    customer
        JOIN
    rental USING (customer_id)
WHERE
    DAYOFWEEK(rental_date) IN (1 , 7)
GROUP BY first_name , last_name;
-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
 SELECT 
    first_name,
    last_name,
    COUNT(DISTINCT (film.film_id)) AS num_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
GROUP BY first_name , last_name;
-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
SELECT 
    city, COUNT(customer_id) AS num_customers
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city;
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
SELECT 
    name, COUNT(DISTINCT (actor_id)) AS num_actors
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    film_actor USING (film_id)
GROUP BY name;
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
SELECT 
    store.store_id, COUNT(inventory.film_id) AS num_copies
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
WHERE
    release_year = 2006
GROUP BY store.store_id;
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
SELECT 
    customer.first_name,
    customer.last_name,
    SUM(amount) AS total_amount_store_1
FROM
    customer
        JOIN
    payment USING (customer_id)
        JOIN
    staff USING (staff_id)
WHERE
    staff.store_id = 1
GROUP BY customer.first_name , customer.last_name;
-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
SELECT 
    title, COUNT(film_actor.actor_id) AS num_actors
FROM
    film
        JOIN
    film_actor USING (film_id)
        JOIN
    actor USING (actor_id)
WHERE
    LENGTH(last_name) >= 5
GROUP BY title;
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
SELECT 
    name, SUM(length) AS total_length
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY name;  
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
SELECT 
    city, SUM(amount) total_amount
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
GROUP BY city;
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
SELECT 
    name, COUNT(DISTINCT (actor_id)) AS num_actors
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    film_actor USING (film_id)
GROUP BY name;
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
SELECT 
    store_id, COUNT(active)
FROM
    store
        JOIN
    customer USING (store_id)
WHERE
    active = 1
GROUP BY store_id;
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
SELECT 
    first_name,
    last_name,
    COUNT(DISTINCT (category_id)) AS num_categories
FROM
    film_category
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    customer USING (customer_id)
WHERE
    release_year = 2006
GROUP BY first_name , last_name;
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
SELECT 
    staff.first_name,
    staff.last_name,
    COUNT(DISTINCT (customer_id)) AS num_customers
FROM
    staff
        JOIN
    payment USING (staff_id)
        JOIN
    customer USING (customer_id)
GROUP BY staff.first_name , staff.last_name;
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
SELECT 
    city, COUNT(film_id)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    rental USING (customer_id)
        JOIN
    inventory USING (inventory_id)
        JOIN
    film USING (film_id)
WHERE
    release_year = 2006
GROUP BY city;
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
SELECT 
    name,
    ROUND(AVG(replacement_cost), 2) AS avg_replacement_cost
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY name;
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
SELECT 
    store.store_id, SUM(amount) AS total_amount_2006
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
WHERE
    YEAR(payment_date) = 2006
GROUP BY store.store_id; 
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
SELECT 
    first_name, last_name, COUNT(film_id) num_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    LENGTH(title) > 12
GROUP BY first_name , last_name;
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
SELECT 
    city, SUM(amount) AS total_amount_2006
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY city having total_amount_2006 >= 300;
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
SELECT 
    name, COUNT(rating) AS num_films
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
WHERE
    rating IN ('PG' , 'PG-13')
GROUP BY name;
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
SELECT 
    customer.first_name,
    customer.last_name,
    SUM(amount) AS total_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
        JOIN
    staff USING (staff_id)
WHERE
    payment.staff_id = 2
GROUP BY customer.first_name , customer.last_name; 
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
SELECT 
    city, COUNT(customer_id) AS num_customers
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
GROUP BY city
HAVING num_customers >= 10;
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
SELECT 
    first_name, last_name, COUNT(rental_id) AS num_rentals
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY first_name , last_name; 
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
SELECT 
    name, SUM(amount) AS total_amount
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
GROUP BY name;
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
SELECT 
    city, SUM(amount) AS total_amount_2005
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY city; 
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
SELECT 
    store_id, COUNT(DISTINCT (actor_id)) num_actors
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
        JOIN
    film_actor USING (film_id)
GROUP BY store_id;
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
SELECT 
    name, COUNT(rental_id) AS num_rentals
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY name;
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
SELECT 
    first_name,
    last_name,
    COUNT(DISTINCT (MONTH(payment_date))) AS num_months
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY first_name , last_name;
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
SELECT 
    name, ROUND(AVG(length)) AS avg_length
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
GROUP BY name;
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
SELECT 
    country, COUNT(customer_id) AS num_customers
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
GROUP BY country;
-- 70:  Para cada país, suma los importes pagados por sus clientes.
SELECT 
    country, SUM(amount) AS total_amount
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
GROUP BY country;
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
SELECT 
    store_id, COUNT(DISTINCT (category_id)) AS num_categories
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
GROUP BY store_id; 
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
SELECT 
    store.store_id, name, SUM(amount)
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    store USING (store_id)
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
GROUP BY store.store_id , name;
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(DISTINCT (store.store_id)) AS num_stores
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    store USING (store_id)
        JOIN
    customer USING (store_id)
        JOIN
    rental USING (customer_id)
GROUP BY actor.first_name , actor.last_name;
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
SELECT 
    name, COUNT(DISTINCT (customer_id)) AS num_customers
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    store USING (store_id)
        JOIN
    customer USING (store_id)
GROUP BY name;
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
SELECT 
    name, COUNT(DISTINCT (actor_id)) AS num_actors
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    film_actor USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY name;
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
SELECT 
    country, COUNT(store_id) AS num_stores
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    store USING (address_id)
GROUP BY country;
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
SELECT 
    first_name,
    last_name,
    COUNT(DAY(rental_date)) AS num_rentals
FROM
    customer
        JOIN
    rental USING (customer_id)
WHERE
    DAY(rental_date) = DAY(return_date)
GROUP BY first_name , last_name;
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
SELECT 
    store_id,
    COUNT(DISTINCT (payment.customer_id)) AS num_customers
FROM
    store
        JOIN
    customer USING (store_id)
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY store_id;
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
SELECT 
    name, COUNT(inventory.film_id) AS num_films
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
WHERE
    LENGTH(title) > 15
GROUP BY name;
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
SELECT 
    country, SUM(amount) AS total_amount
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    store USING (address_id)
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
GROUP BY country;
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
SELECT 
    first_name,
    last_name,
    ROUND(SUM(amount * 1.21), 2) AS total_amount_iva
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY first_name , last_name;  
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
SELECT 
    HOUR(rental_date) AS hour_rental,
    COUNT(rental_id) AS num_rentals
FROM
    rental
GROUP BY hour_rental
ORDER BY hour_rental ASC;
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
SELECT 
    store_id, ROUND(AVG(length)) AS avg_length
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    film USING (film_id)
WHERE
    YEAR(rental_date) = 2005
        AND length >= 100
GROUP BY store_id;
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
SELECT 
    name, AVG(replacement_cost) AS avg_replacement_cost
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
WHERE
    DAYOFWEEK(rental_date) = 1
GROUP BY name;
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
SELECT 
    first_name, last_name, SUM(amount) AS total_amount
FROM
    staff
        JOIN
    payment USING (staff_id)
WHERE
    HOUR(payment_date) BETWEEN 0 AND 5
GROUP BY first_name , last_name;
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
SELECT 
    first_name, last_name, COUNT(film.film_id) AS num_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    title LIKE '%LOVE%'
GROUP BY first_name , last_name;
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
SELECT 
    name, SUM(amount) AS total_amount
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY name;
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
SELECT 
    first_name,
    last_name,
    COUNT(DISTINCT ((rental_date))) AS num_days
FROM
    customer
        JOIN
    rental USING (customer_id)
WHERE
    YEAR(rental_date) = 2005
GROUP BY first_name , last_name;
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
SELECT 
    name, ROUND(AVG(LENGTH(title))) AS avg_length_title
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
GROUP BY name;
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
SELECT 
    store_id, COUNT(DISTINCT (customer_id)) AS num_rentals
FROM
    store
        JOIN
    customer USING (store_id)
        JOIN
    rental USING (customer_id)
WHERE
    MONTH(rental_date) BETWEEN 1 AND 3
        AND YEAR(rental_date) = 2006
GROUP BY store_id;
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
SELECT 
    country, COUNT(DISTINCT (category_id)) AS num_categories
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    rental USING (customer_id)
        JOIN
    inventory USING (inventory_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
GROUP BY country;
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
SELECT 
	customer_id, first_name, last_name, ROUND(AVG(amount), 2) AS avg_payment
FROM 
	customer
		JOIN 
	payment USING (customer_id)
GROUP BY customer_id, first_name, last_name
HAVING COUNT(payment_id) >= 10;
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
SELECT 
	category_id, COUNT(DISTINCT film_id) AS expensive_films_rented
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
WHERE replacement_cost > 20
GROUP BY category_id;
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
SELECT 
	store_id, SUM(amount) AS weekend_revenue
FROM 
	store
		JOIN 
	inventory USING (store_id)
		JOIN 
	rental USING (inventory_id)
		JOIN 
	payment USING (rental_id)
WHERE DAYOFWEEK(payment_date) IN (1,7)
GROUP BY store_id;
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
SELECT 
	actor_id, first_name, last_name, COUNT(DISTINCT film_id) AS films_rented
FROM 
	actor
		JOIN 
	film_actor USING (actor_id)
		JOIN 
	film USING (film_id)
		JOIN 
	inventory USING (film_id)
		JOIN 
	rental USING (inventory_id)
GROUP BY actor_id, first_name, last_name, film_id
HAVING COUNT(DISTINCT customer_id) >= 5;
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
SELECT 
	language_id, COUNT(DISTINCT film_id) AS films_starting_A
FROM 
	language
		JOIN 
	film USING (language_id)
		JOIN 
	inventory USING (film_id)
		JOIN 
	rental USING (inventory_id)
WHERE title LIKE 'A%'
GROUP BY language_id;
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
SELECT 
	country_id, SUM(amount) AS total_country_payments
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
GROUP BY country_id
HAVING SUM(amount) >= 1000;
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
SELECT 
	customer_id, first_name, last_name, DATEDIFF(MAX(rental_date), MIN(rental_date)) AS rental_span_days
FROM 
	customer
		JOIN 
	rental USING (customer_id)
WHERE YEAR(rental_date) = 2005
GROUP BY customer_id, first_name, last_name
HAVING COUNT(rental_id) >= 5;
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
SELECT 
	store_id, ROUND(AVG(amount), 2) AS avg_payment_2006
FROM 
	store
		JOIN 
	staff USING (store_id)
		JOIN 
	payment USING (staff_id)
WHERE YEAR(payment_date) = 2006
GROUP BY store_id;
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.
SELECT 
	category_id, AVG(length) AS avg_length_2006
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
WHERE YEAR(rental_date) = 2006
GROUP BY category_id
ORDER BY avg_length_2006 DESC;




-- ==============================================
-- TIPOS DE JOINS
-- ==============================================

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


-- ==============================================
-- SUBCONSULTAS
-- ==============================================

-- 1) Película(s) más larga(s) por categoría
SELECT 
    category_id, name, film_id, title, length
FROM
    (SELECT 
        category_id, MAX(length) AS max_length
    FROM
        film
    JOIN film_category USING (film_id)
    GROUP BY category_id) AS maximum
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    category USING (category_id)
WHERE
    film.length = maximum.max_length;
-- 2) Número de películas sin stock disponible en ninguna tienda
SELECT 
    COUNT(*) AS num_unavailable_films
FROM
    film
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            inventory
        WHERE
            inventory.film_id = film.film_id);
-- 3) Recaudación mensual por categoría en 2024
SELECT 
    MONTHNAME(payment_date) AS month, SUM(amount) AS amount
FROM
    payment
WHERE
    YEAR(payment_date) = 2005
GROUP BY month;
-- 4) Clientes con alquileres pero sin pagos registrados
SELECT 
    customer_id, first_name, last_name
FROM
    customer
WHERE
    EXISTS( SELECT 
            1
        FROM
            rental
        WHERE
            customer.customer_id = rental.customer_id)
        AND NOT EXISTS( SELECT 
            1
        FROM
            payment
        WHERE
            customer.customer_id = payment.customer_id);
-- 5) Cliente(s) que más ha(n) gastado en cada país
SELECT 
    country_id,
    country,
    customer_id,
    first_name,
    last_name,
    amount
FROM
    (SELECT 
        customer_id, MAX(amount) AS max_amount
    FROM
        payment
    GROUP BY customer_id) AS maximum
        JOIN
    payment USING (customer_id)
        JOIN
    customer USING (customer_id)
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
        JOIN
    country USING (country_id)
WHERE
    payment.amount = maximum.max_amount;
-- 6) Categorías con ingresos superiores a la media global
WITH category_amount AS (
SELECT
category_id, name, SUM(amount) as total_amount
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
GROUP BY category_id, name)
SELECT
category_id, name, total_amount
FROM
category_amount
WHERE total_amount > ( SELECT
AVG(total_amount)
FROM
category_amount);