alter session set current_schema = AMINJON;

-- Напишите запрос, который сосчитал бы для каждого дня
--  количество заказчиков, сделавших заказ в этот день.
--  (Если заказчик сделал более одного заказа в данный день,
--   он должен учитываться только один раз.)


select O.ODATE, count(distinct (select C.CNUM from CUSTOMERS C where C.CNUM = O.CNUM))
from ORDERS O
group by O.ODATE;