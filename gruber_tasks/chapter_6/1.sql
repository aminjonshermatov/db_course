alter session set current_schema = AMINJON;

-- Напишите запрос который сосчитал бы все суммы приобретений на 3 Октября.


select sum(AMT) as amount
from ORDERS
where ODATE = to_date('3/10/2015', 'DD/MM/YYYY');