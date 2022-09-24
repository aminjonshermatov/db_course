alter session set current_schema = AMINJON;

-- Напишите  запрос,  который  бы  использовал подзапрос для получения
--    всех заказчиков, которых обслуживают  продавцы из города London.


with s_london as (select * from SALESPEOPLE s where lower(s.CITY) = lower('London'))
select c.*, sl.*
from CUSTOMERS c
         right join s_london sl on sl.SNUM = c.SNUM;