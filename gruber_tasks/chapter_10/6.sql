alter session set current_schema = AMINJON;

-- Напишите запрос, который бы выбрал количество заказов для каждого покупателя,
--    у которого минимальная стоимость заказов больше средней стоимости по всем заказам.


select o.CNUM, count(*)
from ORDERS o
group by o.CNUM
having min(o.AMT) > (select avg(o2.AMT) from ORDERS o2);