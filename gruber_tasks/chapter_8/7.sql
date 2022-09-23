alter session set current_schema = AMINJON;

-- Напишите запрос который вычислил бы сумму комиссионных
--  продавца для каждого заказа заказчика с рейтингом выше 100.


select S.SNAME, S.SNUM, O.AMT * S.COMM as commission
from ORDERS O
         left join SALESPEOPLE S on O.SNUM = S.SNUM
         left join CUSTOMERS C on O.CNUM = C.CNUM
where C.RATING > 100;