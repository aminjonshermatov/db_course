alter session set current_schema = AMINJON;

-- Напишите запрос, который вывел бы таблицу Заказчиков
--  со столбцами в порядке: city, snum, cname, cnum, rating.


select CITY, SNUM, CNAME, RATING
from CUSTOMERS;