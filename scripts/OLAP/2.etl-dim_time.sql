-- USAR LAS TABLAS CON EL NOMBRE DEL ESQUEMA
-- SAKILA.RENTAL

insert into sakila_dwh.dim_time(
    date_key,
    date_value,
    month_number,
    month_name,
    year4,
    day_of_week,
    day_of_week_name
)
-- segundo trasforme
select
    TO_DAYS(date) as date_key,
    date as date_value,
    month(date) as month_number,
    monthname(date) as month_name,
    year(date) as year4,
    dayofweek(date) as day_of_week,
    dayname(date) as day_of_week_name
-- primero estrae datos
from (
    select distinct date(rental_date) as date
    from sakila.rental
) as fechas
where date not in (
    select date_value
    from sakila_dwh.dim_time
)
;