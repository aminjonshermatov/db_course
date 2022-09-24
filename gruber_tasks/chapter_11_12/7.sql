alter session set current_schema = AMINJON;

-- Напишите  запрос  который извлекал бы из таблицы Заказов такие заказы,
-- 	заказчики которых имеются по крайней мере еще один заказ.


select *
from ORDERS o1
where exists(select *
             from ORDERS o2
             where o1.SNUM = o2.SNUM
               and o1.ONUM != o2.ONUM);