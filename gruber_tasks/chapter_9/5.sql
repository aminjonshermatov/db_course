alter session set current_schema = AMINJON;

-- Напишите  запрос  который вывел бы имена(cname)
--  и города(city) всех заказчиков с такой же оценкой(rating)
--  как у Hoffmanа. Напишите запрос использующий поле cnum
--  Hoffmanа а не его оценку,  так чтобы оно могло быть
--  использовано если его оценка вдруг изменится.


with selected_hoffman as (select RATING from CUSTOMERS where CNAME = 'Hoffman')
select c.CNAME, c.CITY
from CUSTOMERS c, selected_hoffman hf
where c.RATING = hf.RATING;