alter session set current_schema = AMINJON;

-- Напишите  запрос,  который вывел бы имена (sname)
--  и города(city) всех продавцов с комиссионными больше,
--  чем у Peel. Напишите запрос, использующий номер продавца Peel
--  (равный 1001), а не его комиссионные,
--  так чтобы этот запрос можно было использовать даже,
--  если этот процент комиссионных вдруг изменится.


with selected_peel as (select COMM from SALESPEOPLE where SNUM = 1001)
select s.SNAME, s.CITY
from SALESPEOPLE s, selected_peel peel
where s.COMM > peel.COMM;