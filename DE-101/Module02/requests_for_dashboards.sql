-- Динамика дохода и прибыли
-- Sales and profit by time
select 
	to_char(order_date, 'YYYY') as year
	, to_char(order_date, 'MM') as month
	, round(sum(sales), 0) as sales
	, round(sum(profit), 0) as profit
from datw.sales_fact_datw sfd 
group by 1, 2 
order by 1, 2;
	



-- Категории товаров (сравнение)
-- Sales and profit category
select 
	coalesce (category, 'Total') as category
	, round(sum(sales), 0) as sales
	, round(sum(profit), 0) as profit
from 
	datw.sales_fact_datw sfd 
	left join datw.product_datw pd using(prod_id)
group by rollup (category)
order by category;




-- Региональные менеджеры (сравнение)
-- Sales by manager
select 
	coalesce (person, 'Total') as person
	, round(sum(sales), 0) as Продажи
	, round(sum(profit), 0) as Прибыль
from 
	datw.sales_fact_datw sfd
	left join datw.geo_datw gd using(geo_id)
	left join datw.person_datw pd using(person_id)
group by rollup (person)
order by person;




-- Сегменты (сравнение)
-- Sales and profit by segment
select 
	coalesce (segment, 'Total') as segment
	, round(sum(sales), 0) as sales
	, round(sum(profit), 0) as profit
from 
	datw.sales_fact_datw sfd 
	left join datw.customer_datw cd using(cust_id)
group by rollup (segment)
order by segment;




-- Динамика по сегментам
-- Sales by segment
select 
	coalesce (segment, 'Total') as segment
	, round(sum(case when to_char(order_date, 'YYYY') = '2016' then sales else 0 end), 0) as "2016"
	, round(sum(case when to_char(order_date, 'YYYY') = '2017' then sales else 0 end), 0) as "2017"
	, round(sum(case when to_char(order_date, 'YYYY') = '2018' then sales else 0 end), 0) as "2018"
	, round(sum(case when to_char(order_date, 'YYYY') = '2019' then sales else 0 end), 0) as "2019"
from 
	datw.sales_fact_datw sfd 
	left join datw.customer_datw cd using(cust_id)
group by rollup(segment)
order by segment;




-- Основные показатели
-- Key metric
select 
	coalesce (to_char(order_date, 'YYYY'), 'Total') as year
	, round(sum(sales), 0) as sales 
	, round(sum(profit), 0) as profit
	, round(sum(profit) / sum(sales), 2) as profit_ratio
	, round(avg(discount), 2) as avg_discount
from datw.sales_fact_datw sfd 
group by rollup(to_char(order_date, 'YYYY'))
order by to_char(order_date, 'YYYY');




-- По штатам
-- Sales by state
select 
	coalesce (state, 'Total') as state
	, round(sum(sales), 0) as sales
from 
	datw.sales_fact_datw sfd 
	left join datw.geo_datw gd using(geo_id)
group by state
order by state;




-- По регионам
-- Sales by region 
with s_s as
	(select sum(sales) as sum_sales from datw.sales_fact_datw sfd)
select 
	coalesce (region, 'Total') as region 
	, round(sum(sales) / sum_sales * 100, 1) as "Продажи_%"
from s_s, 
	datw.sales_fact_datw
	left join datw.geo_datw using(geo_id)
	left join datw.person_datw pd using(person_id)
group by rollup (region), sum_sales;




-- По возвратам в %
-- sales by returns
with num_of_row as 
	(select count(*) as count_row from datw.sales_fact_datw)
select returned, round(round(count(returned), 0) / count_row * 100, 2)
from datw.sales_fact_datw, num_of_row
group by returned, count_row
order by 2;






