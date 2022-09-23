alter session set current_schema = AMINJON;

-- Напишите  запрос  который  бы выводил всех заказчиков
--  обслуживаемых продавцом с комиссионными выше 12%  .
--    Выведите имя заказчика,  имя продавца,
--     и ставку комиссионных продавца.


select C.CNAME, S.SNAME, S.COMM * O.AMT as commission
from ORDERS O
         left join SALESPEOPLE S on O.SNUM = S.SNUM
         left join CUSTOMERS C on O.CNUM = C.CNUM
where S.COMM > .12;