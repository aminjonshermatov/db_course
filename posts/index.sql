create table posts
(
    id int NOT NULL,
    description varchar(255),
    created_at date default sysdate,

    constraint pk primary key (id)
);
create index posts__created_at on POSTS(created_at);

insert into POSTS values (1, '1', to_date('11/1/2022', 'DD/MM/YYYY'));
insert into POSTS values (2, '2', to_date('12/1/2022', 'DD/MM/YYYY'));
insert into POSTS values (3, '3', to_date('13/1/2022', 'DD/MM/YYYY'));
insert into POSTS values (4, '4', to_date('14/1/2022', 'DD/MM/YYYY'));

select *
from POSTS
offset 2 rows
fetch next 1 rows only;