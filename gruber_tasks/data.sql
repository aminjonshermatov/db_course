alter session set current_schema = AMINJON;

truncate table Salespeople;
INSERT INTO Salespeople
values (1001, 'Peel', 'London', 0.12);
INSERT INTO Salespeople(snum, sname, city, comm)
values (1002, 'Serres', 'San Jose', 0.13);
INSERT INTO Salespeople(snum, sname, city, comm)
values (1004, 'Motika', 'London', 0.11);
INSERT INTO Salespeople(snum, sname, city, comm)
values (1007, 'Rifkin', 'Barcelona', 0.15);
INSERT INTO Salespeople(snum, sname, city, comm)
values (1003, 'Axelrod', 'New York', 0.10);

truncate table Customers;
insert into Customers(cnum, cname, city, rating, snum)
values (2001, 'Hoffman', 'London', 100, 1001);
insert into Customers(cnum, cname, city, rating, snum)
values (2002, 'Giovanni', 'Rome', 200, 1003);
insert into Customers(cnum, cname, city, rating, snum)
values (2003, 'Liu', 'San Jose', 200, 1002);
insert into Customers(cnum, cname, city, rating, snum)
values (2004, 'Grass', 'Berlin', 300, 1002);
insert into Customers(cnum, cname, city, rating, snum)
values (2006, 'Clemens', 'London', 100, 1001);
insert into Customers(cnum, cname, city, rating, snum)
values (2008, 'Cisneros', 'San Jose', 300, 1007);
insert into Customers(cnum, cname, city, rating, snum)
values (2007, 'Pereira', 'Rome', 100, 1004);

truncate table Orders;
insert into Orders(onum, amt, odate, cnum, snum)
values (3001, 18.69, TO_DATE('03.10.2015', 'DD.MM.YYYY'), 2008, 1007);
insert into Orders(onum, amt, odate, cnum, snum)
values (3003, 767.19, TO_DATE('03.10.2015', 'DD.MM.YYYY'), 2001, 1001);
insert into Orders(onum, amt, odate, cnum, snum)
values (3002, 1900.10, TO_DATE('03.10.2015', 'DD.MM.YYYY'), 2007, 1004);
insert into Orders(onum, amt, odate, cnum, snum)
values (3005, 5160.45, TO_DATE('03.10.2015', 'DD.MM.YYYY'), 2003, 1002);
insert into Orders(onum, amt, odate, cnum, snum)
values (3006, 1098.16, TO_DATE('03.10.2015', 'DD.MM.YYYY'), 2008, 1007);
insert into Orders(onum, amt, odate, cnum, snum)
values (3009, 1713.23, TO_DATE('04.10.2015', 'DD.MM.YYYY'), 2002, 1003);
insert into Orders(onum, amt, odate, cnum, snum)
values (3007, 75.75, TO_DATE('04.10.2015', 'DD.MM.YYYY'), 2004, 1002);
insert into Orders(onum, amt, odate, cnum, snum)
values (3008, 4723.00, TO_DATE('05.10.2015', 'DD.MM.YYYY'), 2006, 1001);
insert into Orders(onum, amt, odate, cnum, snum)
values (3010, 1309.95, TO_DATE('06.10.2015', 'DD.MM.YYYY'), 2004, 1002);
insert into Orders(onum, amt, odate, cnum, snum)
values (3011, 9891.88, TO_DATE('06.10.2015', 'DD.MM.YYYY'), 2006, 1001);
