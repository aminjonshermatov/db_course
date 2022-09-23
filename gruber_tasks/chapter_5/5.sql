alter session set current_schema = AMINJON;

-- Напишите запрос,  который может вывести всех заказчиков чьи  имена начинаются с буквы попадающей в диапазон от A до G.


select *
from CUSTOMERS
where substr(CNAME, 1, 1) between 'A' and 'G';