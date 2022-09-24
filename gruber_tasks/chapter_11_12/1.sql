alter session set current_schema = AMINJON;

-- Напишите команду SELECT использующую соотнесенный подзапрос,  кото-
--    рая  выберет  имена и номера всех заказчиков с максимальными для их
--    городов рейтингами.


select c1.*
from CUSTOMERS c1
where (c1.CITY, c1.RATING) in (select c2.CITY, max(c2.RATING)
                               from CUSTOMERS c2
                               group by c2.CITY);