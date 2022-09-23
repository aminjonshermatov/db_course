alter session set current_schema = AMINJON;

-- Напишите запрос, который дает всех заказчиков с рейтингом выше чем 150.

select * from CUSTOMERS
where RATING > 150;