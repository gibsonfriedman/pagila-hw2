/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT DISTINCT film.title FROM film LEFT JOIN (
	SELECT DISTINCT title FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        JOIN customer USING (customer_id)
        JOIN address USING (address_id)
        JOIN city USING (city_id)
        JOIN country USING (country_id)
        WHERE country = 'United States') AS x  USING (title)
	WHERE x.title IS NULL AND film.film_id IN (
	SELECT inventory.film_id
	FROM inventory)
ORDER BY film.title;
