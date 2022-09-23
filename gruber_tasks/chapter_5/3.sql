alter session set current_schema = AMINJON;

-- Напишите запрос, который дает все заказы, выполняемые продавцами 1001, 1003, 1007.


select *
from ORDERS
where SNUM in (1001, 1003, 1007);