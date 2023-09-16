-- se quiere ver agrupado por titulo y por cliente cuanto alquilo
-- agrupar por cliente
-- 1. sabana de datos
Use sakila;

-- 1. paso de crear la tabla

with renta_cliente as(
    SELECT
       film_id
        , title
        , category.name AS category
        , concat(first_name, ' ', last_name) customer
        , rental_date

    FROM inventory
        LEFT JOIN rental USING(inventory_id)
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
        LEFT JOIN customer using (customer_id)
),

-- 2 .separar las fechas

datos_con_fecha as (
    select
        customer,
        year(rental_date) as rental_year,
        month(rental_date) as rental_month,
        count(*) as rental_times
    from renta_cliente
    group by
        customer,
        rental_year,
        rental_month
),

-- 3. transposición siempre se hace un zoom caise where (pasar algunas filas a columnas)

datos_con_fechas_por_cliente as(
    select
        customer,
        sum(case when rental_year = 2005 and rental_month = 5 then rental_times else 0 end) AS may2005,
        sum(case when rental_year = 2005 and rental_month = 6 then rental_times else 0 end) as jun2005
    from datos_con_fecha
    group by
        customer
),

-- 4. Calcular diferencias y porcentajes de crecimiento

datos_con_fechas_por_cliente_mes as(
    select
        customer,
        may2005,
        jun2005,
        (jun2005 - may2005) as difjun2005,  -- junio-mayo
        case when may2005 <> 0 then
            ((jun2005 - may2005)/may2005)
        else
            0
        end as porcjun2005 -- (junio-mayo)/mayo
    from datos_con_fechas_por_cliente
)

SELECT *
FROM datos_con_fechas_por_cliente_mes
LIMIT 5
;