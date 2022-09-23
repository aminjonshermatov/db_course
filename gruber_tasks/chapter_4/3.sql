alter session set current_schema = AMINJON;

-- Напишите запрос который может выдать вам поля sname и city для всех продавцов в Лондоне с комиссионными выше .10 .

select * from SALESPEOPLE
where lower(CITY) = lower('London') and COMM > .1;