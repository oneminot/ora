[2015-05-29 19:23:43] Run C:\Users\CS\Documents\kus\ora\CreateTables.sql
[2015-05-29 19:23:43] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-05-29 19:23:43] 0 row(s) affected in 125 ms
CREATE TABLE courses
(
  ID          NUMBER(5),
  Dept_ID     NUMBER(5)      NOT NULL,
  Num         VARCHAR2(6)    NOT NULL,
  Name        VARCHAR2(80)   NOT NULL,
  Description VARCHAR2(2000) NOT NULL,
  CONSTRAINT pk_courses PRIMARY KEY (ID),
  CONSTRAINT unq_courses UNIQUE (Dept_ID, Num),
  CONSTRAINT fk_courses_departments FOREIGN KEY (Dept_ID) REFERENCES departments (ID)
)
[2015-05-29 19:23:44] 0 row(s) affected in 172 ms
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID)
)
[2015-05-29 19:23:44] 0 row(s) affected in 107 ms
CREATE TABLE semesters_years (
  ID          NUMBER(5),
  Semester_ID NUMBER(5),
  Year        VARCHAR2(4),
  CONSTRAINT pk_semesters_years PRIMARY KEY (ID),
  CONSTRAINT unq_semesters_years UNIQUE (Semester_ID, Year)
)
[2015-05-29 19:23:44] 0 row(s) affected in 168 ms
CREATE TABLE classes
(
  ID               NUMBER(5),
  Num              VARCHAR2(6) NOT NULL,
  Course_ID        NUMBER(5)   NOT NULL,
  Semester_Year_ID NUMBER(5)   NOT NULL,
  CONSTRAINT pk_classes PRIMARY KEY (ID),
  CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
  CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID)
)
[2015-05-29 19:23:44] 0 row(s) affected in 153 ms
CREATE TABLE events
(
  ID        NUMBER(5),
  Class_ID  NUMBER(5) NOT NULL,
  StartDate DATE      NOT NULL,
  EndDate   DATE      NOT NULL,
  StartTime DATE      NOT NULL,
  EndTime   DATE      NOT NULL,
  CONSTRAINT pk_events PRIMARY KEY (ID),
  CONSTRAINT unq_events UNIQUE (StartDate, EndDate, Class_ID),
  CONSTRAINT fk_events_classes FOREIGN KEY (Class_ID) REFERENCES classes (ID)
)
[2015-05-29 19:23:44] 0 row(s) affected in 142 ms
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-05-29 19:23:44] 0 row(s) affected in 104 ms
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek)
)
[2015-05-29 19:23:44] 0 row(s) affected in 140 ms
CREATE TABLE assignments
(
  ID               NUMBER(5),
  Course_ID        NUMBER(5)    NOT NULL,
  Num              VARCHAR2(5)  NOT NULL,
  Name             VARCHAR2(40) NOT NULL,
  DueDate          DATE         NOT NULL,
  Header           VARCHAR2(40) NOT NULL,
  ChapterReference VARCHAR2(40) NOT NULL,
  Detail           CLOB         NOT NULL,
  IsActive         CHAR(1)      NOT NULL,
  CONSTRAINT pk_assignments PRIMARY KEY (ID),
  CONSTRAINT fk_assignments_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID)
)
[2015-05-29 19:23:45] 0 row(s) affected in 150 ms
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-05-29 19:23:45] 0 row(s) affected in 140 ms
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR2(40) NOT NULL,
  Weight   NUMBER(3)    NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-05-29 19:23:45] 0 row(s) affected in 199 ms
CREATE TABLE Textbook (
  ID     NUMBER(5),
  Title  VARCHAR2(80) NOT NULL,
  Author VARCHAR2(80) NOT NULL,
  ISBN   VARCHAR2(13) NOT NULL,
  CONSTRAINT pk_textbook PRIMARY KEY (ID),
  CONSTRAINT unq_textbook_isbn UNIQUE (ISBN)
)
[2015-05-29 19:23:45] 0 row(s) affected in 138 ms
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  Textbook_ID          NUMBER(5)      NOT NULL,
  CourseObjective      CLOB           NOT NULL,
  PrerequisiteCourse   VARCHAR2(2000) NOT NULL,
  ComputerLabs         VARCHAR2(2000) NOT NULL,
  SoftwareRequirements VARCHAR2(2000) NOT NULL,
  HomeworkInfo         VARCHAR2(2000) NOT NULL,
  IsActive             CHAR(1)        NOT NULL,
  CONSTRAINT pk_syllabus_info PRIMARY KEY (ID),
  CONSTRAINT unq_syllabus_info UNIQUE (Course_ID),
  CONSTRAINT fk_syllabus_info_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID),
  CONSTRAINT fk_syllabus_info_courses2 FOREIGN KEY (OfficeHour_ID) REFERENCES courses (ID)
)
[2015-05-29 19:23:45] 0 row(s) affected in 242 ms
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID             NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID)
)
[2015-05-29 19:23:45] 0 row(s) affected in 141 ms
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  YEAR     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID)
)
[2015-05-29 19:23:45] 0 row(s) affected in 64 ms
CREATE TABLE articles
(
  ID                   NUMBER(5),
  Title                VARCHAR2(80) NOT NULL,
  RelativeFileLocation VARCHAR2(80) NOT NULL,
  Publisher_ID         NUMBER(5)    NOT NULL,
  PageReference        VARCHAR2(40),
  CONSTRAINT pk_articles PRIMARY KEY (ID),
  CONSTRAINT unq_articles UNIQUE (Title, RelativeFileLocation, Publisher_ID, PageReference),
  CONSTRAINT fk_articles_publisher FOREIGN KEY (Publisher_ID) REFERENCES publishers (ID)
)
[2015-05-29 19:23:46] 0 row(s) affected in 194 ms
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-05-29 19:23:46] 0 row(s) affected in 197 ms
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-05-29 19:23:46] 0 row(s) affected in 125 ms
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-05-29 19:23:46] 0 row(s) affected in 237 ms

[2015-05-29 19:23:46] Summary: 19 of 19 statements executed in 3059 ms (5705 chars in file)

CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_semesters_years
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_textbook
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE;

[2015-05-29 19:24:17] Run C:\Users\CS\Documents\kus\ora\CreateTables.sql
[2015-05-29 19:24:17] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE courses
(
  ID          NUMBER(5),
  Dept_ID     NUMBER(5)      NOT NULL,
  Num         VARCHAR2(6)    NOT NULL,
  Name        VARCHAR2(80)   NOT NULL,
  Description VARCHAR2(2000) NOT NULL,
  CONSTRAINT pk_courses PRIMARY KEY (ID),
  CONSTRAINT unq_courses UNIQUE (Dept_ID, Num),
  CONSTRAINT fk_courses_departments FOREIGN KEY (Dept_ID) REFERENCES departments (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE semesters_years (
  ID          NUMBER(5),
  Semester_ID NUMBER(5),
  Year        VARCHAR2(4),
  CONSTRAINT pk_semesters_years PRIMARY KEY (ID),
  CONSTRAINT unq_semesters_years UNIQUE (Semester_ID, Year)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE classes
(
  ID               NUMBER(5),
  Num              VARCHAR2(6) NOT NULL,
  Course_ID        NUMBER(5)   NOT NULL,
  Semester_Year_ID NUMBER(5)   NOT NULL,
  CONSTRAINT pk_classes PRIMARY KEY (ID),
  CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
  CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE events
(
  ID        NUMBER(5),
  Class_ID  NUMBER(5) NOT NULL,
  StartDate DATE      NOT NULL,
  EndDate   DATE      NOT NULL,
  StartTime DATE      NOT NULL,
  EndTime   DATE      NOT NULL,
  CONSTRAINT pk_events PRIMARY KEY (ID),
  CONSTRAINT unq_events UNIQUE (StartDate, EndDate, Class_ID),
  CONSTRAINT fk_events_classes FOREIGN KEY (Class_ID) REFERENCES classes (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE assignments
(
  ID               NUMBER(5),
  Course_ID        NUMBER(5)    NOT NULL,
  Num              VARCHAR2(5)  NOT NULL,
  Name             VARCHAR2(40) NOT NULL,
  DueDate          DATE         NOT NULL,
  Header           VARCHAR2(40) NOT NULL,
  ChapterReference VARCHAR2(40) NOT NULL,
  Detail           CLOB         NOT NULL,
  IsActive         CHAR(1)      NOT NULL,
  CONSTRAINT pk_assignments PRIMARY KEY (ID),
  CONSTRAINT fk_assignments_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR2(40) NOT NULL,
  Weight   NUMBER(3)    NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE Textbook (
  ID     NUMBER(5),
  Title  VARCHAR2(80) NOT NULL,
  Author VARCHAR2(80) NOT NULL,
  ISBN   VARCHAR2(13) NOT NULL,
  CONSTRAINT pk_textbook PRIMARY KEY (ID),
  CONSTRAINT unq_textbook_isbn UNIQUE (ISBN)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  Textbook_ID          NUMBER(5)      NOT NULL,
  CourseObjective      CLOB           NOT NULL,
  PrerequisiteCourse   VARCHAR2(2000) NOT NULL,
  ComputerLabs         VARCHAR2(2000) NOT NULL,
  SoftwareRequirements VARCHAR2(2000) NOT NULL,
  HomeworkInfo         VARCHAR2(2000) NOT NULL,
  IsActive             CHAR(1)        NOT NULL,
  CONSTRAINT pk_syllabus_info PRIMARY KEY (ID),
  CONSTRAINT unq_syllabus_info UNIQUE (Course_ID),
  CONSTRAINT fk_syllabus_info_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID),
  CONSTRAINT fk_syllabus_info_courses2 FOREIGN KEY (OfficeHour_ID) REFERENCES courses (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID             NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  YEAR     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE articles
(
  ID                   NUMBER(5),
  Title                VARCHAR2(80) NOT NULL,
  RelativeFileLocation VARCHAR2(80) NOT NULL,
  Publisher_ID         NUMBER(5)    NOT NULL,
  PageReference        VARCHAR2(40),
  CONSTRAINT pk_articles PRIMARY KEY (ID),
  CONSTRAINT unq_articles UNIQUE (Title, RelativeFileLocation, Publisher_ID, PageReference),
  CONSTRAINT fk_articles_publisher FOREIGN KEY (Publisher_ID) REFERENCES publishers (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-05-29 19:24:18] [42000][955] ORA-00955: name is already used by an existing object

[2015-05-29 19:24:18] Summary: 19 of 19 statements executed, 19 failed in 252 ms (5705 chars in file)

[2015-05-29 19:24:28] Run C:\Users\CS\Documents\kus\ora\CreateSequences.sql
[2015-05-29 19:24:28] Connecting to Oracle - @loree.minotstateu.edu...
CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_semesters_years
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_textbook
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-29 19:24:28] [42000][955] ORA-00955: name is already used by an existing object

[2015-05-29 19:24:28] Summary: 17 of 17 statements executed, 17 failed in 202 ms (1126 chars in file)

