alter session set current_schema = AMINJON;

-- Напишите команду SELECT которая бы вывела номера заказов, сумму, и дату для всех строк из таблицы Заказов.

SELECT onum as order_number, amt as amount, odate as order_date
FROM orders;
