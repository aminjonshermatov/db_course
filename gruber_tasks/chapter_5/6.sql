alter session set current_schema = AMINJON;

-- Напишите запрос, который может вывести всех продавцов, чьи  имена начинаются с буквы попадающей в диапазон от M до R.


select *
from SALESPEOPLE
where substr(SNAME, 1, 1) between 'M' and 'R';