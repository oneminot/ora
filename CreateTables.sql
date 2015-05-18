CREATE TABLE departments
  (
    ID   NUMBER(5),
    Name VARCHAR2(4) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (ID),
    CONSTRAINT unq_departments UNIQUE (Name)
  );
CREATE TABLE courses
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
CREATE TABLE semesters
  (
    ID   NUMBER(5),
    Name VARCHAR2(40) NOT NULL,
    Year VARCHAR2(4) NOT NULL,
    CONSTRAINT pk_semesters PRIMARY KEY (ID),
    CONSTRAINT unq_semesters UNIQUE (Name, Year)
  );
CREATE TABLE classes
  (
    ID          NUMBER(5),
    Num         VARCHAR2(6) NOT NULL,
    Course_ID   NUMBER(5) NOT NULL,
    Semester_ID NUMBER(5) NOT NULL,
    CONSTRAINT pk_classes PRIMARY KEY (ID),
    CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
    CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES "courses" (ID)
  );
CREATE TABLE events
  (
    ID        NUMBER(5),
    Class_ID  NUMBER(5) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate   DATE NOT NULL,
    StartTime DATE NOT NULL,
    EndTime   DATE NOT NULL,
    CONSTRAINT pk_events PRIMARY KEY (ID),
    CONSTRAINT unq_events UNIQUE (StartDate, EndDate, Class_ID),
    CONSTRAINT fk_events_classes FOREIGN KEY (Class_ID) REFERENCES "classes" (ID)
  );
CREATE TABLE repeatevents
  (
    ID            NUMBER(5),
    Event_ID      NUMBER(5) NOT NULL,
    StartDateTime DATE NOT NULL,
    EndDateTime   DATE NOT NULL,
    CONSTRAINT pk_repeatevents PRIMARY KEY (ID),
    CONSTRAINT fk_repeatevents_events FOREIGN KEY (Event_ID) REFERENCES "events" (ID)
  );
CREATE TABLE repeatday
  (
    RepeatEvent_ID  NUMBER (5),
    DayNumberOfWeek NUMBER(1),
    CONSTRAINT pk_repeatday PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek)
  );
CREATE TABLE assignments
  (
    ID               NUMBER(5),
    Course_ID        NUMBER(5) NOT NULL,
    Num              VARCHAR2(5) NOT NULL,
    Name             VARCHAR2(40) NOT NULL,
    DueDate          DATE NOT NULL,
    Header           VARCHAR2(40) NOT NULL,
    ChapterReference VARCHAR2(40) NOT NULL,
    Detail CLOB NOT NULL,
    IsActive CHAR(1) NOT NULL,
    CONSTRAINT pk_assignments PRIMARY KEY (ID),
    CONSTRAINT fk_assignments_courses FOREIGN KEY (Course_ID) REFERENCES "courses" (ID)
  );
CREATE TABLE gradescales
  (
    ID     NUMBER(5),
    Low    NUMBER(3) NOT NULL,
    High   NUMBER(3) NOT NULL,
    Letter CHAR(1) NOT NULL,
    CONSTRAINT pk_gradescales PRIMARY KEY (ID),
    CONSTRAINT unq_gradescales UNIQUE (Low, High, Letter)
  );
CREATE TABLE assignmentcategory
  (
    ID       NUMBER(5),
    Category VARCHAR(40) NOT NULL,
    Weight   NUMBER(3) NOT NULL,
    CONSTRAINT pk_assignmentcategory PRIMARY KEY (ID),
    CONSTRAINT unq_assignmentcategory UNIQUE (Category, Weight)
  );
CREATE TABLE syllabusinfo
  (
    ID            NUMBER(5),
    Course_ID     NUMBER(5) NOT NULL,
    OfficeHour_ID NUMBER(5) NOT NULL,
    Textbook      VARCHAR2(2000) NOT NULL,
    CourseObjective CLOB NOT NULL,
    PrerequisiteCourse VARCHAR2(2000) NOT NULL,
    ComputerLabs         VARCHAR2(2000) NOT NULL,
    SoftwareRequirements VARCHAR2(2000) NOT NULL,
    HomeworkInfo         VARCHAR2(2000) NOT NULL,
    IsActive             CHAR(1) NOT NULL,
    CONSTRAINT pk_syllabusinfo PRIMARY KEY (ID),
    CONSTRAINT unq_syllabusinfo UNIQUE (Course_ID),
    CONSTRAINT fk_syllabusheaders_courses FOREIGN KEY (Course_ID) REFERENCES "courses" (ID),
    CONSTRAINT fk_syllabusheaders_courses2 FOREIGN KEY (OfficeHour_ID) REFERENCES "courses" (ID)
  );
  create table syllabusassignmentcategory
  (
  Syllabus_ID number(5),
  AssignmentCategory_ID number(5),
  constraint pk_syllabusassignmentcategory primary key (Syllabus_ID, AssignmentCategory_ID)
  );
CREATE TABLE publications
  (
    ID       NUMBER(5),
    Title    VARCHAR2(80) NOT NULL,
    Location VARCHAR2(80) NOT NULL,
    YEAR     VARCHAR2(4),
    CONSTRAINT pk_publications PRIMARY KEY (ID)
  );
CREATE TABLE articles
  (
    ID                   NUMBER(5),
    Title                VARCHAR2(80) NOT NULL,
    RelativeFileLocation VARCHAR2(80) NOT NULL,
    Publication_ID       NUMBER(5) NOT NULL,
    PageReference        VARCHAR2(40),
    CONSTRAINT pk_articles PRIMARY KEY (ID),
    CONSTRAINT unq_articles UNIQUE (Title, RelativeFileLocation, Publication_ID, PageReference),
    CONSTRAINT fk_articles_publications FOREIGN KEY (Publication_ID) REFERENCES "publications" (ID)
  );
CREATE TABLE authors
  (
    ID   NUMBER(5),
    Name VARCHAR2(40) NOT NULL,
    CONSTRAINT pk_authors PRIMARY KEY (ID),
    CONSTRAINT unq_authors UNIQUE (Name)
  );
CREATE TABLE authorarticles
  (
    Author_ID  NUMBER(5) NOT NULL,
    Article_ID NUMBER(5) NOT NULL,
    CONSTRAINT pk_authorarticles PRIMARY KEY (Author_ID, Article_ID),
    CONSTRAINT fk_authorarticles_authors FOREIGN KEY (Author_ID) REFERENCES "authors" (ID),
    CONSTRAINT fk_authorarticles_articles FOREIGN KEY (Article_ID) REFERENCES "articles" (ID)
  );
CREATE TABLE administrationusers
  (
    ID           NUMBER(5) NOT NULL,
    Name         VARCHAR2(255) NOT NULL,
    Password     VARCHAR2(2000) NOT NULL,
    AttemptCount NUMBER(5) NOT NULL,
    LastAttempt  TIMESTAMP NOT NULL,
    CONSTRAINT pk_administrationusers PRIMARY KEY (ID)
  );
