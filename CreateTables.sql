DROP TABLE "courses";
DROP TABLE "departments";

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
  ID                NUMBER(5) PRIMARY KEY,
  DepartmentID      NUMBER(5)       NOT NULL,
  CourseNumber      NUMBER(5)       NOT NULL,
  CourseName        NVARCHAR2(40)   NOT NULL,
  CourseDescription NVARCHAR2(2000) NOT NULL,
  CONSTRAINT CourseNumber_Unique
  UNIQUE (DepartmentID, CourseNumber)
);