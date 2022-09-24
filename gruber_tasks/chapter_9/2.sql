alter session set current_schema = AMINJON;

-- Напишите запрос, который бы вывел все пары имен заказчиков,
--  которым назначен один и тот же обслуживающий продавец,
--  номер продавца тоже включите в выходную строку.
--  Исключите пары вида (А,А) и повторы вида (А,Б), (Б,А).


select distinct least(c1.CNUM, c2.CNUM) as A, greatest(c1.CNUM, c2.CNUM) as B, c1.SNUM
from CUSTOMERS c1
inner join CUSTOMERS c2 on c1.CNUM != c2.CNUM and c1.SNUM = c2.SNUM;