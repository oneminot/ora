-- CREATE TABLE "kushaltesttable"
-- (
--   KushalTestTableText NVARCHAR2(50) UNIQUE NOT NULL
--   --   CONSTRAINT KushalTestTableID_Unique
--   --   UNIQUE (KushalTestTableID)
-- );

DROP TABLE "kushaltestperson";
DROP SEQUENCE "kushaltestperson_sequence";


CREATE TABLE "kushaltestperson" (
  c1 NUMBER PRIMARY KEY,
  c2 NVARCHAR2(10)
);

CREATE SEQUENCE "kushaltestperson_sequence"
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER "kushaltestperson_trigger"
BEFORE INSERT
ON "kushaltestperson"
REFERENCING NEW AS NEW
FOR EACH ROW
  BEGIN
    SELECT "kushaltestperson_sequence".nextval
    INTO :NEW.c1
    FROM DUAL;
  END;