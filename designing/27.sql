ALTER SESSION SET CURRENT_SCHEMA = AMINJON;

DROP SEQUENCE bookings_id_seq;
DROP TABLE booking;
DROP SEQUENCE flights_id_seq;
DROP TABLE flights;
DROP SEQUENCE planes_id_seq;
DROP TABLE planes;
DROP SEQUENCE routes_id_seq;
DROP TABLE routes;
DROP SEQUENCE commanders_id_seq;
DROP TABLE commanders;
DROP TABLE passengers;

CREATE SEQUENCE routes_id_seq START WITH 1;
CREATE TABLE routes
(
    id          INT DEFAULT routes_id_seq.nextval PRIMARY KEY,
    departure   VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    price       INT          NOT NULL CHECK ( price > 0 ),
    duration    INT          NOT NULL CHECK ( duration > 0 ),

    CONSTRAINT check_is_not_same_destination CHECK ( destination != departure )
);

CREATE SEQUENCE commanders_id_seq START WITH 1;
CREATE TABLE commanders
(
    id           INT DEFAULT commanders_id_seq.nextval PRIMARY KEY,
    name_surname VARCHAR(100) NOT NULL,
    address      VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) CHECK ( REGEXP_LIKE(phone_number, -- https://www.regextester.com/99415
                                                 '^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$') ),
    flight_time  INT DEFAULT 0 CHECK ( flight_time >= 0 )
);

CREATE SEQUENCE planes_id_seq START WITH 1;
CREATE TABLE planes
(
    id                     INT     DEFAULT planes_id_seq.nextval PRIMARY KEY,
    commander_id           INT          NOT NULL,
    model                  VARCHAR(100) NOT NULL,
    manufactured_at        DATE    DEFAULT CURRENT_TIMESTAMP,
    lifespan               INT          NOT NULL CHECK ( lifespan > 0 ),
    is_ready_for_departure CHAR(1) DEFAULT '1' CHECK ( is_ready_for_departure IN ('0', '1') ),

    CONSTRAINT commander_id_fk FOREIGN KEY (commander_id) REFERENCES commanders (id) ON DELETE SET NULL
);

CREATE SEQUENCE flights_id_seq START WITH 1;
CREATE TABLE flights
(
    id           INT     DEFAULT flights_id_seq.nextval PRIMARY KEY,
    route_id     INT NOT NULL,
    plane_id     INT NOT NULL,
    departure_at DATE    DEFAULT CURRENT_TIMESTAMP,
    is_cancelled CHAR(1) DEFAULT '0' CHECK ( is_cancelled IN ('0', '1') ),

    CONSTRAINT route_id_fk FOREIGN KEY (route_id) REFERENCES routes (id) ON DELETE SET NULL,
    CONSTRAINT plane_id_fk FOREIGN KEY (plane_id) REFERENCES planes (id) ON DELETE SET NULL
);

CREATE TABLE passengers
(
    passport     INT          NOT NULL PRIMARY KEY,
    name_surname VARCHAR(100) NOT NULL,
    address      VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) CHECK ( REGEXP_LIKE(phone_number, -- https://www.regextester.com/99415
                                                 '^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$') )
);

CREATE SEQUENCE bookings_id_seq START WITH 1;
CREATE TABLE booking
(
    id                 INT DEFAULT bookings_id_seq.nextval PRIMARY KEY,
    flight_id          INT NOT NULL,
    passenger_passport INT NOT NULL,

    CONSTRAINT flight_id_fk FOREIGN KEY (flight_id) REFERENCES flights (id) ON DELETE SET NULL,
    CONSTRAINT passenger_passport_fk FOREIGN KEY (passenger_passport) REFERENCES passengers (passport) ON DELETE SET NULL
);