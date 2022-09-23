alter session set current_schema = AMINJON;

-- Напишите запрос который бы выводил общую сумму заказов
-- на каждый  день  и помещал результаты в нисходящем порядке.


select ODATE, sum(AMT) as amout
from ORDERS
group by ODATE
order by amout;