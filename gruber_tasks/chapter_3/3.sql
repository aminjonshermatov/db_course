alter session set current_schema = AMINJON;

-- Напишите запрос который вывел бы все строки из таблицы Заказчиков для которых номер продавца = 1001.

SELECT cnum as customer_number, city as customer_city, rating
FROM customers
WHERE snum = 1001;
