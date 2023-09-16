use sakila;
#----query de empleados
select 
c.customer_id,#--- inf cliente
c.first_name,
c.last_name,
a.address_id,# --- inf direccion
a.address,
a.district,
ci.city_id,#--- inf ciudad
ci.city,
co.country_id,
co.country
from customer as c
inner join address as a using(address_id)#--- se puede hacer pór que las dos coplumnas se llaman igual
#---join con la ciudad
inner join city as ci using(city_id)
#---join con el pais
inner join country as co using(country_id)
limit 5;  


