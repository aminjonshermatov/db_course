alter session set current_schema = AMINJON;

-- Напишите запрос который бы использовал оператор EXISTS для извлече-
--    ния всех заказчиков, которые имеют заказы стоимостью > 4000.


select c.*
from CUSTOMERS c
where exists(select *
             from ORDERS o
             where o.CNUM = c.CNUM
               and o.AMT > 4000);