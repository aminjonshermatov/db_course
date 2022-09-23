alter session set current_schema = AMINJON;

-- Напишите  запрос который выберет всех заказчиков обслуживаемых продавцами Peel или Motika.


select *
from CUSTOMERS
where SNUM in (select SNUM from SALESPEOPLE where SNAME in ('Peel', 'Motika'));

select *
from CUSTOMERS c
         inner join SALESPEOPLE s on c.SNUM = s.SNUM and s.SNAME in ('Peel', 'Motika');