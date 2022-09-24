alter session set current_schema = AMINJON;

-- Напишите запрос который вывел бы имена и рейтинги тех заказчиков,
-- 	у которых есть заказы на сумму выше средней суммы по всем заказам.


with more_avg_orders as (select * from ORDERS o where o.AMT > (select avg(AMT) from ORDERS))
select c.CNUM, c.RATING
from CUSTOMERS c
         right join more_avg_orders avg_o on avg_o.CNUM = c.CNUM;