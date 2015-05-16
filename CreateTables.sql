-- ALTER TABLE KHADA."events" DROP CONSTRAINT CLASSES_EVENTS_FK;
-- ALTER TABLE KHADA."authorarticles" DROP CONSTRAINT AUTHORS_AUTHORARTICLES_FK;
-- ALTER TABLE KHADA."courses" DROP CONSTRAINT DEPARTMENTS_COURSES_FK;
-- ALTER TABLE KHADA."classes" DROP CONSTRAINT COURSES_CLASSES_FK;
-- DROP TABLE KHADA."events";
-- DROP TABLE KHADA."authorarticles";
-- DROP TABLE KHADA."courses";
-- DROP TABLE KHADA."classes";
-- DROP TABLE KHADA."departments";
-- DROP TABLE KHADA."authors";
-- DROP TABLE KHADA."publications";
-- DROP TABLE KHADA."assignments";
-- DROP TABLE KHADA."articles";
-- DROP TABLE KHADA."administrationusers";

CREATE TABLE "departments"
(
  DepartmentID         NUMBER(5) PRIMARY KEY,
  DepartmentIdentifier NVARCHAR2(5)  NOT NULL,
  DepartmentName       NVARCHAR2(40) NOT NULL,
  CONSTRAINT DepartmentIdentifer_Unique
  UNIQUE (DepartmentIdentifier)
);

CREATE SEQUENCE "departments_sequence"
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER "departments_sequence_trigger"
BEFORE INSERT
ON "departments"
REFERENCING NEW AS NEW
FOR EACH ROW
  BEGIN
    SELECT "departments_sequence".nextval
    INTO :NEW.DepartmentID
    FROM DUAL;
  END;

CREATE TABLE "courses"
(
  CourseID     NUMBER(5) PRIMARY KEY,
  DepartmentID      NUMBER(5)       NOT NULL,
  CourseNumber NVARCHAR2(6) NOT NULL,
  CourseName        NVARCHAR2(40)   NOT NULL,
  CourseDescription NVARCHAR2(2000) NOT NULL,
  CONSTRAINT CourseNumber_Unique
  UNIQUE (DepartmentID, CourseNumber),
  CONSTRAINT Departments_Courses_FK
  FOREIGN KEY (DepartmentID)
  REFERENCES "departments" (DepartmentID)
);

CREATE TABLE "classes"
(
  ClassID     NUMBER(5) PRIMARY KEY,
  ClassNumber NVARCHAR2(6) NOT NULL,
  CourseID    NUMBER(5)    NOT NULL,
  CONSTRAINT ClassNumber_Unique
  UNIQUE (ClassNumber, CourseID),
  CONSTRAINT Courses_Classes_FK
  FOREIGN KEY (CourseID)
  REFERENCES "courses" (CourseID)
);

CREATE TABLE "events"
(
  EventID     NUMBER(5) PRIMARY KEY,
  ClassID     NUMBER(5) NOT NULL,
  StartDate   DATE      NOT NULL,
  EndDate     DATE      NOT NULL,
  StartTime   DATE      NOT NULL,
  EndTime     DATE      NOT NULL,
  IsMonday    CHAR(1) NOT NULL,
  IsTuesday   CHAR(1) NOT NULL,
  IsWednesday CHAR(1) NOT NULL,
  IsThursday  CHAR(1) NOT NULL,
  IsFriday    CHAR(1) NOT NULL,
  IsSaturday  CHAR(1) NOT NULL,
  IsSunday    CHAR(1) NOT NULL,
  CONSTRAINT StartDate_Unique
  UNIQUE (StartDate, EndDate, ClassID),
  CONSTRAINT Classes_Events_FK
  FOREIGN KEY (ClassID)
  REFERENCES "classes" (ClassID)
);

CREATE TABLE "assignments"
(
  AssignmentID               NUMBER(5) PRIMARY KEY,
  CourseID                   NUMBER(5)     NOT NULL,
  AssignmentNumber NVARCHAR2(5) NOT NULL,
  AssignmentName             NVARCHAR2(40) NOT NULL,
  AssignmentDueDate          DATE          NOT NULL,
  AssignmentHeader           NVARCHAR2(40) NOT NULL,
  AssignmentChapterReference NVARCHAR2(40) NOT NULL,
  AssignmentDetail           NCLOB         NOT NULL,
  AssignmentIsActive         CHAR(1)       NOT NULL
);

CREATE TABLE "articles" (
  ArticleID            NUMBER(5) PRIMARY KEY,
  ArticleTitle         NVARCHAR2(80) NOT NULL,
  RelativeFileLocation NVARCHAR2(80) NOT NULL,
  PublicationID        NUMBER(5)     NOT NULL,
  PageReference        NVARCHAR2(40),
  CONSTRAINT Article_Unique
  UNIQUE (ArticleTitle, RelativeFileLocation, PublicationID, PageReference)
);

CREATE TABLE "authors"
(
  AuthorID   NUMBER(5) PRIMARY KEY,
  AuthorName NVARCHAR2(40) NOT NULL,
  CONSTRAINT AuthorName_Unique
  UNIQUE (AuthorName)
);

CREATE TABLE "publications"
(
  PublicationID       NUMBER(5) PRIMARY KEY,
  PublicationTitle    NVARCHAR2(80) NOT NULL,
  PublicationLocation NVARCHAR2(80) NOT NULL,
  PublicationYear     VARCHAR2(4)
);

CREATE TABLE "authorarticles"
(
  AuthorArticleID NUMBER(5) PRIMARY KEY,
  AuthorID        NUMBER(5) NOT NULL,
  ArticleID       NUMBER(5) NOT NULL,
  CONSTRAINT AuthorID_ArticleID_Unique
  UNIQUE (AuthorID, ArticleID),
  CONSTRAINT Authors_AuthorArticles_FK
  FOREIGN KEY (AuthorID)
  REFERENCES "authors" (AuthorID)
);

CREATE TABLE "administrationusers" (
  AdministrationUserID           NUMBER(5) PRIMARY KEY NOT NULL,
  AdministrationUserName         NVARCHAR2(255)        NOT NULL,
  AdministrationUserSalt         NVARCHAR2(2000)       NOT NULL,
  AdministrationUserPassword     NVARCHAR2(2000)       NOT NULL,
  AdministrationUserAttemptCount NUMBER(5)             NOT NULL,
  AdministrationUserLastAttempt  TIMESTAMP             NOT NULL
);