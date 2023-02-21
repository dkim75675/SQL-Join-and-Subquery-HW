

-- list all customers who live in Texas
-- The customers who live in Texas are 
--Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still

SELECT first_name, last_name
FROM customer 
INNER JOIN address 
ON customer.address_id = address.address_id 
AND address.district = 'Texas';

-- Get all payments above $6.99 with the customer's full name
-- There are multiple customers who made payments above $6.99

SELECT first_name, last_name, payment.amount
FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id 
AND payment.amount > 6.99;

-- Show all customers names who have made payments over $175
-- Peter Menard is the only customer who made a payment over $175
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	GROUP BY customer_id 
	HAVING min(amount) > 175
);

-- List all customers that live in Nepal
-- Kevin Schuler is the only customer that lives in Nepal


SELECT country_id
FROM country 
WHERE country = 'Nepal'

SELECT first_name,last_name
FROM customer 
WHERE address_id IN (
	SELECT address_id 
	FROM address
	WHERE city_id IN (
	SELECT city_id
	FROM city 
	WHERE country_id = 66
	)
);

-- Which staff member had the most transactions
-- Jon Stephens had the most transactions

SELECT count(amount), staff.first_name, staff.last_name  
FROM payment 
INNER JOIN staff 
ON payment.staff_id = staff.staff_id 
GROUP BY staff.first_name, staff.last_name; 

-- How many movies of each rating are there?
-- Rating G has 178 movies
-- Rating PG has 194 movies
-- Rating R has 196 movies
-- Rating NC-17 has 209 movies
-- Rating PG-13 has 223 movies

SELECT rating, count(film_id)
FROM film 
GROUP BY rating
ORDER BY count(film_id);

-- Show all customers who have made a single payment above $6.99
-- There are multiple customers who made a single payment above $6.99

SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	WHERE amount > 6.99
	GROUP BY payment_id
	HAVING count(customer_id) = 1
);

-- How many free rentals did our stores give away?
-- 0 free rentals were given away by the stores


SELECT count(amount)
FROM payment 
WHERE amount = 0;
