# Diseño de la bodega de datos

## Alquiler
**NOTA**
Llave surrogada es una llave diseñada pára ser lo mas rapido posible.

- un numero, pequeño, con "cierto" orden
- No va a cambiar a pesar que la llave del negocio luego cambie

**Dim_Date**

NN: NOT NULL
UK: LLAVE ALTERNA
PK: LLAVE SURROGADA

| Columna         | Tiempo  | Resticciones   |
|-----------------|---------|----------------| 
|data_key         | int     | PK, NN         |
|date_value       | date    | UK, NN         |
|month_numbrer    | int     | NN             |
|month_name       | char(12)| NN             |
|year4            | int     | NN             |
|day_of_week      | int     | NN             |
|day_of_week_name | int     | NN             |
|year_month       | int     | NN             |

**Dim_store**

| Columna         | Tiempo    | Resticciones               |
|-----------------|-----------|----------------------------| 
|store_key        | int       | PK, NN,auto_increment      |
|store_id         | int       | UK, NN                     |
|store            |varchar(20)| NN                         |
|district         |varchar(20)| NN                         |
|city             |varchar(50)| NN                         |
|country          |varchar(50)| NN                         |
|last_update      |timestamp  |NN,default CURRENT_TIMESTAMP|



**Fact_Rental(Alquiler)**

| Columna         | Tiempo  | Resticciones      |
|-----------------|---------|-------------------| 
|rental_key       | int(8)  | PK, NN            |
|rental_id        | int     | UK, NN            |
|data_key         | int     | FK(dim_tiempo), NN|
|store_key        | int     | FK(dim_tiempo), NN|
|customer_key     | int     | FK(dim_tiempo), NN|
|count_rental     | int     | NN                |

**dim_customes**

| Columna         | Tiempo    | Resticciones               |
|-----------------|-----------|----------------------------| 
|customer_key     | int       | PK, NN,auto_increment      |
|customer_id      | int       | UK, NN                     |
|customer         |varchar(20)| NN                         |
|district         |varchar(20)| NN                         |
|city             |varchar(50)| NN                         |
|country          |varchar(50)| NN                         |
|last_update      |timestamp  |NN,default CURRENT_TIMESTAMP|

