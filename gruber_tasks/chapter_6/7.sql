alter session set current_schema = AMINJON;

-- Напишите запрос который бы выбирал заказчиков в алфавитном порядке, чьи имена начинаются с буквы G.


select *
from CUSTOMERS
where substr(CNAME, 1, 1) between 'G' and 'Z'
order by CNAME;