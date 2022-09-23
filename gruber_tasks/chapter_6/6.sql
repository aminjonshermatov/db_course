alter session set current_schema = AMINJON;

-- Напишите  запрос,  который выбрал бы наибольшую дату заказа для каждого заказчика.


select c.*, (select max(o.ODATE) from ORDERS o where c.CNUM = o.CNUM) as nearest_date
from CUSTOMERS c;