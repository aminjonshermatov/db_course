alter session set current_schema = AMINJON;

-- Напишите запрос, который дает все заказы на 3 и 6 Октября 2015.


select *
from ORDERS
where ODATE in (to_date('3/10/2015', 'DD/MM/YYYY'), to_date('6/10/2015', 'DD/MM/YYYY'));