alter session set current_schema = AMINJON;

-- Напишите  запрос  который вывел бы значения snum
--  всех продавцов в текущем порядке из таблицы Заказов
--  без каких бы то ни было  повторений.


select distinct SNUM
from ORDERS;