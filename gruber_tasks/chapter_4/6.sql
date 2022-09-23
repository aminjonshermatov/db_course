alter session set current_schema = AMINJON;

-- Напишите запрос к таблице Продавцов, который дает всех Продавцов за исключением Продавцов из города London, имеющих комиссионные выше 0.11.

select * from SALESPEOPLE
where lower(CITY) != lower('London') and SALESPEOPLE.COMM > .11;