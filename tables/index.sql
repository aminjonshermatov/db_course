/*
07а:Профессии <–>> 05:Нормы затрат труда <<–> 06:Тарифы.

    • Задача-1. Сведения о затратах труда в номер операции: код детали; номер участка; номер операции; код профессии; часовая тарифная ставка.
    • Задача-2. Для каждой детали: код детали; стоимость подготовительно-заключительных работ; стоимость на штуку (суммарно по всем операциям).
    • Задача-3. Все профессии, такие что:
для каждого кода работ (из 06)
имеется деталь в сборке которой рабочий такой профессии выполняет такую работу.
*/

drop sequence details_id_seq;
drop sequence employee_id_seq;
drop sequence price_guide_seq;
drop sequence profession_id_seq;
drop sequence section_id_seq;
drop sequence workshop_id_seq;
drop sequence labor_cost_standards_id_seq;

drop table labor_cost_standards;
drop table price_guide;
drop table sections;
drop table workshops;
drop table details;
drop table employees;
drop table professions;

create sequence details_id_seq start with 1;
create table details (
    detail_id int default details_id_seq.nextval,
    type varchar(9) not null check ( type in ('PURCHASED', 'IN_HOUSE') ),
    name varchar(100) not null,
    measure_unit varchar(10) default 'pcs',
    price decimal(13, 2) not null check ( price > 0 ),

    constraint detail_id_pk primary key (detail_id)
);

create sequence profession_id_seq start with 1;
create table professions (
    profession_id int default profession_id_seq.nextval,
    name varchar(100) not null,

    constraint profession_id_pk primary key (profession_id)
);

create sequence employee_id_seq start with 1;
create table employees (
    employee_id int default employee_id_seq.nextval,
    profession_id int not null,
    qualification int default (1) not null,
    marital_status varchar(8) not null check ( marital_status in ('SINGLE', 'MARRIED', 'DIVORCED') ),
    initials varchar(30) not null,

    constraint employee_id_pk primary key (employee_id),
    constraint profession_id_fk foreign key (profession_id) references professions(profession_id) on delete cascade
);

-- цех
create sequence workshop_id_seq start with 1;
create table workshops (
    workshop_id int default workshop_id_seq.nextval,
    name varchar(100) not null,
    masters_id int not null,

    constraint workshop_id_pk primary key (workshop_id),
    constraint masters_id_workshop_fk foreign key (masters_id) references employees(employee_id) on delete cascade
);

-- участки цеха
create sequence section_id_seq start with 1;
create table sections (
    workshop_id int not null,
    section_id int default section_id_seq.nextval,
    name varchar(100) not null,
    masters_id int not null,

    constraint section_id_pk primary key (section_id),
    constraint workshop_id_fk foreign key (workshop_id) references workshops(workshop_id) on delete cascade,
    constraint masters_id_section_fk foreign key (masters_id) references employees(employee_id) on delete cascade
);

create sequence price_guide_seq start with 1;
create table price_guide (
    price_guide_id int default profession_id_seq.nextval,
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