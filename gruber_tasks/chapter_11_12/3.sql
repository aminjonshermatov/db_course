alter session set current_schema = AMINJON;

-- Найти заказчиков, не все заказы которых исполняют продавцы,
--    назначенные им для обслуживания.



select c.*
from CUSTOMERS c
where exists (select *
       from ORDERS o
       where o.CNUM = c.CNUM and c.SNUM != o.SNUM);