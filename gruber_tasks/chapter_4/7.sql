alter session set current_schema = AMINJON;

-- Напишите запрос к таблице Продавцов, который дает всех Продавцов таких что, если он из города London, то его комиссионные не выше 0.11, а иначе - выше 0.13.

select *
from SALESPEOPLE
where (lower(CITY) = lower('London') and COMM <= .11)
   or COMM > .13;