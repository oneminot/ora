[2015-05-27 14:17:01] Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
[2015-05-27 14:17:01] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-05-27 14:17:02] 0 row(s) affected in 232 ms
CREATE TABLE courses
(
  ID          NUMBER(5),
  Dept_ID     NUMBER(5)      NOT NULL,
  Num         VARCHAR2(6)    NOT NULL,
  Name VARCHAR2(80) NOT NULL,
  Description VARCHAR2(2000) NOT NULL,
  CONSTRAINT pk_courses PRIMARY KEY (ID),
  CONSTRAINT unq_courses UNIQUE (Dept_ID, Num),
  CONSTRAINT fk_courses_departments FOREIGN KEY (Dept_ID) REFERENCES departments (ID)
)
[2015-05-27 14:17:02] 0 row(s) affected in 130 ms
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID)
)
[2015-05-27 14:17:02] 0 row(s) affected in 180 ms
CREATE TABLE semesters_years (
  ID          NUMBER(5),
  Semester_ID NUMBER(5),
  Year VARCHAR2(4),
  CONSTRAINT pk_semesters_years PRIMARY KEY (ID),
  CONSTRAINT unq_semesters_years UNIQUE (Semester_ID, Year)
)
[2015-05-27 14:17:02] 0 row(s) affected in 166 ms
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
[2015-05-27 14:17:03] 0 row(s) affected in 239 ms
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
[2015-05-27 14:17:03] 0 row(s) affected in 178 ms
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-05-27 14:17:03] 0 row(s) affected in 79 ms
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek)
)
[2015-05-27 14:17:03] 0 row(s) affected in 123 ms
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
[2015-05-27 14:17:03] 0 row(s) affected in 303 ms
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-05-27 14:17:04] 0 row(s) affected in 173 ms
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR2(40) NOT NULL,
  Weight   NUMBER(3)    NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-05-27 14:17:04] 0 row(s) affected in 158 ms
CREATE TABLE Textbook (
  ID     NUMBER(5),
  Title  VARCHAR2(80) NOT NULL,
  Author VARCHAR2(80) NOT NULL,
  ISBN   VARCHAR2(13) NOT NULL,
  CONSTRAINT pk_textbook PRIMARY KEY (ID),
  CONSTRAINT unq_textbook_isbn UNIQUE (ISBN)
)
[2015-05-27 14:17:04] 0 row(s) affected in 176 ms
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  Textbook_ID NUMBER(5) NOT NULL,
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
[2015-05-27 14:17:04] 0 row(s) affected in 214 ms
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID)
)
[2015-05-27 14:17:04] 0 row(s) affected in 151 ms
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  YEAR     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID)
)
[2015-05-27 14:17:04] 0 row(s) affected in 150 ms
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
[2015-05-27 14:17:05] 0 row(s) affected in 132 ms
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-05-27 14:17:05] 0 row(s) affected in 251 ms
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-05-27 14:17:05] 0 row(s) affected in 82 ms
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-05-27 14:17:05] 0 row(s) affected in 133 ms

[2015-05-27 14:17:05] Summary: 19 of 19 statements executed in 3571 ms (5663 chars in file)


[2015-05-27 14:17:21] Run C:\Users\minot_000\Source\Repos\ora\CreateSequences
[2015-05-27 14:17:21] Connecting to Oracle - @loree.minotstateu.edu...
CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:21] 0 row(s) affected in 48 ms
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:21] 0 row(s) affected in 35 ms
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:21] 0 row(s) affected in 33 ms
CREATE SEQUENCE seq_semesters_years
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:21] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 35 ms
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 37 ms
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 34 ms
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 31 ms
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 38 ms
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 35 ms
CREATE SEQUENCE seq_textbook
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 35 ms
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 38 ms
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 33 ms
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-27 14:17:22] 0 row(s) affected in 32 ms

[2015-05-27 14:17:22] Summary: 17 of 17 statements executed in 839 ms (1126 chars in file)


[2015-05-27 14:17:40] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-05-27 14:17:40] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-05-27 14:17:40] 1 row(s) affected in 39 ms
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-05-27 14:17:40] 1 row(s) affected in 38 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-05-27 14:17:41] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-05-27 14:17:41] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-05-27 14:17:41] 1 row(s) affected in 33 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-05-27 14:17:41] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '260', 'UNIX Environment',
                                              'UNIX')
[2015-05-27 14:17:41] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-05-27 14:17:41] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-05-27 14:17:41] 1 row(s) affected in 58 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-05-27 14:17:41] 1 row(s) affected in 41 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-05-27 14:17:41] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-05-27 14:17:41] 1 row(s) affected in 33 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-05-27 14:17:41] 1 row(s) affected in 43 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-05-27 14:17:41] 1 row(s) affected in 39 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 2, '208', 'Discrete Mathematics',
                                              'Discrete Math')
[2015-05-27 14:17:41] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Fall')
[2015-05-27 14:17:41] 1 row(s) affected in 35 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Spring')
[2015-05-27 14:17:41] 1 row(s) affected in 39 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Summer')
[2015-05-27 14:17:41] 1 row(s) affected in 34 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2010')
[2015-05-27 14:17:41] 1 row(s) affected in 127 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2011')
[2015-05-27 14:17:41] 1 row(s) affected in 37 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2011')
[2015-05-27 14:17:41] 1 row(s) affected in 31 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2012')
[2015-05-27 14:17:41] 1 row(s) affected in 33 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2013')
[2015-05-27 14:17:41] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2014')
[2015-05-27 14:17:41] 1 row(s) affected in 34 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2014')
[2015-05-27 14:17:41] 1 row(s) affected in 36 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2015')
[2015-05-27 14:17:41] 1 row(s) affected in 35 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 3, '2015')
[2015-05-27 14:17:42] 1 row(s) affected in 33 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '19567', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '160' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2010' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 40 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '20627', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '111' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2010' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 33 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '20012', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '111' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2010' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 33 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '6132', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '458' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 31 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '19667', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '440' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 32 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '3645', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '370' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 32 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '19670', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '160' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 44 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '6630', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '160' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 38 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '7055', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '111' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 32 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '6863', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '111' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2011' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 41 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4668', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '160' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2012' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 40 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4458', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '370' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2012' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 37 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4457', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '161' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2012' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 36 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4876', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '160' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2012' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 33 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '13416', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '356' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2013' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 43 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '13414', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '340' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2013' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 38 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '13412', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '260' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2013' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 39 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '5286', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '460' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 40 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '5518', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '440' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 34 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '5285', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '370' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 41 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '5132', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '321' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 39 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '12104', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '356' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 33 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '12102', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '340' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 33 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '12317', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '221' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 1 AND year = '2014' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 40 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4295', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '460' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2015' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:42] 1 row(s) affected in 42 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4431', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '440' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2015' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:43] 1 row(s) affected in 40 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4294', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '370' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2015' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:43] 1 row(s) affected in 34 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '26115', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'CSCI'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '356' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2015' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:43] 1 row(s) affected in 38 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '4154', (SELECT ID
                                                                                                 FROM COURSES
                                                                                                 WHERE
                                                                                                   DEPT_ID = (SELECT ID
                                                                                                              FROM
                                                                                                                DEPARTMENTS
                                                                                                              WHERE
                                                                                                                NAME =
                                                                                                                'CSCI'
                                                                                                                AND
                                                                                                                ROWNUM =
                                                                                                                1) AND
                                                                                                   NUM = '321' AND
                                                                                                   ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 2 AND year = '2015' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:43] 1 row(s) affected in 45 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES (SEQ_CLASSES.nextval, '10930', (SELECT ID
                                                                                                  FROM COURSES
                                                                                                  WHERE
                                                                                                    DEPT_ID = (SELECT ID
                                                                                                               FROM
                                                                                                                 DEPARTMENTS
                                                                                                               WHERE
                                                                                                                 NAME =
                                                                                                                 'MATH'
                                                                                                                 AND
                                                                                                                 ROWNUM
                                                                                                                 = 1)
                                                                                                    AND NUM = '208' AND
                                                                                                    ROWNUM = 1),
                                                                   (SELECT ID
                                                                    FROM semesters_years
                                                                    WHERE SEMESTER_ID = 3 AND year = '2015' AND
                                                                          ROWNUM = 1))
[2015-05-27 14:17:43] 1 row(s) affected in 38 ms

[2015-05-27 14:17:43] Summary: 57 of 57 statements executed in 2513 ms (67632 chars in file)
