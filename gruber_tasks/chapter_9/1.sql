alter session set current_schema = AMINJON;

-- Напишите запрос который бы вывел все пары продавцов
--  живущих в одном и том же городе.  Исключите комбинации
--   продавцов с ними же, а также дубликаты строк выводимых
--    в обратным порядке.


select distinct least(s1.SNUM, s2.SNUM) as A, greatest(s1.SNUM, s2.SNUM) as B
from SALESPEOPLE s1
inner join SALESPEOPLE s2 on s1.SNUM != s2.SNUM and s1.CITY = s2.CITY;