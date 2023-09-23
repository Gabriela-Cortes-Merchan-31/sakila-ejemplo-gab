# Creacion del esquema de la bodega de datos 

create database if not exists sakila_dwh;
use sakila_dwh;

-- Dimension de tiempo
create table if not exists dim_time(
    date_key        int(8)    not null,
    date_value      date      not null,
    month_number     int(3)   not null,
    month_name       char(12) not null,
    year4            int(5)   not null,
    day_of_week      int(5)   not null,
    day_of_week_name char(12) not null,

    primary key (date_key),
    unique index data_value (date_value)
);

create table if not exists fact_rental (
    -- llave surrogada
    rental_key int(8) not null AUTO_INCREMENT,
    -- llave de la aplicacion
    rental_id int(11) not null,
    -- foreign jeys con las dimensiones
    date_key int(8) not null,
    store_key int(8) not null,
    customer_key int(8) not null,
    -- datos
    count_rental int(11) not null,

    primary key (rental_key),
    unique index rental_id (rental_id),

    index date_key (date_key),
    foreign key (date_key)
        references dim_time(date_key),
    index store_key (store_key),
    foreign key (store_key)
        references dim_store(store_key),
    index customer_key (customer_key),
    foreign key (customer_key)
        references dim_customer(customer_key)
);


---- dIMENSION TIENDA

create table if not exists dim_store(
    store_key int not null AUTO_INCREMENT,
    store_id tinyint(8) not null,
    
    store varchar(20) not null,
    district varchar(50) not null,
    city varchar(50) not null,
    country varchar(50) not null, 

    last_update timestamp not null default CURRENT_TIMESTAMP,

    PRIMARY KEY (store_key),
    unique index store_id(store_id)
);

-- customer 

create table if not exists dim_customer(
    customer_key int not null AUTO_INCREMENT,
    customer_id smallint(8) not null,
    
    customer varchar(90) not null,
    district varchar(50) not null,
    city varchar(50) not null,
    country varchar(50) not null, 

    last_update timestamp not null default CURRENT_TIMESTAMP,

    PRIMARY KEY (customer_key),
    unique index customer_id(customer_id)
);