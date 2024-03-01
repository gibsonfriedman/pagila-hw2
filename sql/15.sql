/*
 * Compute the total revenue for each film.
 */
SELECT film.title title, SUM(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) revenue
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY 1 ORDER BY 2 DESC;
