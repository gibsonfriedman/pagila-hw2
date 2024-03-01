/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT rank, title, revenue, "total revenue",
CASE WHEN (100 * "total revenue" / SUM(revenue) OVER()) < 100 THEN trim(to_char((100 * "total revenue" / SUM(revenue) OVER ()), '00.00')) ELSE trim('100.00')
END AS "percent revenue"
FROM ( SELECT rank, title, revenue, SUM(revenue) OVER (ORDER BY rank) AS "total revenue"
	FROM (SELECT RANK () OVER (ORDER BY COALESCE(SUM(amount), 0.00) DESC) rank, title, COALESCE(SUM(amount), 0.00) AS revenue
FROM film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
GROUP BY title) as t ) as u
ORDER BY rank, title;
