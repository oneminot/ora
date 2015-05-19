-- ALTER TABLE "test_persons" DROP CONSTRAINT pk_test_persons;
-- DROP SEQUENCE KHADA.seq_test_persons;
-- DROP TABLE KHADA.test_persons;
--
-- CREATE TABLE test_persons (
--   ID           NUMBER(5)      NOT NULL,
--   Name         VARCHAR2(255)  NOT NULL,
--   Password     VARCHAR2(2000) NOT NULL,
--   AttemptCount NUMBER(5)      NOT NULL,
--   LastAttempt  TIMESTAMP      NOT NULL,
--   CONSTRAINT pk_test_persons PRIMARY KEY (ID)
-- );
--
-- CREATE SEQUENCE seq_test_persons
-- START WITH 1
-- INCREMENT BY 1
-- NOCACHE ;
--
-- CREATE OR REPLACE TRIGGER trigger_identity_test_persons
-- BEFORE INSERT
-- ON test_persons
-- REFERENCING NEW AS NEW
-- FOR EACH ROW
--   BEGIN
--     SELECT seq_test_persons.nextval
--     INTO :NEW.ID
--     FROM DUAL;
--   END;

-- INSERT INTO test_persons (ID, Name, Password, AttemptCount, LastAttempt)
-- VALUES (NULL, 'Kushal', 'aphromoo', 1, systimestamp);

SELECT 1
FROM test_persons
ORDER BY LastAttempt DESC;

-- create or REPLACE FUNCTION func_test_persons_insert
--   [Name_In IN varchar2(255), Password_In IN varchar2(2000)]
--   RETURN number
--   IS time_since_last_attempt timestamp;
-- cursor c1 is select 1 from test_persons order by LastAttempt DESC;
--
