alter session set current_schema = AMINJON;

-- Напишите запрос, который выберет всех продавцов, чьи имена  заканчиваются на букву s.


select *
from SALESPEOPLE
where substr(SNAME, LENGTH(SNAME), 1) = 's';