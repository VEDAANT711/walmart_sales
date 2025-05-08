select first_name from sakila.customer as c;
# 1). all films with PG-13 Rating with rental rate of 2.99 or lower
select * from sakila.film f
where f.rental_rate <= 2.99
and f.rating = 'PG-13';

SELECT 
    title, special_features, release_year
FROM
    sakila.film f
WHERE
    f.special_features LIKE '%Deleted Scenes%'
        AND title LIKE 'c%';

SELECT 
    COUNT(*) AS active_customer_count
FROM
    sakila.customer
WHERE
    active = 1;

Select
		first_name,
    last_name,
    active,
    last_update,
    count(*) over () as
active_customers_count
from sakila.customer
where active = 1;

SELECT 
    r.rental_id,
    r.rental_date,
    r.customer_id,
    concat(c.first_name,' ',
    c.last_name) as CustomerName
FROM 
    sakila.rental AS r
        JOIN
    customer c ON c.customer_id = r.customer_id
WHERE
    DATE(rental_date) = '2005-07-26'; 
    
#5) Distinct names of customers whoe rented movie on 26th July 2005    
Select distinct r.customer_id, concat(c.first_name,' ',c.last_name) as FullName
from sakila.rental as r
join customer c on c.customer_id = r.customer_id
where date(rental_date)='2005-07-26';

#6) How many distinct last name in data

select distinct last_name,count(*) over () as
distinct_customers_count
from sakila.customer;

#7) How many rentals we do on each day

select date(rental_date) d, count(*) from rental
group by date(rental_date);

#8) What is the bussiest day so far

select date(rental_date) Bussiest_day, count(*) as total from rental
group by date(rental_date)
order by total desc
limit 1;

# 9) All sci-fi films in our catalogue
select * from sakila.category;
select * from sakila.film_category where category_id = "14";

SELECT 
    fc.film_id, fc.category_id, c.name, f.title, f.release_year
FROM
    film_category fc
        JOIN
    category c ON c.category_id = fc.category_id
        JOIN
    film f ON f.film_id = fc.film_id
WHERE
    c.name = 'Sci-Fi';

#10) Customers and how many movies they rented from us so far?

select r.customer_id, c.first_name, c.email, count(*) from rental r
join customer c on c.customer_id = r.customer_id
group by r.customer_id
order by count(*) desc;

#11) which movie should discontinue?

with low_rentals as 
(select inventory_id, count(*) 
from rental r
group by inventory_id
having count(*) <=1)
select low_rentals.inventory_id, i.film_id, f.title from low_rentals
join inventory i on i.inventory_id = low_rentals.inventory_id
join film f on f.film_id = i.film_id;

#10) which movies is not returned yet?

select r.rental_date,i.film_id,r.customer_id,f.title 
from rental r 
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
where r.return_date is null
order by f.title;



#11) How much money and revenue we make for store 1 by day?

SELECT 
    DATE(payment_date) AS day, SUM(amount) AS daily_revenue
FROM
    payment
WHERE
    staff_id IN (SELECT 
            staff_id
        FROM
            staff
        WHERE
            store_id = 1)
GROUP BY DATE(payment_date)
ORDER BY day;


#12).three top earnings days so far

SELECT 
    DATE(payment_date) AS day, SUM(amount) AS daily_revenue
FROM
    payment
WHERE
    staff_id IN (SELECT 
            staff_id
        FROM
            staff
        WHERE
            store_id = 1)
GROUP BY DATE(payment_date)
ORDER BY daily_revenue desc
limit 3;

-- Q1). How do you find duplicate records in a table? 
select * from sakila.actor;
select first_name, count(*) from actor 
group by first_name having count(*) > 1;

-- Q2).




