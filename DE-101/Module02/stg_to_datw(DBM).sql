-- create schema
create schema datw;




--CUSTOMER

-- create a table
drop table if exists datw.customer_datw;
CREATE TABLE datw.customer_datw
(
 cust_id       serial NOT NULL,
 customer_id   varchar(8) NOT NULL,
 customer_name varchar(22) NOT NULL,
 segment       varchar(11) NOT NULL,
 CONSTRAINT PK_customer_datw PRIMARY KEY ( cust_id )
);

-- deleting rows
truncate table datw.customer_datw;

-- inserting
insert into datw.customer_datw
select row_number() over(), customer_id, customer_name, segment
from 
(
  select distinct customer_id, customer_name, segment 
  from stg.orders
) a;

-- cheking
select * from datw.customer_datw;




-- PERSON

-- create a table
drop table if exists datw.person_datw;
create table datw.person_datw
(
 person_id serial NOT NULL,
 person    varchar(17) NOT NULL,
 region    varchar(7) NOT NULL,
 CONSTRAINT PK_person_datw PRIMARY KEY ( person_id )
);

-- deleting rows
truncate table datw.person_datw;

-- inserting
insert into datw.person_datw
select 100 + row_number() over(), person, region
from stg.people;

-- cheking 
select * from datw.person_datw;




--GEOGRAPHY

-- create a table
drop table if exists datw.geo_datw;
create table datw.geo_datw
(
 geo_id      serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(17) NOT NULL,
 "state"     varchar(20) NOT NULL,
 postal_code varchar(20) NOT NULL,
 person_id   serial NOT NULL,
 CONSTRAINT PK_geo_datw PRIMARY KEY ( geo_id ),
 CONSTRAINT FK_person_datw FOREIGN KEY ( person_id ) REFERENCES datw.person_datw ( person_id )
);

-- deleting rows
truncate table datw.geo_datw;

-- inserting
insert into datw.geo_datw
select row_number() over(), country, city, state, postal_code, person_id
from 
(
 select distinct country, city, state, postal_code, region
 from stg.orders 
) a
join datw.person_datw using(region);

-- cheking 1
select distinct country, city, state, postal_code from datw.geo_datw
where country is null or city is null or postal_code is null;
-- cheking 2
select * from datw.geo_datw gd;




-- City Burlington, Vermont doesn't have postal code
-- Исправления из примера
update datw.geo_datw
set postal_code = '05401'
where city = 'Burlington'  and postal_code is null;

--also update source file
update stg.orders
set postal_code = '05401'
where city = 'Burlington'  and postal_code is null;

-- cheking
select * from datw.geo_datw
where city = 'Burlington';




-- PRODUCT

-- creating a table
drop table if exists datw.product_datw;
create table datw.product_datw
(
 prod_id      serial NOT NULL,
 product_id   varchar(50) NOT NULL,
 product_name varchar(127) NOT NULL,
 category     varchar(15) NOT NULL,
 subcategory varchar(11) NOT NULL,
 CONSTRAINT PK_product_datw PRIMARY KEY ( prod_id )
);

-- deleting rows
truncate table datw.product_datw;

-- inserting 
insert into datw.product_datw
select row_number() over(), product_id, product_name, category, subcategory
from
(
 select distinct product_id, product_name, category, subcategory
 from stg.orders 
) a;

-- cheking
select * from datw.product_datw;




-- SHIPPING MOD

-- creating a table
drop table if exists datw.shipping_datw;
create table datw.shipping_datw
(
 ship_id       serial NOT NULL,
 ship_mode varchar(14) NOT NULL,
 CONSTRAINT PK_shipping_datw PRIMARY KEY ( ship_id )
);

-- deleting rows
truncate table datw.shipping_datw;

-- inserting
insert into datw.shipping_datw
select row_number() over(), ship_mode
from
(
 select distinct ship_mode 
 from stg.orders 
) a;

-- cheking
select * from datw.shipping_datw;




-- SALES FACT

-- creating a table
drop table if exists datw.sales_fact_datw;
create table datw.sales_fact_datw
(
 sales_id   serial NOT NULL,
 cust_id    int NOT NULL,
 geo_id     int NOT NULL,
 prod_id    int NOT NULL,
 ship_id    int NOT NULL,
 order_id   varchar(25) NOT NULL,
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 sales      numeric(9,4) NOT NULL,
 profit     numeric(21,16) NOT NULL,
 quantity   int NOT NULL,
 discount   numeric(4,2) NOT NULL,
 returned   varchar(10) NOT NULL,
 CONSTRAINT PK_sales_fact_datw PRIMARY KEY ( sales_id ),
 CONSTRAINT FK_customer_datw FOREIGN KEY ( cust_id ) REFERENCES datw.customer_datw ( cust_id ),
 CONSTRAINT FK_shipping_datw FOREIGN KEY ( ship_id ) REFERENCES datw.shipping_datw ( ship_id ),
 CONSTRAINT FK_product_datw FOREIGN KEY ( prod_id ) REFERENCES datw.product_datw ( prod_id ),
 CONSTRAINT FK_geo_datw FOREIGN KEY ( geo_id ) REFERENCES datw.geo_datw ( geo_id )
);

-- deleting rows
truncate table datw.sales_fact_datw;

-- inserting
insert into datw.sales_fact_datw
with retur as
	(
	select distinct returned, order_id
	from stg."returns" 
	)
select 
	row_number() over()
	, cust_id
	, geo_id
	, prod_id
	, ship_id
	, order_id
	, order_date
	, ship_date
	, sales
	, profit
	, quantity
	, discount
	, coalesce (returned, 'No')
from 
	stg.orders o
	join datw.customer_datw USING(customer_id, customer_name, segment)
	join datw.geo_datw gd USING(country, city, state, postal_code)
	join datw.product_datw USING(product_id, product_name, category, subcategory)
	join datw.shipping_datw USING(ship_mode)
	left join retur using(order_id);

-- cheking
select * from datw.sales_fact_datw;


-------------------
--do you get 9994rows?
select count(*) from datw.sales_fact_datw sf
inner join datw.shipping_datw s on sf.ship_id=s.ship_id
inner join datw.geo_datw g on sf.geo_id=g.geo_id
inner join datw.product_datw p on sf.prod_id=p.prod_id
inner join datw.customer_datw cd on sf.cust_id=cd.cust_id;

