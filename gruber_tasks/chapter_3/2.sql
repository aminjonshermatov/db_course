alter session set current_schema = AMINJON;

-- Напишите команду SELECT, которая бы вывела номер Заказчика, город и рейтинг для всех строк из таблицы Заказчиков.

SELECT cnum as customer_number, city as customer_city, rating
FROM customers;
