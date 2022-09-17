alter session set current_schema = AMINJON;

CREATE TABLE Salespeople
(
    snum  INT,
    sname VARCHAR(30),
    city  VARCHAR(15),
    comm  DECIMAL(3, 2)
);

CREATE TABLE Customers
(
    cnum   INT,
    cname  VARCHAR(30),
    city   VARCHAR(15),
    rating INT,
    snum   INT
);

CREATE TABLE Orders
(
    onum  INT,
    odate DATE,
    amt   DECIMAL(14, 2),
    snum  INT,
    cnum  INT
);