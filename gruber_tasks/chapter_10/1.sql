alter session set current_schema = AMINJON;

-- Напишите  запрос,  который  бы  использовал подзапрос для получения
--    всех заказов заказчика с именем Cisneros.  Предположим, что вы
--    не знаете номера этого заказчика, указываемого в поле cnum.


select *
from ORDERS o
where o.CNUM = (select CUSTOMERS.CNUM from CUSTOMERS where CNAME = 'Cisneros');