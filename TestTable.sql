ALTER TABLE "testpersons" DROP CONSTRAINT pk_testpersons;
DROP SEQUENCE "testperson_sequence";
DROP TABLE "testpersons";

CREATE TABLE "testpersons" (
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_testpersons PRIMARY KEY (ID)
);

CREATE SEQUENCE "testperson_sequence"
START WITH 1
INCREMENT BY 1;

-- CREATE OR REPLACE TRIGGER "testperson_trigger"
-- BEFORE INSERT
-- ON "testpersons"
-- REFERENCING NEW AS NEW
-- FOR EACH ROW
--   BEGIN
--     SELECT "testperson_sequence".nextval
--     INTO :NEW.ID
--     FROM DUAL;
--   END;

INSERT INTO testpersons (ID, Name, Password, AttemptCount, LastAttempt)
VALUES ("testperson_sequence".nextval, "Kushal", "aphromoo", 1, SYSDATE);