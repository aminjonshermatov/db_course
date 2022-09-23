alter session set current_schema = AMINJON;

-- Напишите  запрос который бы вывел список номеров заказов
--  сопровождающихся именем заказчика который создавал их.


select O.ONUM, C.CNAME
from ORDERS O
         left join CUSTOMERS C on O.CNUM = C.CNUM;