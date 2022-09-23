alter session set current_schema = AMINJON;

-- Напишите запрос к таблице Заказчиков который мог  бы
--  найти  высшую оценку в каждом городе.
--  Вывод должен быть в такой форме:
--          For the city (city), the highest rating is: (rating). */


select 'For the city ' || CITY || ', the highest rating is: ' || max(RATING) || '.' as info
from CUSTOMERS
group by CITY;