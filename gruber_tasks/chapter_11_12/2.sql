alter session set current_schema = AMINJON;

-- Напишите запрос который выберет всех продавцов (их имя и
--    номер) которые в своих городах имеют заказчиков  которых  они  не
--    обслуживают.


select *
from SALESPEOPLE s
where exists (select *
              from CUSTOMERS c
              where c.CITY = s.CITY and c.SNUM != s.SNUM);