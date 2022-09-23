alter session set current_schema = AMINJON;

-- Напишите запрос, который отбирает заказы заказчиков
--  из Лондона и выводит:
--          номер заказа и сумму (заказа + комиссионных).


select O.ONUM, O.AMT * (1 + S.COMM) as amount
from ORDERS O
    left join CUSTOMERS C on O.CNUM = C.CNUM
    left join SALESPEOPLE S on O.SNUM = S.SNUM
where lower(C.CITY) = lower('London');