DROP TABLE "courses";
DROP TABLE "departments";
DROP TABLE "classes";
DROP TABLE "events";

CREATE TABLE "departments"
(
  DepartmentID         NUMBER(5) PRIMARY KEY,
  DepartmentIdentifier NVARCHAR2(5)  NOT NULL,
  DepartmentName       NVARCHAR2(40) NOT NULL,
  CONSTRAINT DepartmentIdentifer_Unique
  UNIQUE (DepartmentIdentifier)
);

CREATE TABLE "courses"
(
  CourseID NUMBER(5) PRIMARY KEY,
  DepartmentID      NUMBER(5)       NOT NULL,
  CourseNumber      NUMBER(5)       NOT NULL,
  CourseName        NVARCHAR2(40)   NOT NULL,
  CourseDescription NVARCHAR2(2000) NOT NULL,
  CONSTRAINT CourseNumber_Unique
  UNIQUE (DepartmentID, CourseNumber),
  CONSTRAINT DepartmentID_FK
  FOREIGN KEY (DepartmentID)
  REFERENCES "departments" (DepartmentID)
);

CREATE TABLE "classes"
(
  ClassID     NUMBER(5) PRIMARY KEY,
  ClassNumber VARCHAR2(6) NOT NULL,
  CourseID    NUMBER(5)   NOT NULL,
  CONSTRAINT ClassNumber_Unique
  UNIQUE (ClassNumber, CourseID),
  CONSTRAINT CourseID_FK
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
  CONSTRAINT ClassID_FK
  FOREIGN KEY (ClassID)
  REFERENCES "classes" (ClassID)
);

CREATE TABLE "assignments"
(
  AssignmentID               NUMBER(5) PRIMARY KEY,
  CourseID                   NUMBER(5)     NOT NULL,
  AssignmentNumber           NUMBER(5)     NOT NULL,
  AssignmentName             NVARCHAR2(40) NOT NULL,
  AssignmentDueDate          DATE          NOT NULL,
  AssignmentHeader           NVARCHAR2(40) NOT NULL,
  AssignmentChapterReference NVARCHAR2(40) NOT NULL,
  AssignmentDetail           NCLOB         NOT NULL,
  AssignmentIsActive         CHAR(1)       NOT NULL
);