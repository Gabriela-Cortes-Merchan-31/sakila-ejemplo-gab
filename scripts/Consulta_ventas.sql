use sakila;

#----query ventas para ir a ventas tiene que ir a tiennda staff y ahi si pagos
#---colocar cte-- para saber que corra tabla por tabla, es una vista (idea tabla temporal pero no es)
#--- 1.primer paso todos los join luesgo agrupar
with ventas_por_tienda as( 
    select
        st.store_id,
        concat(a.address, ', ', ci.city) as store,
        co.country,
        concat(sf.first_name, ' ', sf.last_name) as staff,
        p.amount,
        year(p.payment_date) as year,
        month(p.payment_date) as month,
        dayofmonth(payment_date) as day
    from store as st
        join address as a using(address_id)#--- la direccion tenia ciudasd y pais toca hacer join
        join city as ci using(city_id)
        join country as co using(country_id)
        join staff as sf using(store_id)
        join payment as p using(staff_id)
), 

#--- 2. agrupar y sumar
ventas_por_tienda_por_anno_mes as (
    select
        store,
        year,
        month,
        sum(amount) amount
    from ventas_por_tienda
    group by 
        store,
        year,
        month
),

#----3.Colocar las sumas de los meses en columnas
ventas_por_tienda_por_mes2 as (
    select 
    store,
    sum(case when year = 2005 and month =5 then amount else 0 end) may2005,
    sum(case when year = 2005 and month =6 then amount else 0 end) jun2005,
    sum(case when year = 2005 and month =7 then amount else 0 end) jul2005
    from ventas_por_tienda_por_anno_mes
    group by store
),

#----4. Calcula las diferencias
ventas_por_tienda_comparativa as (
    select 
    store,
    may2005,
    jun2005,
    (jun2005 - may2005) as diffjun2005,
    jul2005,
    (jul2005 - jun2005) as diffjul2005
    from ventas_por_tienda_por_mes2
)

#--- se trasforma en un subselectselect dentro de otro select
select *
from ventas_por_tienda_comparativa 
limit 5;
 


 
