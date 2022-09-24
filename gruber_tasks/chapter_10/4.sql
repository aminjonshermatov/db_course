alter session set current_schema = AMINJON;

-- Напишите запрос который вывел бы имена и комиссионные тех продавцов,
-- 	которые обслуживают хотя бы одного заказчика с рейтингом выше среднего.


select s.SNAME, s.COMM
from SALESPEOPLE s
where exists (select * from CUSTOMERS c where c.RATING > (select avg(c2.RATING) from CUSTOMERS c2));