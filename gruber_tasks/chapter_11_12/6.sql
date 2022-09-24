alter session set current_schema = AMINJON;

-- Напишите  запрос  который извлекал бы из таблицы Заказчиков каждого
--    заказчика назначенного к продавцу который в данный момент имеет  по
--    крайней мере еще одного заказчика ( кроме заказчика которого вы вы-
--    берете ) с заказами в таблице Заказов


select *
from CUSTOMERS c
where exists(select *
             from ORDERS o
             where o.CNUM != c.CNUM
               and c.SNUM = o.SNUM);