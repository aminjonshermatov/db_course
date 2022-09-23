alter session set current_schema = AMINJON;

-- Напишите  запрос,  который бы выдавал для каждого заказа:
--  номер заказа и имена продавца и заказчика.


select O.ONUM, S.SNAME, C.CNAME
from ORDERS O
    left join SALESPEOPLE S on O.SNUM = S.SNUM
    left join CUSTOMERS C on O.CNUM = C.CNUM;