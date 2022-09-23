alter session set current_schema = AMINJON;

-- Напишите запрос, который сосчитал бы общую сумму заказов покупателя 2004.


select sum(AMT) as amount
from ORDERS
where CNUM = 2004;