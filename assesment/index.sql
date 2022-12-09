alter session set current_schema = AMINJON;

drop sequence details_id_seq;
drop sequence store_id_seq;
drop sequence shipment_accounting_id_seq;

drop table shipment_accounting;
drop table available_details_in_store;
drop table store;
drop table details;

-- 14,16a,16в
create sequence details_id_seq start with 1;
create table details (
    detail_id int default details_id_seq.nextval,
    type varchar(9) not null check ( type in ('PURCHASED', 'IN_HOUSE') ),
    name varchar(100) not null,
    measure_unit varchar(10) default 'шт',
    price decimal(13, 2) not null check ( price > 0 ),

    constraint details__detail_id_pk primary key (detail_id)
);

alter table details modify (detail_id smallint default details_id_seq.nextval);

-- 16a
create sequence store_id_seq start with 1;
create table store (
    store_id int default store_id_seq.nextval,
    responsible_person varchar(100) not null,

    constraint store__store_id_pk primary key (store_id)
);

alter table store modify (store_id smallint default store_id_seq.nextval);

-- 16в
create table available_details_in_store (
    store_id int not null,
    detail_id int not null,
    quantity int check ( quantity >= 0 ),
    updated_at date not null,

    constraint available_details_in_store__store_id_fk foreign key (store_id) references store(store_id) on delete cascade,
    constraint available_details_in_store__detail_id_fk foreign key (detail_id) references details(detail_id) on delete cascade,
    constraint available_details_in_store__store_detail_pk primary key (store_id, detail_id)
);

alter table available_details_in_store modify (
    store_id smallint,
    detail_id smallint
);

-- 14
create sequence shipment_accounting_id_seq start with 1;
create table shipment_accounting (
    store_id int,
    shipment_accounting_id int default shipment_accounting_id_seq.nextval,
    customer_id int not null, --TODO foreign key
    detail_id int not null,
    quantity int check ( quantity > 0 ),
    shipment_date date not null,

    constraint shipment_accounting__store_id_shipment_accounting_id_pk primary key (store_id, shipment_accounting_id)
);

alter table shipment_accounting add constraint shipment_accounting__store_id_detail_id_fk
    foreign key (store_id, detail_id) references available_details_in_store(store_id, detail_id) on delete set null;

alter table shipment_accounting modify (
    store_id smallint,
    detail_id smallint,
    shipment_accounting_id smallint default shipment_accounting_id_seq.nextval,
    customer_id smallint
);