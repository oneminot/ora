ALTER TABLE "testperson" DROP CONSTRAINT testperson_pk;
DROP SEQUENCE "testperson_sequence";
DROP TABLE "testperson";

CREATE TABLE "testperson" (
  c1 NUMBER        NOT NULL,
  c2 NVARCHAR2(10) NOT NULL,
  CONSTRAINT testperson_pk PRIMARY KEY (c1)
);

CREATE SEQUENCE "testperson_sequence"
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER "testperson_trigger"
BEFORE INSERT
ON "testperson"
REFERENCING NEW AS NEW
FOR EACH ROW
  BEGIN
    SELECT "testperson_sequence".nextval
    INTO :NEW.c1
    FROM DUAL;
  END;