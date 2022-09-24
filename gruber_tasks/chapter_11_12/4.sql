alter session set current_schema = AMINJON;

-- Напишите запрос который бы использовал оператор EXISTS для извлече-
--    ния всех продавцов которые имеют заказчиков с оценкой 300.


select s.*
from SALESPEOPLE s
where exists(select *
             from CUSTOMERS c
             where c.SNUM = s.SNUM
               and c.RATING = 300);