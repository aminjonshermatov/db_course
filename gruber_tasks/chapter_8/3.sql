alter session set current_schema = AMINJON;

-- Напишите  запрос  который бы выдавал имена продавца
--  и заказчика для каждого заказа после номера заказа.


select S.SNAME, C.CNAME, O.ONUM
from CUSTOMERS C
    left join SALESPEOPLE S on C.SNUM = S.SNUM
    left join ORDERS O on C.CNUM = O.CNUM;