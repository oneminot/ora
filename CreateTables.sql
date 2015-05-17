CREATE TABLE "departments"
  (
    ID         NUMBER(5),
    Identifier VARCHAR2(5) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (ID),
    CONSTRAINT unq_departments UNIQUE (Identifier)
  );
CREATE TABLE "courses"
  (
    ID          NUMBER(5),
    Dept_ID     NUMBER(5) NOT NULL,
    Num         VARCHAR2(6) NOT NULL,
    Name        VARCHAR2(40) NOT NULL,
    Description VARCHAR2(2000) NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (ID),
    CONSTRAINT unq_courses UNIQUE (Dept_ID, Num),
    CONSTRAINT fk_courses_departments FOREIGN KEY (Dept_ID) REFERENCES "departments" (ID)
  );
CREATE TABLE "semesters"
  (
    ID   NUMBER(5),
    Name VARCHAR2(40) NOT NULL,
    YEAR VARCHAR2(4) NOT NULL,
    CONSTRAINT pk_semesters PRIMARY KEY (Id),
    CONSTRAINT unq_semesters UNIQUE (Name, YEAR)
  );
CREATE TABLE "classes"
  (
    ID          NUMBER(5),
    Num         VARCHAR2(6) NOT NULL,
    Course_ID   NUMBER(5) NOT NULL,
    Semester_ID NUMBER(5) NOT NULL,
    CONSTRAINT pk_classes PRIMARY KEY (ID),
    CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
    CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES "courses" (ID)
  );
CREATE TABLE "events"
  (
    ID          NUMBER(5),
    Class_ID    NUMBER(5) NOT NULL,
    StartDate   DATE NOT NULL,
    EndDate     DATE NOT NULL,
    StartTime   DATE NOT NULL,
    EndTime     DATE NOT NULL,
    IsMonday    CHAR(1) NOT NULL,
    IsTuesday   CHAR(1) NOT NULL,
    IsWednesday CHAR(1) NOT NULL,
    IsThursday  CHAR(1) NOT NULL,
    IsFriday    CHAR(1) NOT NULL,
    CONSTRAINT pk_events PRIMARY KEY (ID),
    CONSTRAINT unq_events UNIQUE (StartDate, EndDate, Class_ID),
    CONSTRAINT fk_events_classes FOREIGN KEY (Class_ID) REFERENCES "classes" (ID)
  );
CREATE TABLE "assignments"
  (
    ID               NUMBER(5),
    Course_ID        NUMBER(5) NOT NULL,
    Num              VARCHAR2(5) NOT NULL,
    Name             VARCHAR2(40) NOT NULL,
    DueDate          DATE NOT NULL,
    Header           VARCHAR2(40) NOT NULL,
    ChapterReference VARCHAR2(40) NOT NULL,
    Detail NCLOB NOT NULL,
    IsActive CHAR(1) NOT NULL,
    CONSTRAINT pk_assignments PRIMARY KEY (ID),
    CONSTRAINT fk_assignments_courses FOREIGN KEY (Course_ID) REFERENCES "courses" (ID)
  );
CREATE TABLE "syllabi"
  (
    ID               NUMBER(5),
    Course_ID        NUMBER(5) NOT NULL,
    SyllabusIsActive CHAR(1) NOT NULL,
    CONSTRAINT syllabusid_pk PRIMARY KEY (ID)
  );
CREATE TABLE "articles"
  (
    ArticleID            NUMBER(5),
    ArticleTitle         VARCHAR2(80) NOT NULL,
    RelativeFileLocation VARCHAR2(80) NOT NULL,
    PublicationID        NUMBER(5) NOT NULL,
    PageReference        VARCHAR2(40),
    CONSTRAINT articleid_pk PRIMARY KEY (ArticleID),
    CONSTRAINT articles_unique UNIQUE (ArticleTitle, RelativeFileLocation, PublicationID, PageReference)
  );
CREATE TABLE "authors"
  (
    AuthorID   NUMBER(5),
    AuthorName VARCHAR2(40) NOT NULL,
    CONSTRAINT authorid_pk PRIMARY KEY (AuthorID),
    CONSTRAINT authorname_unique UNIQUE (AuthorName)
  );
CREATE TABLE "publications"
  (
    PublicationID       NUMBER(5),
    PublicationTitle    VARCHAR2(80) NOT NULL,
    PublicationLocation VARCHAR2(80) NOT NULL,
    PublicationYear     VARCHAR2(4),
    CONSTRAINT publicationid_pk PRIMARY KEY (PublicationID)
  );
CREATE TABLE "authorarticles"
  (
    AuthorArticleID NUMBER(5),
    AuthorID        NUMBER(5) NOT NULL,
    ArticleID       NUMBER(5) NOT NULL,
    CONSTRAINT authorarticleid_pk PRIMARY KEY (AuthorArticleID),
    CONSTRAINT authorarticles_unique UNIQUE (AuthorID, ArticleID),
    CONSTRAINT authors_authorarticles_fk FOREIGN KEY (AuthorID) REFERENCES "authors" (AuthorID)
  );
CREATE TABLE "administrationusers"
  (
    AdministrationUserID           NUMBER(5) NOT NULL,
    AdministrationUserName         VARCHAR2(255) NOT NULL,
    AdministrationUserSalt         VARCHAR2(2000) NOT NULL,
    AdministrationUserPassword     VARCHAR2(2000) NOT NULL,
    AdministrationUserAttemptCount NUMBER(5) NOT NULL,
    AdministrationUserLastAttempt  TIMESTAMP NOT NULL,
    CONSTRAINT administrationuserid_pk PRIMARY KEY (AdministrationUserID)
  );
