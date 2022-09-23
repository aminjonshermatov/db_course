alter session set current_schema = AMINJON;

-- Напишите запрос, который сосчитал бы для каждого дня
--  количество продавцов, сделавших заказ в этот день. (Если продавец имел
--  более одного заказа в данный день, он должен учитываться только
--  один раз.)


select O.ODATE, count(distinct (select S.SNUM from SALESPEOPLE S where S.SNUM = O.SNUM))
from ORDERS O
group by O.ODATE;