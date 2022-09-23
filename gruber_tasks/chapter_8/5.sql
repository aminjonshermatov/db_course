alter session set current_schema = AMINJON;

-- Напишите  запрос  который  бы выводил всех заказчиков
--  обслуживаемых продавцом с комиссионными выше 12%  .
--    Выведите имя заказчика,  имя продавца,
--     и ставку комиссионных продавца.


select C.CNAME, S.SNAME, S.COMM
from CUSTOMERS C
         left join SALESPEOPLE S on C.SNUM = S.SNUM
where S.COMM > .12;