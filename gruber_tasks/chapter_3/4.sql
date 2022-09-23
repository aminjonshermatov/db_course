alter session set current_schema = AMINJON;

-- Напишите запрос, который вывел бы все строки из таблицы Заказов, для которых номер продавца = 1001.
select * from ORDERS
where SNUM = 1001;