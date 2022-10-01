alter session set current_schema = AMINJON;

create table posts
(
    id int NOT NULL,
    description varchar(255),
    created_at date default sysdate,

    constraint pk primary key (id)
);

create index posts__created_at on POSTS(created_at);