-- Динамика дохода и прибыли
select 
	to_char(date (order_date), 'YYYY') as Год
	, to_char(date (order_date), 'Month') as Месяц
	, sum(sales) as Продажи
	, sum(profit) as Прибыль
from orders o
group by 1, 2
order by 1, 2;

-- Категории товаров (сравнение)
select 
	category as Категория
	, round(sum(sales), 2) as Продажи
	, round(sum(profit), 2) as Прибыль
from orders o 
group by category 
order by sum(sales);

-- Региональные менеджеры (срравнение)
select 
	person as Менеджер
	, round(sum(sales), 2) as Продажи
	, round(sum(profit), 2) as Прибыль
from 
	orders o join
	people p using (region)
group by person
order by sum(sales) ;

-- Сегменты (сравнение)
select 
	segment as Сегмент
	, round(sum(sales), 2) as Продажи
	, round(sum(profit), 2) as Прибыль
from orders
group by segment 
order by sum(sales);

-- Динамика по сегментам
select 
	segment as Сегмент
	, to_char(date(order_date), 'YYYY') as Год 
	, round(sum(sales), 2) as Продажи
	, round(sum(profit), 2) as Прибыль
from orders o 
group by 1, 2
order by 1, 2;

-- Основные показатели ??
select
	to_char(date(order_date), 'YYYY') as Год 
	, to_char(date(order_date), 'MM') as Месяц
	, round(sum(sales), 2) as Продажи
	, round(sum(profit), 2) as Прибыль
from orders o 
group by 1, 2
order by 1, to_char(date(order_date), 'MM');

-- По штатам
select 
	state as Штат
	, round(sum(sales), 0) as Продажи
	, round(sum(profit), 0) as Прибыль
from orders
group by state
order by state;

-- По регионам
select 
	region as Регион
	, round(sum(sales) / (select sum(sales) from orders)  * 100, 0) as "Продажи_%"
from orders o 
group by 1
order by 1;

-- По возвратам в %
with returns_orders 
  as (
     select 
	   order_id
	   , case 
	 	   when order_id in (select distinct order_id from "returns") then 'yes'
	 	  else 'no'
	   end as ret 
     from orders
  )
select 
	  ret as Возврат_товара
	  , count (ret) as Количество
	  , (select count (order_id) from orders) as Всего_товаров
	  , round((round(count (ret), 2) / (select count (order_id) from orders) * 100), 3) as Процент_возврата
    from returns_orders
    group by ret
    order by 2 desc;


select 28 / 11.1








