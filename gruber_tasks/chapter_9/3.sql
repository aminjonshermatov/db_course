alter session set current_schema = AMINJON;

-- Напишите запрос который вывел бы все пары заказов
--  по данным заказчикам,  именам этих заказчиков,
--   и исключал дубликаты из вывода, как в предыдущем вопросе.


with orders_ as (select distinct least(o1.ONUM, o2.ONUM) as A, greatest(o1.ONUM, o2.ONUM) as B, o1.CNUM as c_num
                 from ORDERS o1
                          inner join ORDERS o2 on o1.ONUM != o2.ONUM and o1.CNUM = o2.CNUM)
select orders_.A, orders_.B, c.CNUM, c.CNAME
from CUSTOMERS c
         right join orders_ on c.CNUM = orders_.c_num;