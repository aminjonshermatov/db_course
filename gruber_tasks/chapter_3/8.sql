alter session set current_schema = AMINJON;

-- Напишите команду SELECT которая вывела бы имя и
--  комиссионные каждого продавца из города London.


select SNAME, COMM
from SALESPEOPLE
where lower(CITY) = lower('London');