/*
07а:Профессии <–>> 05:Нормы затрат труда <<–> 06:Тарифы.

    • Задача-1. Сведения о затратах труда в номер операции: код детали; номер участка; номер операции; код профессии; часовая тарифная ставка.
    • Задача-2. Для каждой детали: код детали; стоимость подготовительно-заключительных работ; стоимость на штуку (суммарно по всем операциям).
    • Задача-3. Все профессии, такие что:
для каждого кода работ (из 06)
имеется деталь в сборке которой рабочий такой профессии выполняет такую работу.
*/

ALTER SESSION SET CURRENT_SCHEMA = aminjon;

DROP SEQUENCE details_id_seq;
DROP SEQUENCE price_guide_seq;
DROP SEQUENCE profession_id_seq;
DROP SEQUENCE labor_cost_standards_id_seq;

DROP TABLE labor_cost_standards;
DROP TABLE price_guide;
DROP TABLE details;
DROP TABLE professions;

CREATE SEQUENCE details_id_seq START WITH 1;
CREATE TABLE details
(
    detail_id    int         DEFAULT details_id_seq.nextval,
    type         varchar(9)     NOT NULL CHECK ( type IN ('PURCHASED', 'IN_HOUSE') ),
    name         varchar(100)   NOT NULL,
    measure_unit varchar(10) DEFAULT 'шт',
    price        decimal(13, 2) NOT NULL CHECK ( price > 0 ),

    CONSTRAINT detail_id_pk PRIMARY KEY (detail_id)
);

CREATE SEQUENCE profession_id_seq START WITH 1;
CREATE TABLE professions
(
    profession_id int DEFAULT profession_id_seq.nextval,
    name          varchar(100) NOT NULL,

    CONSTRAINT profession_id_pk PRIMARY KEY (profession_id)
);


CREATE SEQUENCE price_guide_seq START WITH 1;
CREATE TABLE price_guide
(
    price_guide_id int DEFAULT price_guide_seq.nextval,
    hourly_rate    int NOT NULL CHECK ( hourly_rate > 0 ),

    CONSTRAINT price_guide_id_pk PRIMARY KEY (price_guide_id)
);

-- нормы затрат труда
CREATE SEQUENCE labor_cost_standards_id_seq START WITH 1;
CREATE TABLE labor_cost_standards
(
    detail_id        int,
    operation_id     int DEFAULT labor_cost_standards_id_seq.nextval,
    profession_id    int,
    qualification    int NOT NULL,
    price_guide_id   int,
    preparatory_time int NOT NULL CHECK ( preparatory_time >= 0 ),
    piece_time       int NOT NULL CHECK ( piece_time >= 0 ),

    CONSTRAINT operation_id_pk PRIMARY KEY (operation_id),
    CONSTRAINT detail_id_fk FOREIGN KEY (detail_id) REFERENCES details (detail_id) ON DELETE CASCADE,
    CONSTRAINT profession_labor_id_fk FOREIGN KEY (profession_id) REFERENCES professions (profession_id) ON DELETE CASCADE,
    CONSTRAINT price_guide_id_fk FOREIGN KEY (price_guide_id) REFERENCES price_guide (price_guide_id) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER on_delete__detail_update__labor_cost__set_null
    BEFORE DELETE
    ON details
    FOR EACH ROW
BEGIN
    UPDATE labor_cost_standards SET detail_id = NULL WHERE detail_id = :OLD.detail_id;
END;
/

CREATE OR REPLACE TRIGGER on_delete__price_guide__labor_cost__set_null
    BEFORE DELETE
    ON price_guide
    FOR EACH ROW
BEGIN
    UPDATE labor_cost_standards SET price_guide_id = NULL WHERE price_guide_id = :OLD.price_guide_id;
END;
/

CREATE OR REPLACE TRIGGER on_delete__profession__labor_cost__set_null
    BEFORE DELETE
    ON professions
    FOR EACH ROW
BEGIN
    UPDATE labor_cost_standards SET profession_id = NULL WHERE profession_id = :OLD.profession_id;
END;
/

CREATE OR REPLACE PROCEDURE seed_data AS
BEGIN
    INSERT INTO professions (name) VALUES ('Дизайнер');
    INSERT INTO professions (name) VALUES ('Конструктор');
    INSERT INTO professions (name) VALUES ('Столяр');
    INSERT INTO professions (name) VALUES ('Маляр');
    INSERT INTO professions (name) VALUES ('Сборщик мебели');

    INSERT INTO price_guide (hourly_rate) VALUES (11);
    INSERT INTO price_guide (hourly_rate) VALUES (12);
    INSERT INTO price_guide (hourly_rate) VALUES (13);
    INSERT INTO price_guide (hourly_rate) VALUES (14);
    INSERT INTO price_guide (hourly_rate) VALUES (15);

    INSERT INTO details ("TYPE", name, measure_unit, price) VALUES ('PURCHASED', 'ЛДСП', 'м.кв', 40); -- 40$
    INSERT INTO details ("TYPE", name, measure_unit, price) VALUES ('PURCHASED', 'Кромка', 'м', 3); -- 3$
    INSERT INTO details ("TYPE", name, measure_unit, price) VALUES ('PURCHASED', 'Лак', 'л', 2);
    INSERT INTO details ("TYPE", name, measure_unit, price) VALUES ('PURCHASED', 'ДВП', 'м.кв.', 5);
    INSERT INTO details ("TYPE", name, measure_unit, price) VALUES ('IN_HOUSE', 'Матрас', 'м.кб.', 20);

    INSERT INTO labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time,
                                     piece_time)
    VALUES (1, 2, 8, 2, 2, 2);
    INSERT INTO labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time,
                                     piece_time)
    VALUES (1, 3, 4, 1, 3, 4);
    INSERT INTO labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time,
                                     piece_time)
    VALUES (2, 3, 5, 1, 1, 1);
    INSERT INTO labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time,
                                     piece_time)
    VALUES (3, 4, 6, 3, 2, 2);
    INSERT INTO labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time,
                                     piece_time)
    VALUES (4, 3, 5, 4, 3, 2);
    INSERT INTO labor_cost_standards(detail_id, profession_id, qualification, price_guide_id, preparatory_time,
                                     piece_time)
    VALUES (5, 5, 3, 5, 4, 4);

END seed_data;
/

BEGIN
    seed_data();
END;

CREATE OR REPLACE PACKAGE furniture_details AS

    TYPE measure_record IS record
                           (
                               operation_id int,
                               detail_id    int,
                               detail_name  varchar(100),
                               price        decimal
                           );
    TYPE measure_table IS table of measure_record;

    FUNCTION most_expensive_detail RETURN int;
    FUNCTION get_operations_with_detail(detail_name varchar2) RETURN measure_table PIPELINED;
END furniture_details;
/

CREATE OR REPLACE PACKAGE BODY furniture_details AS

    FUNCTION most_expensive_detail RETURN int IS
        most_exp int;
    BEGIN
        SELECT MAX(price)
        INTO most_exp
        FROM details;
        RETURN most_exp;
    END most_expensive_detail;

    FUNCTION get_operations_with_detail(detail_name varchar2) RETURN measure_table PIPELINED IS
        res measure_table;
    BEGIN
        SELECT l.operation_id,
               d.detail_id,
               d.name,
               d.price BULK COLLECT
        INTO res
        FROM labor_cost_standards l
                 RIGHT JOIN details d ON d.detail_id = l.detail_id
        WHERE d.name = detail_name;

        FOR i IN 1..res.COUNT
            LOOP
                PIPE ROW ( res(i) );
            END LOOP;

        RETURN;
    END get_operations_with_detail;
END furniture_details;
/

CREATE OR REPLACE VIEW labor_cost_all_details AS
SELECT d.detail_id       detailId,
       d.type            detailType,
       d.name            detailName,
       d.measure_unit    detailMeasureUnit,
       d.price           detailPrice,
       operation_id      operationId,
       qualification,
       preparatory_time  preparatoryTime,
       piece_time        pieceTime,
       p.profession_id   professionId,
       p.name            professionName,
       pg.price_guide_id priceGuideId,
       pg.hourly_rate    priceGuideHourlyRate
FROM aminjon.labor_cost_standards lcs
         LEFT JOIN aminjon.details d ON lcs.detail_id = d.detail_id
         LEFT JOIN aminjon.price_guide pg ON lcs.price_guide_id = pg.price_guide_id
         LEFT JOIN aminjon.professions p ON lcs.profession_id = p.profession_id;

CREATE OR REPLACE PACKAGE tasks AS

    -- task_1
    TYPE operation_detailed_t IS record
                                 (
                                     operation_id    int,
                                     qualification   int,
                                     detail_id       int,
                                     detail_name     varchar(100),
                                     price           decimal,
                                     hourly_rate     int,
                                     profession_name varchar(100)
                                 );

    PROCEDURE get_operation_detailed(req_operation_id IN int, res OUT operation_detailed_t);

    -- task_2
    TYPE operation_with_aggregation_t IS record
                                         (
                                             detail_id         int,
                                             operation_id      int,
                                             profession_name   varchar(100),
                                             operations_count  int,
                                             min_qualification int
                                         );
    TYPE operation_with_aggregation_list_t IS TABLE OF operation_with_aggregation_t;
    FUNCTION get_operation_with_aggregation RETURN operation_with_aggregation_list_t PIPELINED;
END tasks;
/

CREATE OR REPLACE PACKAGE BODY tasks AS
    -- task_1
    PROCEDURE get_operation_detailed(req_operation_id IN int, res OUT operation_detailed_t) AS
    BEGIN
        SELECT lcs.operation_id,
               lcs.qualification,
               d.detail_id,
               d.name detail_name,
               d.price,
               pg.hourly_rate,
               p.name profession_name
        INTO res
        FROM aminjon.labor_cost_standards lcs
                 LEFT JOIN aminjon.details d ON lcs.detail_id = d.detail_id AND lcs.operation_id = req_operation_id
                 LEFT JOIN aminjon.price_guide pg
                           ON lcs.price_guide_id = pg.price_guide_id AND lcs.operation_id = req_operation_id
                 LEFT JOIN aminjon.professions p
                           ON lcs.profession_id = p.profession_id AND lcs.operation_id = req_operation_id
        WHERE lcs.operation_id = req_operation_id;
    END get_operation_detailed;

    -- task_2
    FUNCTION get_operation_with_aggregation RETURN operation_with_aggregation_list_t PIPELINED IS
        res operation_with_aggregation_list_t;
    BEGIN
        SELECT lcs.detail_id,
               lcs.operation_id,
               p.name                                                    profession_name,
               COUNT(*) OVER (PARTITION BY lcs.profession_id)            operations_cnt,
               MIN(lcs.qualification) OVER ( PARTITION BY lcs.detail_id) min_qualification BULK COLLECT
        INTO res
        FROM aminjon.labor_cost_standards lcs
                 LEFT JOIN professions p ON p.profession_id = lcs.profession_id;

        FOR i IN 1..res.COUNT
            LOOP
                PIPE ROW ( res(i) );
            END LOOP;

        RETURN;
    END get_operation_with_aggregation;
END tasks;
/

-- task_2 with CTE
WITH operations_count_tb AS (SELECT profession_id, COUNT(operation_id) cnt
                             FROM aminjon.labor_cost_standards
                             GROUP BY profession_id),
     min_qualification_tb AS (SELECT detail_id, MIN(qualification) mn
                              FROM aminjon.labor_cost_standards
                              GROUP BY detail_id)
SELECT lcs.detail_id,
       lcs.operation_id,
       p.name profession_name,
       oc.cnt operations_cnt,
       mq.mn  min_qualification
FROM aminjon.labor_cost_standards lcs
         LEFT JOIN operations_count_tb oc ON oc.profession_id = lcs.operation_id
         LEFT JOIN min_qualification_tb mq ON mq.detail_id = lcs.detail_id
         LEFT JOIN professions p ON p.profession_id = lcs.profession_id;

SELECT *
FROM TABLE ( tasks.get_operation_with_aggregation() );

DECLARE
    operation_detailed tasks.operation_detailed_t;
BEGIN
    tasks.get_operation_detailed(1, operation_detailed);
    dbms_output.put_line(operation_detailed.detail_id || ' ' || operation_detailed.detail_name);
END;

SELECT furniture_details.most_expensive_detail()
FROM dual;

SELECT *
FROM TABLE ( furniture_details.get_operations_with_detail('ЛДСП') );
-- • Задача-3. Все профессии, такие что:
-- для каждого кода работ (из 06)
-- имеется деталь в сборке которой рабочий такой профессии выполняет такую работу.