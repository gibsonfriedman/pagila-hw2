/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */
SELECT film.title FROM film 
JOIN (SELECT title, unnest(special_features) FROM film) as t1 USING (title)
JOIN (SELECT title, unnest(special_features) FROM film) as t2 USING (title)
WHERE t1.unnest = 'Trailers' AND t2.unnest = 'Behind the Scenes'
ORDER BY film.title;
