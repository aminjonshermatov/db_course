alter session set current_schema = AMINJON;

-- Напишите  запрос  который выбрал бы наименьшую сумму для каждого заказчика.


select c.*, (select min(o.AMT) from ORDERS o where c.CNUM = o.CNUM) as min_order_amount
from CUSTOMERS c;