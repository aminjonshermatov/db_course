alter session set current_schema = AMINJON;

-- Напишите  запрос  который выводил бы список заказчиков
--  в нисходящем порядке рейтингов.  Вывод поля оценки ( rating )
--  должден сопровождаться именем заказчика и его номером.


select CNAME, CNUM, RATING
from CUSTOMERS
order by RATING desc;