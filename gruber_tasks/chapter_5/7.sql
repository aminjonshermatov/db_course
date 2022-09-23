alter session set current_schema = AMINJON;

-- Напишите запрос который выберет всех покупателей чьи имена  начинаются с буквы C.


select *
from CUSTOMERS
where substr(CNAME, 1, 1) between 'C' and 'Z';