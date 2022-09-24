alter session set current_schema = AMINJON;

-- Напишите запрос который бы выбрал общую сумму всех  приобретений  в
--    заказах  для  каждого продавца,  у которого эта общая сумма больше
--    чем наибольшая стоимость заказов в таблице.


select o.SNUM, sum(o.AMT) as sum_
from ORDERS o
group by o.SNUM
having sum(o.AMT) > (select max(o2.AMT) from ORDERS o2);