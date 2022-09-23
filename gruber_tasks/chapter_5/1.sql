alter session set current_schema = AMINJON;

-- Напишите  два запроса которые могли бы вывести все заказы  на 3 или 4 Октября 2015


select *
from ORDERS
where ODATE between to_date('3/10/2015', 'DD/MM/YYYY') and to_date('4/10/2015', 'DD/MM/YYYY');

select *
from ORDERS
where ODATE = to_date('3/10/2015', 'DD/MM/YYYY')
union
select *
from ORDERS
where ODATE = to_date('4/10/2015', 'DD/MM/YYYY');