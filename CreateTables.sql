CREATE TABLE "departments"
(
  DepartmentID NUMBER(5),
  DepartmentIdentifier NVARCHAR2(5)  NOT NULL,
  DepartmentName       NVARCHAR2(40) NOT NULL,
  CONSTRAINT departmentid_pk PRIMARY KEY (DepartmentID),
  CONSTRAINT departmentidentifier_unique
  UNIQUE (DepartmentIdentifier)
);

CREATE SEQUENCE "departments_sequence"
START WITH 1
INCREMENT BY 1;

CREATE TABLE "courses"
(
  CourseID NUMBER(5),
  DepartmentID      NUMBER(5)       NOT NULL,
  CourseNumber NVARCHAR2(6) NOT NULL,
  CourseName        NVARCHAR2(40)   NOT NULL,
  CourseDescription NVARCHAR2(2000) NOT NULL,
  CONSTRAINT courseid_pk PRIMARY KEY (CourseID),
  CONSTRAINT coursenumber_unique
  UNIQUE (DepartmentID, CourseNumber),
  CONSTRAINT departments_courses_fk
  FOREIGN KEY (DepartmentID)
  REFERENCES "departments" (DepartmentID)
);

CREATE TABLE "classes"
(
  ClassID NUMBER(5),
  ClassNumber NVARCHAR2(6) NOT NULL,
  CourseID    NUMBER(5)    NOT NULL,
  CONSTRAINT classid_pk PRIMARY KEY (ClassID),
  CONSTRAINT classnumber_unique
  UNIQUE (ClassNumber, CourseID),
  CONSTRAINT courses_classes_fk
  FOREIGN KEY (CourseID)
  REFERENCES "courses" (CourseID)
);

CREATE TABLE "events"
(
  EventID NUMBER(5),
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
  CONSTRAINT eventid_pk PRIMARY KEY (EventID),
  CONSTRAINT startdate_unique
  UNIQUE (StartDate, EndDate, ClassID),
  CONSTRAINT classes_events_fk
  FOREIGN KEY (ClassID)
  REFERENCES "classes" (ClassID)
);

CREATE TABLE "assignments"
(
  AssignmentID       NUMBER(5),
  CourseID                   NUMBER(5)     NOT NULL,
  AssignmentNumber NVARCHAR2(5) NOT NULL,
  AssignmentName             NVARCHAR2(40) NOT NULL,
  AssignmentDueDate          DATE          NOT NULL,
  AssignmentHeader           NVARCHAR2(40) NOT NULL,
  AssignmentChapterReference NVARCHAR2(40) NOT NULL,
  AssignmentDetail           NCLOB         NOT NULL,
  AssignmentIsActive CHAR(1) NOT NULL,
  CONSTRAINT assignmentid_pk PRIMARY KEY (AssignmentID)
);

CREATE TABLE "articles" (
  ArticleID NUMBER(5),
  ArticleTitle         NVARCHAR2(80) NOT NULL,
  RelativeFileLocation NVARCHAR2(80) NOT NULL,
  PublicationID        NUMBER(5)     NOT NULL,
  PageReference        NVARCHAR2(40),
  CONSTRAINT articleid_pk PRIMARY KEY (ArticleID),
  CONSTRAINT articles_unique
  UNIQUE (ArticleTitle, RelativeFileLocation, PublicationID, PageReference)
);

CREATE TABLE "authors"
(
  AuthorID NUMBER(5),
  AuthorName NVARCHAR2(40) NOT NULL,
  CONSTRAINT authorid_pk PRIMARY KEY (AuthorID),
  CONSTRAINT authorname_unique
  UNIQUE (AuthorName)
);

CREATE TABLE "publications"
(
  PublicationID   NUMBER(5),
  PublicationTitle    NVARCHAR2(80) NOT NULL,
  PublicationLocation NVARCHAR2(80) NOT NULL,
  PublicationYear VARCHAR2(4),
  CONSTRAINT publicationid_pk PRIMARY KEY (PublicationID)
);

CREATE TABLE "authorarticles"
(
  AuthorArticleID NUMBER(5) PRIMARY KEY,
  AuthorID        NUMBER(5) NOT NULL,
  ArticleID       NUMBER(5) NOT NULL,
  CONSTRAINT authorarticleid_pk PRIMARY KEY (AuthorArticleID),
  CONSTRAINT authorarticles_unique
  UNIQUE (AuthorID, ArticleID),
  CONSTRAINT authors_authorarticles_fk
  FOREIGN KEY (AuthorID)
  REFERENCES "authors" (AuthorID)
);

CREATE TABLE "administrationusers" (
  AdministrationUserID          NUMBER(5) NOT NULL,
  AdministrationUserName         NVARCHAR2(255)        NOT NULL,
  AdministrationUserSalt         NVARCHAR2(2000)       NOT NULL,
  AdministrationUserPassword     NVARCHAR2(2000)       NOT NULL,
  AdministrationUserAttemptCount NUMBER(5)             NOT NULL,
  AdministrationUserLastAttempt TIMESTAMP NOT NULL,
  CONSTRAINT administrationuserid_pk PRIMARY KEY (AdministrationUserID)
);