alter session set current_schema = AMINJON;

-- Напишите  запрос,  который вывел бы значения cnum
--  всех заказчиков из таблицы Заказов без каких бы то ни было
--  повторений.


select distinct CNUM
from ORDERS;