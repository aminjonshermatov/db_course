alter session set current_schema = AMINJON;

-- Напишите запрос, который выбрал бы наименьшую сумму заказа для каждого дня.


select ODATE, min(AMT) as min_amount
from ORDERS
group by ODATE;