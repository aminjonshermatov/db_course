alter session set current_schema = AMINJON;

-- Напишите команду SELECT которая вывела бы оценку(rating),
--   сопровождаемую именем каждого заказчика в San Jose.


select CNAME, RATING
from CUSTOMERS
where lower(CITY) = lower('San Jose');