/*
07а:Профессии <–>> 05:Нормы затрат труда <<–> 06:Тарифы.

    • Задача-1. Сведения о затратах труда в номер операции: код детали; номер участка; номер операции; код профессии; часовая тарифная ставка.
    • Задача-2. Для каждой детали: код детали; стоимость подготовительно-заключительных работ; стоимость на штуку (суммарно по всем операциям).
    • Задача-3. Все профессии, такие что:
для каждого кода работ (из 06)
имеется деталь в сборке которой рабочий такой профессии выполняет такую работу.
*/

drop sequence details_id_seq;
drop sequence price_guide_seq;
drop sequence profession_id_seq;
drop sequence labor_cost_standards_id_seq;

drop table labor_cost_standards;
drop table price_guide;
drop table details;
drop table professions;

create sequence details_id_seq start with 1;
create table details (
    detail_id int default details_id_seq.nextval,
    type varchar(9) not null check ( type in ('PURCHASED', 'IN_HOUSE') ),
    name varchar(100) not null,
    measure_unit varchar(10) default 'шт',
    price decimal(13, 2) not null check ( price > 0 ),

    constraint detail_id_pk primary key (detail_id)
);

create sequence profession_id_seq start with 1;
create table professions (
    profession_id int default profession_id_seq.nextval,
    name varchar(100) not null,

    constraint profession_id_pk primary key (profession_id)
);


create sequence price_guide_seq start with 1;
create table price_guide (
    price_guide_id int default price_guide_seq.nextval,
    hourly_rate int not null check ( hourly_rate > 0 ),

    constraint price_guide_id_pk primary key (price_guide_id)
);

-- нормы затрат труда
create sequence labor_cost_standards_id_seq start with 1;
create table labor_cost_standards (
    detail_id int not null,
    operation_id int default labor_cost_standards_id_seq.nextval,
    profession_id int not null,
    qualification int not null,
    price_guide_id int not null,
    preparatory_time int not null check ( preparatory_time >= 0 ),
    piece_time int not null check ( piece_time >= 0 ),

    constraint operation_id_pk primary key (operation_id),
    constraint detail_id_fk foreign key (detail_id) references details(detail_id) on delete cascade,
    constraint profession_labor_id_fk foreign key (profession_id) references professions(profession_id) on delete cascade,
    constraint price_guide_id_fk foreign key (price_guide_id) references price_guide(price_guide_id) on delete cascade
);

create or replace procedure seed_data(n int) as
    begin
        insert into professions (name) values ('Дизайнер');
        insert into professions (name) values ('Конструктор');
        insert into professions (name) values ('Столяр');
        insert into professions (name) values ('Маляр');
        insert into professions (name) values ('Сборщик мебели');

        insert into price_guide (hourly_rate) values (11);
        insert into price_guide (hourly_rate) values (12);
        insert into price_guide (hourly_rate) values (13);
        insert into price_guide (hourly_rate) values (14);
        insert into price_guide (hourly_rate) values (15);

        insert into details ("TYPE", name, measure_unit, price) values ('PURCHASED', 'ЛДСП', 'м.кв', 40); -- 40$
        insert into details ("TYPE", name, measure_unit, price) values ('PURCHASED', 'Кромка', 'м', 3); -- 3$
        insert into details ("TYPE", name, measure_unit, price) values ('PURCHASED', 'Лак', 'л', 2);
        insert into details ("TYPE", name, measure_unit, price) values ('PURCHASED', 'ДВП', 'м.кв.', 5);
        insert into details ("TYPE", name, measure_unit, price) values ('IN_HOUSE', 'Матрас', 'м.кб.', 20);

        select * from details;

        insert into labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time)
            values (1, 2, 8, 2, 2, 2);
        insert into labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time)
            values (2, 3, 5, 1, 1, 1);
        insert into labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time)
            values (3, 4, 6, 3, 2, 2);
        insert into labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time)
            values (4, 3, 5, 4, 3, 2);
        insert into labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time, piece_time)
            values (5, 5, 3, 5, 4, 4);

    end;

begin
    seed_data(5);
end;

create or replace function most_expensive_detail return int is most_exp int;
    begin
        select price
        into most_exp
        from details;
        return (most_exp);
    end;

create or replace package details as

    TYPE measure_record IS RECORD( operation_id int, detail_id int);

    TYPE measure_table IS TABLE OF measure_record;

    FUNCTION get_operations_with_detail(detail_name varchar(100))
        RETURN measure_table
        PIPELINED;
END;

CREATE OR REPLACE PACKAGE BODY details AS

    FUNCTION get_operations_with_detail(detail_name varchar(100))
        RETURN measure_table
        PIPELINED IS rec measure_record;

    BEGIN
        SELECT l.operation_id, d.detail_id
          INTO rec
          FROM labor_cost_standards l
          right join details d on d.detail_id = l.detail_id and d.name = detail_name;

        PIPE ROW (rec);

        RETURN;
    END get_operations_with_detail;
END;

begin
    details.get_operations_with_detail('ЛДСП');
end;