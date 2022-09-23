alter session set current_schema = AMINJON;

-- Напишите запрос который выбрал бы высшую оценку в каждом городе.


select CITY, max(RATING)
from CUSTOMERS
group by CITY;