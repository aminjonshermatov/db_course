ALTER SESSION SET CURRENT_SCHEMA = AMINJON;

CREATE SEQUENCE employees_id_seq START WITH 1;
CREATE TABLE employees
(
    id            INT DEFAULT employees_id_seq.nextval PRIMARY KEY,
    department_id INT          NOT NULL,
    name_surname  VARCHAR(100) NOT NULL,
    position      VARCHAR(100) NOT NULL,
    salary        INT          NOT NULL CHECK ( salary > 0 ),
    bonus         INT          NOT NULL CHECK ( bonus >= 0 ),
    hired_at      DATE         NOT NULL -- month???
);

CREATE SEQUENCE contracts_id_seq START WITH 1;
CREATE TABLE contracts
(
    id              INT  DEFAULT contracts_id_seq.nextval PRIMARY KEY,
    shipment_id     INT NOT NULL,
    organization_id INT NOT NULL,
    created_at      DATE DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE shipments_id_seq START WITH 1;
CREATE TABLE shipments
(
    id             INT DEFAULT shipments_id_seq.nextval PRIMARY KEY,
    employee_id    INT          NOT NULL,
    contract_id    INT          NOT NULL,
    equipment_type VARCHAR(100) NOT NULL, --TODO check that equipment_type in equipments list
    users_comment  VARCHAR(100),

    CONSTRAINT employee_id_fk FOREIGN KEY (employee_id) REFERENCES employees (id),
    CONSTRAINT contract_id_fk FOREIGN KEY (contract_id) REFERENCES contracts (id)
);

ALTER TABLE contracts
    ADD CONSTRAINT shipment_id_in_contract_id_fk FOREIGN KEY (shipment_id) REFERENCES shipments (id);

CREATE SEQUENCE organizations_id_seq START WITH 1;
CREATE TABLE organizations
(
    id           INT DEFAULT organizations_id_seq.nextval PRIMARY KEY,
    contract_id  INT          NOT NULL,
    country_code INT          NOT NULL,
    city         VARCHAR(100) NOT NULL,
    address      VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) CHECK ( REGEXP_LIKE(phone_number, -- https://www.regextester.com/99415
                                                 '^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$') ),
    email        VARCHAR(20) CHECK ( REGEXP_LIKE(email,        -- https://regexr.com/3e48o
                                                 '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') ),
    web_site     VARCHAR(20),

    CONSTRAINT contract_id__organizations_fk FOREIGN KEY (contract_id) REFERENCES contracts (id)
);

ALTER TABLE contracts
    ADD CONSTRAINT organization_id__in__contract_id FOREIGN KEY (organization_id) REFERENCES organizations (id);