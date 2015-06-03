[2015-06-03 16:04:15] Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
[2015-06-03 16:04:15] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-06-03 16:04:15] 0 row(s) affected in 125 ms
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
[2015-06-03 16:04:15] 0 row(s) affected in 108 ms
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID),
  CONSTRAINT unq_semesters UNIQUE (Name)
)
[2015-06-03 16:04:15] 0 row(s) affected in 107 ms
CREATE TABLE semesters_years (
  ID          NUMBER(5),
  Semester_ID NUMBER(5),
  Year        VARCHAR2(4),
  CONSTRAINT pk_semesters_years PRIMARY KEY (ID),
  CONSTRAINT unq_semesters_years UNIQUE (Semester_ID, Year),
  CONSTRAINT fk_semesters_years_semesters FOREIGN KEY (Semester_ID) REFERENCES semesters (ID)
)
[2015-06-03 16:04:16] 0 row(s) affected in 116 ms
CREATE TABLE classes
(
  ID               NUMBER(5),
  Num              VARCHAR2(6) NOT NULL,
  Course_ID        NUMBER(5)   NOT NULL,
  Semester_Year_ID NUMBER(5)   NOT NULL,
  CONSTRAINT pk_classes PRIMARY KEY (ID),
  CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
  CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID),
  CONSTRAINT fk_classes_semesters_years FOREIGN KEY (Semester_Year_ID) REFERENCES semesters_years (ID)
)
[2015-06-03 16:04:16] 0 row(s) affected in 151 ms
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
[2015-06-03 16:04:16] 0 row(s) affected in 98 ms
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-06-03 16:04:16] 0 row(s) affected in 140 ms
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek),
  CONSTRAINT fk_repeat_days_repeat_events FOREIGN KEY (RepeatEvent_ID) REFERENCES repeat_events (ID)
)
[2015-06-03 16:04:16] 0 row(s) affected in 91 ms
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
[2015-06-03 16:04:16] 0 row(s) affected in 109 ms
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-06-03 16:04:16] 0 row(s) affected in 150 ms
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR2(40) NOT NULL,
  Weight   NUMBER(3)    NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-06-03 16:04:16] 0 row(s) affected in 81 ms
CREATE TABLE textbooks (
  ID     NUMBER(5),
  Title  VARCHAR2(80) NOT NULL,
  Author VARCHAR2(80) NOT NULL,
  ISBN   VARCHAR2(13) NOT NULL,
  CONSTRAINT pk_textbook PRIMARY KEY (ID),
  CONSTRAINT unq_textbook_isbn UNIQUE (ISBN)
)
[2015-06-03 16:04:17] 0 row(s) affected in 168 ms
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  CourseObjective VARCHAR2(2000) NOT NULL,
  PrerequisiteCourse   VARCHAR2(2000) NOT NULL,
  Assignments VARCHAR2(4000) NOT NULL,
  Exams VARCHAR2(4000) NOT NULL,
  ComputerLabs         VARCHAR2(2000) NOT NULL,
  SoftwareRequirements VARCHAR2(2000) NOT NULL,
  HomeworkInfo         VARCHAR2(2000) NOT NULL,
  IsActive             CHAR(1)        NOT NULL,
  CONSTRAINT pk_syllabus_info PRIMARY KEY (ID),
  CONSTRAINT unq_syllabus_info UNIQUE (Course_ID),
  CONSTRAINT fk_syllabus_info_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID),
  CONSTRAINT fk_syllabus_info_courses2 FOREIGN KEY (OfficeHour_ID) REFERENCES courses (ID)
)
[2015-06-03 16:04:17] 0 row(s) affected in 91 ms
CREATE TABLE syllabus_info_textbooks (
  Textbook_ID      NUMBER(5) NOT NULL,
  Syllabus_Info_ID NUMBER(5) NOT NULL,
  CONSTRAINT fk_syllabus_info_textbooks FOREIGN KEY (Textbook_ID) REFERENCES textbooks (ID),
  CONSTRAINT fk_textbooks_syllabus_info FOREIGN KEY (Syllabus_Info_ID) REFERENCES syllabus_info (ID)
)
[2015-06-03 16:04:17] 0 row(s) affected in 24 ms
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID             NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID),
  CONSTRAINT fk_sac_syllabus_info FOREIGN KEY (Syllabus_ID) REFERENCES syllabus_info (ID),
  CONSTRAINT fk_sac_assign_cat FOREIGN KEY (AssignmentCategories_ID) REFERENCES assignment_categories (ID)
)
[2015-06-03 16:04:17] 0 row(s) affected in 92 ms
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  Year     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID),
  CONSTRAINT unq_publishers UNIQUE (Title, Location, Year)
)
[2015-06-03 16:04:17] 0 row(s) affected in 109 ms
CREATE TABLE articles
(
  ID                   NUMBER(5),
  Title                VARCHAR2(120) NOT NULL,
  RelativeFileLocation VARCHAR2(80)  NOT NULL,
  Publisher_ID         NUMBER(5)     NOT NULL,
  PageReference        VARCHAR2(40),
  CONSTRAINT pk_articles PRIMARY KEY (ID),
  CONSTRAINT unq_articles UNIQUE (Title, RelativeFileLocation, Publisher_ID, PageReference),
  CONSTRAINT fk_articles_publisher FOREIGN KEY (Publisher_ID) REFERENCES publishers (ID)
)
[2015-06-03 16:04:17] 0 row(s) affected in 109 ms
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-06-03 16:04:17] 0 row(s) affected in 107 ms
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  Sequence_Number NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-06-03 16:04:17] 0 row(s) affected in 108 ms
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-06-03 16:04:17] 0 row(s) affected in 51 ms

[2015-06-03 16:04:17] Summary: 20 of 20 statements executed in 2195 ms (6680 chars in file)
[2015-06-03 16:21:42] Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
[2015-06-03 16:21:42] Connecting to Oracle - @loree.minotstateu.edu...
CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 18 ms
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 18 ms
CREATE SEQUENCE seq_semesters_years
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 20 ms
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 23 ms
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 13 ms
CREATE SEQUENCE seq_textbooks
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_author_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 16:21:42] 0 row(s) affected in 22 ms

[2015-06-03 16:21:42] Summary: 18 of 18 statements executed in 358 ms (1198 chars in file)

Section 1
Introduction to *nix
System Basics
Shells and Commands

Section 2
File Systems
Managing Files
System Utilities
Text File Utilities
Vim Editor

Section 1 & 2	Exam 1

Section 3
BASH Scripting
Perl Scripting
Python Scripting (if time allows)

Section 3	Exam 2

Section 4
CentOS Setup
System Management Utilities
Web Env. Setup (mail server if time)
Web-based Application Dev. (PHP/JScript/MySQL/etc.)
System Security (IPTables/SELinux/Kerberos)

Section 4	Exam 3

0	Office Hours
111	Introduction to Web Languages
160	Computer Science I
161	Computer Science II
221	Web and Internet Programming
260	UNIX Environment
321	Windows Programming
340	Local Area Networks
356	Database Management
370	Computer Organization and Architecture
440	Data Communications - Wireless Networking and Communications
458	Computer Security
460	Capstone Project Development

208	Discrete Mathematics

Expected Course Schedule
Ch. 1	Introduction to Networks
Ch. 2	Physical Layer
Ch. 3	Data Link Layer
Ch. 1 - 3	Exam 1
Ch. 4	Medium Access Control Sublayer
Ch. 5	Network Layer
Ch. 4, 5	Exam 2
Ch. 6	Transport Layer
Ch. 7	Application Layer
Ch. 7, 8	Exam 3
Ch. 8 (if time)	Network Security
Ch. 1 - 7	Final Exam

Expected Course Schedule
Ch. 1, 2	Introduction to Databases
Ch. 3	Relational Model
Ch. 6	Relational Algebra
Ch. 15	FD, MVD, Normalization
Ch. 16	FD, MVD, Normalization cont.
Ch 1, 2, 3, 6, 15, 16	Exam 1
Ch. 7, 8	ER, EER, UML Models
Ch. 7, 8	ER, EER, UML Models cont.
Ch. 9	ER-, EER-to-Relational
Ch. 10	DB Design, UML
Ch 7, 8, 9, 10	Exam 2
Ch. 17, 18	File Organization, Indexing
Ch. 4, 5	SQL
Ch. 4, 5	SQL
Ch. 4, 5, 17, 18	Exam 3
Ch 1 - 10, 15 - 18	Final Exam

Project: Students will be required to complete a research project on a choosen topic in network or computer security.  Several possible topics will be covered in class but students are allowed to come up with their own topics. Students will be expected to do an in-depth survey of recently published research and propose new approaches to solving the problem on the topic. Students will also be required to provide at least analytical evaluation of the proposed solution to the problem to either prove or disprove their method. Experimental evaluation may also be conducted if time permits, such as through simulations.

Students may work individually or in small groups on the project. If working in a group, tasks of each member must be clearly identified. Students will submit a project proposal outlining the objectives of their project and a plan which includes tasks to be completed by each member of the group. Proposals will be due prior to spring break week. However, students are strongly encouraged to complete their proposal as soon as possible to allow more time to investigate their ideas.

Project groups will be required to present their work at the end of the semester and write a report on their work. Each student or group will be given 25 minutes to present their project at the end. Presentation order will be determined near the end of the semester. Project papers should provide an introduction to the problem, a short survey of related work previously published, the students' approach to solving the problem and a brief analytical evaluation of their approach. Reports will be due by the last lecture day before final exam week.

Project guidelines will be covered in class. Access to papers found on the IEEE and ACM digital libraries will be given during class, office hours or by appointment only.

Project proposal
Weekly progress reports
Project research/work
Project presentation
Project report/paper