alter session set current_schema = AMINJON;

-- Напишите  запрос, который бы вывел список имен заказчиков,
--  сопровождающихся именем продавца, который назначен их обслуживать.


select C.CNAME, S.SNAME
from CUSTOMERS C
    left join SALESPEOPLE S on C.SNUM = S.SNUM