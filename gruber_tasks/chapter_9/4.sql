alter session set current_schema = AMINJON;

-- Напишите запрос, который бы вывел все пары имен заказчиков,
--  которые что-либо заказывали в один и тот же день,
--  дату такого дня тоже включите в выходную строку.
--  Также как и в предыдущем упражнении исключите вырожденные пары.


with orders_ as (select distinct least(o1.CNUM, o2.CNUM)    as A,
                                 greatest(o1.CNUM, o2.CNUM) as B,
                                 o1.ODATE                   as o_date
                 from ORDERS o1
                          inner join ORDERS o2 on o1.CNUM != o2.CNUM and o1.ODATE = o2.ODATE)
select (select CNAME from CUSTOMERS where CNUM = o.A) as c1_name,
       (select CNAME from CUSTOMERS where CNUM = o.B) as c2_name,
       o.o_date
from orders_ o;