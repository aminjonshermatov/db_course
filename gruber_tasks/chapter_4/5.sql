alter session set current_schema = AMINJON;

-- Напишите запрос к таблице Заказчиков чей вывод может включить  всех заказчиков с оценкой =< 100, если они не находятся в Риме.

select * from CUSTOMERS
where lower(CITY) != lower('Rome') and RATING <= 150;