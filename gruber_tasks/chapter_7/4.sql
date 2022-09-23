alter session set current_schema = AMINJON;

-- Напишите запрос к таблице Продавцов, который мог  бы
--   найти  наименьшие комиссионные в каждом городе.
--   Вывод должен быть в такой форме:
--   В городе <Наименование> наименьшие комиссионные <Значение>. */


select 'В городе ' || CITY || ', наименьшие комиссионные ' || min(COMM) * 100 || '%.' as info
from SALESPEOPLE
group by CITY;