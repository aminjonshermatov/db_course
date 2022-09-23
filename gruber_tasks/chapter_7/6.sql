alter session set current_schema = AMINJON;

-- Напишите  запрос,  который выводил бы список продавцов
--  в нисходящем порядке комиссионных.  Вывод поля комиссионные
--  (Comm) должен сопровождаться именем продавца и его номером.


select SNAME, SNUM, COMM
from SALESPEOPLE
order by COMM desc;