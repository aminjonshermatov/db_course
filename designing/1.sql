ALTER SESSION SET CURRENT_SCHEMA = AMINJON;

DROP SEQUENCE products_id_seq;
DROP TABLE products;
DROP SEQUENCE shipments_id_seq;
DROP TABLE shipments;
DROP SEQUENCE orders_id_seq;
DROP SEQUENCE contract_id_seq;
DROP TABLE orders;

CREATE SEQUENCE products_id_seq START WITH 1;
CREATE TABLE products
(
    id    INT DEFAULT products_id_seq.nextval PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    price INT          NOT NULL CHECK ( price > 0 )
);

CREATE SEQUENCE orders_id_seq START WITH 1;
CREATE SEQUENCE contract_id_seq START WITH 1;
CREATE TABLE orders
(
    id               INT  DEFAULT orders_id_seq.nextval PRIMARY KEY,
    customer_name    VARCHAR(100) NOT NULL,
    customer_address VARCHAR(100) NOT NULL,
    customer_phone   VARCHAR(20) CHECK ( REGEXP_LIKE(customer_phone, -- https://www.regextester.com/99415
                                                     '^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$') ),
    contract_id      INT  DEFAULT contract_id_seq.nextval,
    created_at       DATE DEFAULT CURRENT_TIMESTAMP,
    product_id       INT NOT NULL,
    quantity         INT NOT NULL CHECK ( quantity > 0 ),

    CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES products( id ) ON DELETE SET NULL
    -- TODO: CONSTRAINT contract_id_fk FOREIGN KEY (contract_id) REFERENCES contracts(id) ON DELETE CASCADE
);

CREATE SEQUENCE shipments_id_seq START WITH 1;
CREATE TABLE shipments
(
    id  INT DEFAULT shipments_id_seq.nextval PRIMARY KEY,
    order_id INT NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL CHECK ( quantity > 0 ),

    CONSTRAINT order_id_fk FOREIGN KEY (order_id) REFERENCES orders( id ) ON DELETE SET NULL
);