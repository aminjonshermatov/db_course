alter session set current_schema = AMINJON;

-- Напишите запрос, который бы выводил общую сумму заказов
--  для каждого заказчика, и помещал результаты
--  в нисходящем порядке (по сумме).


select C.CNAME, SUM(O.AMT) as amount
from CUSTOMERS C
         left join ORDERS O on C.CNUM = O.CNUM
group by C.CNAME
order by amount desc;