alter session set current_schema = AMINJON;

-- Напишите запрос который вывел бы таблицу Продавцов
--  со столбцами в следующем порядке: city, sname, snum, comm.


select CITY, SNAME, SNUM, COMM
from SALESPEOPLE;