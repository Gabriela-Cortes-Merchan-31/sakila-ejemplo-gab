use sakila;
insert into sakila_dwh.dim_customer(
    customer_id,
    customer,
    district,
    city,
    country
)

select
    cu.customer_id,
    CONCAT(cu.first_name, ' ',cu.last_name) as customer,
    ad.district,
    ci.city,
    co.country
from customer as cu 
    join address as ad using(address_id)
    join city as ci using(city_id)
    join country as co using(country_id)
;