alter session set current_schema = AMINJON;

-- Напишите запрос, который может выдать вам поля cname и city для всех заказчиков из города San Jose с рейтингом выше 150.

select * from CUSTOMERS
where lower(CITY) = lower('San Jose') and RATING > 150;