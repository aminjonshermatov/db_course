alter session set current_schema = AMINJON;

-- Напишите  запрос который сосчитал бы число различных значений поля city в таблице Заказчиков.


select count(*) as count
from (select distinct CITY from CUSTOMERS);