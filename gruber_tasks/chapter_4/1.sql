alter session set current_schema = AMINJON;

-- Напишите запрос который может дать вам все  заказы со  значениями суммы заказа выше чем 1,000.

select * from ORDERS
where AMT > 1000;