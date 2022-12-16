ALTER SESSION SET CURRENT_SCHEMA = AMINJON;

-- drugs        -> лекарставо
-- drugstore    -> аптека
-- requests     -> заявки
-- purchases    -> закупки

DROP SEQUENCE purchases_id_seq;
DROP TABLE purchases;
DROP SEQUENCE requests_id_seq;
DROP TABLE requests;
DROP SEQUENCE drugstores_id_seq;
DROP TABLE drugstores;
DROP SEQUENCE drugs_id_seq;
DROP TABLE drugs;

CREATE SEQUENCE drugs_id_seq START WITH 1;
CREATE TABLE drugs
(
    id                INT DEFAULT drugs_id_seq.nextval PRIMARY KEY,
    name              VARCHAR(100) NOT NULL,
    manufacturer_name VARCHAR(100),
    price             INT          NOT NULL CHECK ( price > 0 )
);

CREATE SEQUENCE drugstores_id_seq START WITH 1;
CREATE TABLE drugstores
(
    id           INT DEFAULT drugstores_id_seq.nextval PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    address      VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) CHECK ( REGEXP_LIKE(phone_number, -- https://www.regextester.com/99415
                                                 '^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$') )
);

CREATE SEQUENCE requests_id_seq START WITH 1;
CREATE TABLE requests
(
    id           INT  DEFAULT requests_id_seq.nextval PRIMARY KEY,
    created_at   DATE DEFAULT CURRENT_TIMESTAMP,
    drugstore_id INT  NOT NULL,
    fulfilled_at DATE NOT NULL,

    CONSTRAINT drugstore_id_fk FOREIGN KEY (drugstore_id) REFERENCES drugstores (id) ON DELETE SET NULL
);

CREATE SEQUENCE purchases_id_seq START WITH 1;
CREATE TABLE purchases
(
    id         INT DEFAULT purchases_id_seq.nextval PRIMARY KEY,
    request_id INT NOT NULL,
    drug_id    INT NOT NULL,
    quantity   INT NOT NULL CHECK ( quantity > 0 ),

    CONSTRAINT drug_id_fk FOREIGN KEY (drug_id) REFERENCES drugs (id) ON DELETE SET NULL
);