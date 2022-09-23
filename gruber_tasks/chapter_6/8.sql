alter session set current_schema = AMINJON;

-- Напишите запрос, который бы выбрал первого в алфавитном порядке Продавца среди тех, чьи имена начинаются с букв от M до R.


select *
from CUSTOMERS
where substr(CNAME, 1, 1) between 'M' and 'R'
order by CNAME
fetch first 1 rows only;