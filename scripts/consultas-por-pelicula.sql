USE SAKILA;
-- 1. unir los datos
with datos_alquiler as (
SELECT
        film_id
        ,title
        ,category.name AS category,
        year(rental.rental_date) rental_year,
        month(rental.rental_date) rental_month,
        day(rental.rental_date) rental_date
        -- COUNT(rental_id) AS times_rented
    FROM inventory
        LEFT JOIN rental USING(inventory_id)
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
    -- GROUP BY film_id, title, category
    ),
-- 2. agrupar por año mes
datos_alquiler_anno_mes as (
    SELECT
        title,
        rental_year,
        rental_month,
        COUNT(*) rental_times
    FROM datos_alquiler
    GROUP by 
        title,
        rental_year,
        rental_month
),
-- 3. trasposicion: siempre para trasponer hacer un sum
-- pasar filas a columnas
datos_alquiler_por_mes as (
    SELECT
        title,
        sum(case when rental_year = 2005 and rental_month = 5 then rental_times else 0 end) may2005,
        sum(case when rental_year = 2005 and rental_month = 6 then rental_times else 0 end) jun2005
    FROM datos_alquiler_anno_mes
    GROUP BY
        title
),
-- 4. calcular diferencias y porcentajes de crecimiento
datos_alquiler_comparativo_mes as (
    SELECT
        title,
        may2005,
        jun2005,
        (jun2005-may2005) diffjun2005,
        case when may2005 <> 0 then
            ((jun2005-may2005)/may2005)
        else
            0
        end as porcjun2005
    FROM datos_alquiler_por_mes
)
    SELECT * 
    FROM datos_alquiler_comparativo_mes
    LIMIT 5
    ; 