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
--
-- INSERT INTO test_persons (ID, Name, Password, AttemptCount, LastAttempt)
-- VALUES (NULL, 'Kushal', 'aphromoo', 1, systimestamp);
--
-- SELECT *
-- FROM test_persons
-- WHERE ROWNUM <= 3
-- ORDER BY LastAttempt DESC;

CREATE OR REPLACE PROCEDURE proc_test_persons_insert
  (Name_In IN VARCHAR2(255), Password_In IN VARCHAR2(2000))
IS
  time_since_last_attempt TIMESTAMP;
  CURSOR temp_timestamp IS SELECT LASTATTEMPT
                           FROM test_persons
                           WHERE ROWNUM <= 1
                           ORDER BY LastAttempt DESC;
  temp_number_of_attempts NUMBER(5);
  CURSOR temp_number_of_attempts IS SELECT ATTEMPTCOUNT
                                    FROM TEST_PERSONS
                                    WHERE ROWNUM <= 1
                                    ORDER BY LASTATTEMPT DESC;
  BEGIN
    OPEN temp_timestamp;
    OPEN temp_number_of_attempts;
    IF systimestamp - temp_timestamp > 6000
    THEN
      temp_number_of_attempts := temp_number_of_attempts + 1;
    END IF;
    INSERT INTO test_persons (ID, Name, Password, AttemptCount, LastAttempt)
    VALUES (NULL, Name_In, Password_In, temp_number_of_attempts, systimestamp);
    COMMIT;
    CLOSE temp_timestamp;
    CLOSE temp_number_of_attempts;
    EXCEPTION
    WHEN OTHERS THEN
    raise_application_error(-20001, 'Oracle Server | Could not add new user. - ' || SQLCODE || ' -ERROR- ' || SQLERRM);
  END;