[2015-06-03 18:03:25] Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
[2015-06-03 18:03:25] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-06-03 18:03:25] 0 row(s) affected in 116 ms
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
[2015-06-03 18:03:26] 0 row(s) affected in 133 ms
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID),
  CONSTRAINT unq_semesters UNIQUE (Name)
)
[2015-06-03 18:03:26] 0 row(s) affected in 116 ms
CREATE TABLE semesters_years (
  ID          NUMBER(5),
  Semester_ID NUMBER(5),
  Year        VARCHAR2(4),
  CONSTRAINT pk_semesters_years PRIMARY KEY (ID),
  CONSTRAINT unq_semesters_years UNIQUE (Semester_ID, Year),
  CONSTRAINT fk_semesters_years_semesters FOREIGN KEY (Semester_ID) REFERENCES semesters (ID)
)
[2015-06-03 18:03:26] 0 row(s) affected in 125 ms
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
[2015-06-03 18:03:26] 0 row(s) affected in 149 ms
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
[2015-06-03 18:03:26] 0 row(s) affected in 159 ms
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-06-03 18:03:26] 0 row(s) affected in 74 ms
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek),
  CONSTRAINT fk_repeat_days_repeat_events FOREIGN KEY (RepeatEvent_ID) REFERENCES repeat_events (ID)
)
[2015-06-03 18:03:26] 0 row(s) affected in 91 ms
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
[2015-06-03 18:03:26] 0 row(s) affected in 183 ms
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-06-03 18:03:26] 0 row(s) affected in 91 ms
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR2(40) NOT NULL,
  Weight   NUMBER(3)    NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-06-03 18:03:27] 0 row(s) affected in 134 ms
CREATE TABLE textbooks (
  ID     NUMBER(5),
  Title  VARCHAR2(80) NOT NULL,
  Author VARCHAR2(80) NOT NULL,
  ISBN   VARCHAR2(13) NOT NULL,
  CONSTRAINT pk_textbook PRIMARY KEY (ID),
  CONSTRAINT unq_textbook_isbn UNIQUE (ISBN)
)
[2015-06-03 18:03:27] 0 row(s) affected in 98 ms
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  CourseObjective VARCHAR2(2000) NOT NULL,
  PrerequisiteCourse   VARCHAR2(2000) NOT NULL,
  Assignments     VARCHAR2(4000) NOT NULL,
  Exams           VARCHAR2(4000) NOT NULL,
  ComputerLabs         VARCHAR2(2000) NOT NULL,
  SoftwareRequirements VARCHAR2(2000) NOT NULL,
  HomeworkInfo         VARCHAR2(2000) NOT NULL,
  IsActive             CHAR(1)        NOT NULL,
  CONSTRAINT pk_syllabus_info PRIMARY KEY (ID),
  CONSTRAINT unq_syllabus_info UNIQUE (Course_ID),
  CONSTRAINT fk_syllabus_info_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID),
  CONSTRAINT fk_syllabus_info_courses2 FOREIGN KEY (OfficeHour_ID) REFERENCES courses (ID)
)
[2015-06-03 18:03:27] 0 row(s) affected in 118 ms
CREATE TABLE syllabus_info_textbooks (
  Textbook_ID      NUMBER(5) NOT NULL,
  Syllabus_Info_ID NUMBER(5) NOT NULL,
  CONSTRAINT fk_syllabus_info_textbooks FOREIGN KEY (Textbook_ID) REFERENCES textbooks (ID),
  CONSTRAINT fk_textbooks_syllabus_info FOREIGN KEY (Syllabus_Info_ID) REFERENCES syllabus_info (ID)
)
[2015-06-03 18:03:27] 0 row(s) affected in 89 ms
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID             NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID),
  CONSTRAINT fk_sac_syllabus_info FOREIGN KEY (Syllabus_ID) REFERENCES syllabus_info (ID),
  CONSTRAINT fk_sac_assign_cat FOREIGN KEY (AssignmentCategories_ID) REFERENCES assignment_categories (ID)
)
[2015-06-03 18:03:27] 0 row(s) affected in 101 ms
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  Year     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID),
  CONSTRAINT unq_publishers UNIQUE (Title, Location, Year)
)
[2015-06-03 18:03:27] 0 row(s) affected in 123 ms
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
[2015-06-03 18:03:27] 0 row(s) affected in 127 ms
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-06-03 18:03:27] 0 row(s) affected in 116 ms
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  Sequence_Number NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-06-03 18:03:27] 0 row(s) affected in 50 ms
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-06-03 18:03:28] 0 row(s) affected in 91 ms

[2015-06-03 18:03:28] Summary: 20 of 20 statements executed in 2357 ms (6694 chars in file)
[2015-06-03 18:03:51] Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
[2015-06-03 18:03:51] Connecting to Oracle - @loree.minotstateu.edu...
CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 28 ms
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_semesters_years
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 21 ms
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 20 ms
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 12 ms
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 17 ms
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_textbooks
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 15 ms
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 16 ms
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 22 ms
CREATE SEQUENCE seq_author_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 21 ms
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-03 18:03:51] 0 row(s) affected in 13 ms

[2015-06-03 18:03:51] Summary: 18 of 18 statements executed in 375 ms (1198 chars in file)
[2015-06-03 18:04:00] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-06-03 18:04:00] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-06-03 18:04:00] 1 row(s) affected in 22 ms
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Fall')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Spring')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Summer')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2010')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2011')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2011')
[2015-06-03 18:04:00] 1 row(s) affected in 17 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2012')
[2015-06-03 18:04:00] 1 row(s) affected in 14 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2013')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2014')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2014')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2015')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 3, '2015')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '000', 'Office Hours', 'These are office hours.')
[2015-06-03 18:04:00] 1 row(s) affected in 14 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-06-03 18:04:00] 1 row(s) affected in 24 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '260', 'UNIX Environment',
                                              'UNIX')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-06-03 18:04:00] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-06-03 18:04:00] 1 row(s) affected in 14 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-06-03 18:04:00] 1 row(s) affected in 17 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-06-03 18:04:00] 1 row(s) affected in 14 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 2, '208', 'Discrete Mathematics',
                                              'Discrete Math')
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 14 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 19 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 21 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 7 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 17 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 13 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 17 ms
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
[2015-06-03 18:04:00] 1 row(s) affected in 14 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 14 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
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
[2015-06-03 18:04:01] 1 row(s) affected in 13 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'P. Loree')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K. Nygard')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'X. Du')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K.K. Gagneja')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F. Ranganathan')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.B. Ghosn')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'L.M. Alnemer')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'R.I. Seetan')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F.M. Bassi')
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'C. Chitraranjan')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A. Helsene')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'Y.Q. Gu')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.C. Luo')
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.J. Iqbqal')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'G.R. Lazo')
[2015-06-03 18:04:01] 1 row(s) affected in 14 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A.M. Denton')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.F. Kianin')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, '2009 IEEE GLOBECOM', 'Honolulu, HI', '1999')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR) VALUES
  (SEQ_PUBLISHERS.nextval, 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference', 'Indianapolis, IN',
   '2012')
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, 'Functional & Integrative Geonomics', 'New York City, NY', '2013')
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks',
   'PID969207.pdf', (SELECT ID
                     FROM PUBLISHERS
                     WHERE TITLE = '2009 IEEE GLOBECOM' AND ROWNUM = 1), NULL)
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Limiting transmit power of antennas in Heterogeneous Sensor Networks', 'PID969207.pdf',
   (SELECT ID
    FROM PUBLISHERS
    WHERE TITLE = 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference' AND ROWNUM = 1), NULL)
[2015-06-03 18:04:01] 1 row(s) affected in 6 ms
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes',
   'PID06220775.pdf', (SELECT ID
                       FROM PUBLISHERS
                       WHERE TITLE = 'Functional & Integrative Geonomics' AND ROWNUM = 1),
   'Springer-Verlag, 2013, pp. 11-17')
[2015-06-03 18:04:01] 1 row(s) affected in 18 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 14 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'X. Du'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K.K. Gagneja'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F. Ranganathan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  SEQ_AUTHOR_ARTICLES.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 14 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'L.M. Alnemer'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 33 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'R.I. Seetan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F.M. Bassi'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 15 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'C. Chitraranjan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 27 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A. Helsene'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 13 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 31 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'Y.Q. Gu'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 16 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.C. Luo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 7 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.J. Iqbqal'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 24 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'G.R. Lazo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A.M. Denton'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 14 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.F. Kianin'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:04:01] 1 row(s) affected in 17 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 90, 100, 'A')
[2015-06-03 18:04:01] 1 row(s) affected in 23 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 80, 89, 'B')
[2015-06-03 18:04:02] 1 row(s) affected in 17 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 70, 79, 'C')
[2015-06-03 18:04:02] 1 row(s) affected in 14 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 60, 69, 'D')
[2015-06-03 18:04:02] 1 row(s) affected in 16 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 0, 59, 'F')
[2015-06-03 18:04:02] 1 row(s) affected in 15 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '111'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design',
        'CSCI 101, BIT 127 or dept. approval',
        'There will be several programming assignments throughout the semester. Assignments will range from 100 to 200 points each. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the web server (165.234.216.100) no later than 11:59 PM on the date which they are due.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Text editor, SSH client, SCP client and Web Browser',
        ' ',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 15 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '160'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers',
        'CSCI 111 or dept. approval',
        'There will be 13 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time.',
        ' There will be 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Visual Studio 2008 or 2010, ftp client',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 16 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '161'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes',
        'CSCI 160 or dept. approval',
        'There will be 8 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Visual Studio 2008 or 2010, ftp client',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 16 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '221'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.',
        'CSCI 161 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116 & 119',
        'Text editor, SFTP client (FileZilla, WinSCP), Web browser, (W/L/M)AMP servers installed locally',
        ' ',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 17 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '260'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'An introduction to the Unix/Linux Operating System. Students will become familiar with basic commands of *nix based systems including BASH, Perl, and Python scripting languages. Additionally, students will be expected to install, configure and administer a *nix system (CentOS) which includes setup and configuration of a web-hosting and email providing environment. Server configuration will include Apache with OpenSSL, PHP, Perl, Python, and SQL support, MySQL database, and Sendmail or Postfix email.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 3 exams given during this course. Some exams may contain a practical section during which you will be using a computer. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'SSH client, SCP/SFTP client and Web Browser. Additional software will be provided for as needed throughout the course.',
        ' ',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 25 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '321'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
        'CSCI 161 or dept. approval',
        'There will be 7 to 10 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Soft copy assignments are due no later than 11:59PM on the date due.',
        ' ',
        'Model Hall 119',
        'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 16 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '340'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 to 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Wireshark, NMAP (Zenmap), SSH client, SCP/SFTP client, additional software may be required during the semester.',
        ' ',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 19 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '356'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 to 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Microsoft Visio 2010 or 2013 (preferred), SSH client, SCP/SFTP client, Oracle SQL Developer, Oracle SQL*Plus, Web Browser, Oracle 11g Express (optional)',
        ' ',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 29 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '370'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures',
        'CSCI 275 or dept. approval.',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Assignments must be turned in within the first 10 minutes of class on the day they are due to be considered on time. If the assignment requires any programming the source code must be zipped and uploaded to the ftp server listed below. Holidays and school closures will not count towards late days. ',
        'There will be 1 or 2 midterm exam and a final exam given during this course. Make-up exams will not be given. If you are unable to make it to an exam during the scheduled time arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Visual Studio 2013, OllyDbg, MASM, SFTP/SCP client (FileZilla, WinSCP)',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 18 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '440'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security',
        'CSCI 340 or dept. approval',
        'Several assignments will be given throughout the course. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Hard copy asssignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Soft copy assignments are due no later than 11:59PM on the date due.',
        'There will be 1 to 2 midterm exams and 1 final exam given during this course. Make-up exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        ' ',
        ' ',
        ' ',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 17 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '458'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.',
        'CSCI 340 or dept. approval',
        'Several assignments will be given throughout the course. Some of these assignments will be completed during class, otherwise will be due the following lecture day but should not require much work outside of the class period.',
        'There will be 1 midterm exam and 1 final exam given during this course. Students will be allowed to bring a single page of notes to exams which will be turned in. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        ' ',
        ' ',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 29 ms
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '460'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.',
        'CSCI 242, 275, and 356',
        'The Capstone project consists of several parts as listed below. Details regarding the requirements for each part will be discussed during the course. Project proposal, Weekly progress reports, Project research/work, Project presentation, Project report/paper',
        ' ',
        ' ',
        ' ',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:04:02] 1 row(s) affected in 16 ms

[2015-06-03 18:04:02] Summary: 119 of 119 statements executed in 2168 ms (99936 chars in file)

2:12:12 PM 4 files committed: test experimental syllabus_info insert
           fail
2:12:19 PM Push successful: Pushed 1 commit to origin/master
2:14:26 PM Registration
           Your copy is licensed to Kushal Hada.
           For educational use only.
2:50:05 PM 5 files committed: link office hour id to course because we decided office hours would be a course
2:50:09 PM Push successful: Pushed 1 commit to origin/master
2:51:53 PM 3 files committed: use 1 as opposed to a true
           because i suck
2:51:57 PM Push successful: Pushed 1 commit to origin/master
5:44:25 PM 6 files committed: add two new columns: assignments and exams to syllabus info
5:44:29 PM Push successful: Pushed 1 commit to origin/master
6:05:22 PM 1 file committed: run scripts that add syllabus information
           one caveat is, of course we lost the information in the syllabi that we actually need such as project in csci 458 computer security
6:05:25 PM Push successful: Pushed 1 commit to origin/master

2:10:00 PM SQL Server - @165.234.213.133: * synchronized (9 s)
2:10:38 PM PostgreSQL - ccmkxjmg@babar.elephantsql.com: * synchronized (24 s)
2:11:15 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_TEXTBOOKS_SYLLABUS_INFO;
2:11:15 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_SYLLABUS_INFO_TEXTBOOKS;
2:11:15 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_ASSIGN_CAT;
2:11:15 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_SYLLABUS_INFO;
2:11:15 PM ALTER TABLE KHADA.REPEAT_DAYS DROP CONSTRAINT FK_REPEAT_DAYS_REPEAT_EVENTS;
2:11:15 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_ARTICLES;
2:11:15 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_AUTHORS;
2:11:16 PM ALTER TABLE KHADA.ASSIGNMENTS DROP CONSTRAINT FK_ASSIGNMENTS_COURSES;
2:11:16 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES;
2:11:16 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES2;
2:11:16 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_COURSES;
2:11:16 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_SEMESTERS_YEARS;
2:11:16 PM ALTER TABLE KHADA.SEMESTERS_YEARS DROP CONSTRAINT FK_SEMESTERS_YEARS_SEMESTERS;
2:11:16 PM ALTER TABLE KHADA.REPEAT_EVENTS DROP CONSTRAINT FK_REPEAT_EVENTS_EVENTS;
2:11:16 PM ALTER TABLE KHADA.EVENTS DROP CONSTRAINT FK_EVENTS_CLASSES;
2:11:16 PM ALTER TABLE KHADA.COURSES DROP CONSTRAINT FK_COURSES_DEPARTMENTS;
2:11:16 PM ALTER TABLE KHADA.ARTICLES DROP CONSTRAINT FK_ARTICLES_PUBLISHER;
2:11:16 PM DROP TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS;
2:11:16 PM DROP TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES;
2:11:16 PM DROP TABLE KHADA.REPEAT_DAYS;
2:11:16 PM DROP TABLE KHADA.AUTHOR_ARTICLES;
2:11:16 PM DROP TABLE KHADA.ASSIGNMENTS;
2:11:16 PM DROP TABLE KHADA.SYLLABUS_INFO;
2:11:16 PM DROP TABLE KHADA.CLASSES;
2:11:16 PM DROP TABLE KHADA.SEMESTERS_YEARS;
2:11:16 PM DROP TABLE KHADA.REPEAT_EVENTS;
2:11:16 PM DROP TABLE KHADA.EVENTS;
2:11:16 PM DROP TABLE KHADA.COURSES;
2:11:16 PM DROP TABLE KHADA.ARTICLES;
2:11:16 PM DROP TABLE KHADA.TEXTBOOKS;
2:11:16 PM DROP TABLE KHADA.SEMESTERS;
2:11:16 PM DROP TABLE KHADA.PUBLISHERS;
2:11:16 PM DROP TABLE KHADA.DEPARTMENTS;
2:11:16 PM DROP TABLE KHADA.AUTHORS;
2:11:16 PM DROP TABLE KHADA.ASSIGNMENT_CATEGORIES;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_USERS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_TEXTBOOKS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_SYLLABUS_INFO;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS_YEARS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_REPEAT_EVENTS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_REPEAT_DAYS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_PUBLISHERS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_GRADE_SCALES;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_EVENTS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_DEPARTMENTS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_COURSES;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_CLASSES;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_AUTHORS;
2:11:16 PM DROP SEQUENCE KHADA.SEQ_AUTHOR_ARTICLES;
2:11:17 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENTS;
2:11:17 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENT_CATEGORIES;
2:11:17 PM DROP SEQUENCE KHADA.SEQ_ARTICLES;
2:11:17 PM DROP TABLE KHADA.USERS;
2:11:17 PM DROP TABLE KHADA.GRADE_SCALES;
2:11:21 PM Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
2:11:21 PM Connecting to Oracle - @loree.minotstateu.edu...
2:11:23 PM Summary: 20 of 20 statements executed in 2252 ms (6612 chars in file)
2:11:33 PM Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
2:11:33 PM Connecting to Oracle - @loree.minotstateu.edu...
2:11:33 PM Summary: 18 of 18 statements executed in 354 ms (1198 chars in file)
2:11:45 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
2:11:45 PM Connecting to Oracle - @loree.minotstateu.edu...
2:11:47 PM Summary: 108 of 108 statements executed, 1 failed in 1946 ms (78902 chars in file)
2:12:56 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (3 s)
2:30:46 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (2 s)
2:34:31 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
2:34:31 PM Connecting to Oracle - @loree.minotstateu.edu...
2:34:33 PM Summary: 108 of 108 statements executed, 108 failed in 1923 ms (78917 chars in file)
2:34:55 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_TEXTBOOKS_SYLLABUS_INFO;
2:34:55 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_SYLLABUS_INFO_TEXTBOOKS;
2:34:55 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_ASSIGN_CAT;
2:34:55 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_SYLLABUS_INFO;
2:34:55 PM ALTER TABLE KHADA.REPEAT_DAYS DROP CONSTRAINT FK_REPEAT_DAYS_REPEAT_EVENTS;
2:34:55 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_ARTICLES;
2:34:55 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_AUTHORS;
2:34:55 PM ALTER TABLE KHADA.ASSIGNMENTS DROP CONSTRAINT FK_ASSIGNMENTS_COURSES;
2:34:55 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES;
2:34:55 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES2;
2:34:55 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_COURSES;
2:34:55 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_SEMESTERS_YEARS;
2:34:55 PM ALTER TABLE KHADA.SEMESTERS_YEARS DROP CONSTRAINT FK_SEMESTERS_YEARS_SEMESTERS;
2:34:55 PM ALTER TABLE KHADA.REPEAT_EVENTS DROP CONSTRAINT FK_REPEAT_EVENTS_EVENTS;
2:34:55 PM ALTER TABLE KHADA.EVENTS DROP CONSTRAINT FK_EVENTS_CLASSES;
2:34:55 PM ALTER TABLE KHADA.COURSES DROP CONSTRAINT FK_COURSES_DEPARTMENTS;
2:34:55 PM ALTER TABLE KHADA.ARTICLES DROP CONSTRAINT FK_ARTICLES_PUBLISHER;
2:34:55 PM DROP TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS;
2:34:55 PM DROP TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES;
2:34:55 PM DROP TABLE KHADA.REPEAT_DAYS;
2:34:55 PM DROP TABLE KHADA.AUTHOR_ARTICLES;
2:34:55 PM DROP TABLE KHADA.ASSIGNMENTS;
2:34:55 PM DROP TABLE KHADA.SYLLABUS_INFO;
2:34:55 PM DROP TABLE KHADA.CLASSES;
2:34:56 PM DROP TABLE KHADA.SEMESTERS_YEARS;
2:34:56 PM DROP TABLE KHADA.REPEAT_EVENTS;
2:34:56 PM DROP TABLE KHADA.EVENTS;
2:34:56 PM DROP TABLE KHADA.COURSES;
2:34:56 PM DROP TABLE KHADA.ARTICLES;
2:34:56 PM DROP TABLE KHADA.TEXTBOOKS;
2:34:56 PM DROP TABLE KHADA.SEMESTERS;
2:34:56 PM DROP TABLE KHADA.PUBLISHERS;
2:34:56 PM DROP TABLE KHADA.DEPARTMENTS;
2:34:57 PM DROP TABLE KHADA.AUTHORS;
2:34:57 PM DROP TABLE KHADA.ASSIGNMENT_CATEGORIES;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_USERS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_TEXTBOOKS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_SYLLABUS_INFO;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS_YEARS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_REPEAT_EVENTS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_REPEAT_DAYS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_PUBLISHERS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_GRADE_SCALES;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_EVENTS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_DEPARTMENTS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_COURSES;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_CLASSES;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_AUTHORS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_AUTHOR_ARTICLES;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENTS;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENT_CATEGORIES;
2:34:57 PM DROP SEQUENCE KHADA.SEQ_ARTICLES;
2:34:57 PM DROP TABLE KHADA.USERS;
2:34:57 PM DROP TABLE KHADA.GRADE_SCALES;
2:34:57 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES;
2:35:02 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized
2:35:08 PM Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
2:35:08 PM Connecting to Oracle - @loree.minotstateu.edu...
2:35:10 PM Summary: 20 of 20 statements executed in 2340 ms (6622 chars in file)
2:35:22 PM Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
2:35:22 PM Connecting to Oracle - @loree.minotstateu.edu...
2:35:22 PM Summary: 18 of 18 statements executed in 349 ms (1198 chars in file)
2:35:31 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
2:35:31 PM Connecting to Oracle - @loree.minotstateu.edu...
2:35:33 PM Summary: 108 of 108 statements executed, 1 failed in 1871 ms (78901 chars in file)
2:42:54 PM INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
           VALUES (SEQ_SYLLABUS_INFO.nextval,
           (SELECT ID
           FROM COURSES
           WHERE NUM = '321'
           AND DEPT_ID = (SELECT ID
           FROM DEPARTMENTS
           WHERE NAME = 'CSCI') AND ROWNUM = 1),
           (SELECT ID
           FROM COURSES
           WHERE NAME = 'Office Hours' AND ROWNUM = 1),
           'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
           'CSCI 161 or dept. approval', 'Model Hall 119', 'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
           'Instructions for submitting assignments and authentication information will be provided in class.', TRUE)
2:42:54 PM [42000][984] ORA-00984: column not allowed here
2:42:56 PM INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
           VALUES (SEQ_SYLLABUS_INFO.nextval,
           (SELECT ID
           FROM COURSES
           WHERE NUM = '321'
           AND DEPT_ID = (SELECT ID
           FROM DEPARTMENTS
           WHERE NAME = 'CSCI') AND ROWNUM = 1),
           (SELECT ID
           FROM COURSES
           WHERE NAME = 'Office Hours' AND ROWNUM = 1),
           'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
           'CSCI 161 or dept. approval', 'Model Hall 119', 'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
           'Instructions for submitting assignments and authentication information will be provided in class.', TRUE)
2:42:56 PM [42000][984] ORA-00984: column not allowed here
2:45:19 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (2 s)
2:46:19 PM INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
           VALUES (SEQ_SYLLABUS_INFO.nextval,
           (SELECT ID
           FROM COURSES
           WHERE NUM = '321'
           AND DEPT_ID = (SELECT ID
           FROM DEPARTMENTS
           WHERE NAME = 'CSCI') AND ROWNUM = 1),
           (SELECT ID
           FROM COURSES
           WHERE NAME = 'Office Hours' AND ROWNUM = 1),
           'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
           'CSCI 161 or dept. approval', 'Model Hall 119', 'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
           'Instructions for submitting assignments and authentication information will be provided in class.', 1)
2:46:19 PM [23000][2291] ORA-02291: integrity constraint (KHADA.FK_SYLLABUS_INFO_COURSES2) violated - parent key not found
2:47:18 PM INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
           VALUES (SEQ_SYLLABUS_INFO.nextval,
           (SELECT ID
           FROM COURSES
           WHERE NUM = '321'
           AND DEPT_ID = (SELECT ID
           FROM DEPARTMENTS
           WHERE NAME = 'CSCI') AND ROWNUM = 1),
           (SELECT ID
           FROM COURSES
           WHERE NAME = 'Office Hours' AND ROWNUM = 1),
           'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
           'CSCI 161 or dept. approval', 'Model Hall 119', 'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
           'Instructions for submitting assignments and authentication information will be provided in class.', 1)

2:47:18 PM [23000][2291] ORA-02291: integrity constraint (KHADA.FK_SYLLABUS_INFO_COURSES2) violated - parent key not found
2:50:12 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_TEXTBOOKS_SYLLABUS_INFO;
2:50:12 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_SYLLABUS_INFO_TEXTBOOKS;
2:50:12 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_ASSIGN_CAT;
2:50:12 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_SYLLABUS_INFO;
2:50:12 PM ALTER TABLE KHADA.REPEAT_DAYS DROP CONSTRAINT FK_REPEAT_DAYS_REPEAT_EVENTS;
2:50:12 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_ARTICLES;
2:50:12 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_AUTHORS;
2:50:12 PM ALTER TABLE KHADA.ASSIGNMENTS DROP CONSTRAINT FK_ASSIGNMENTS_COURSES;
2:50:12 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES;
2:50:12 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES2;
2:50:12 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_COURSES;
2:50:12 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_SEMESTERS_YEARS;
2:50:12 PM ALTER TABLE KHADA.SEMESTERS_YEARS DROP CONSTRAINT FK_SEMESTERS_YEARS_SEMESTERS;
2:50:12 PM ALTER TABLE KHADA.REPEAT_EVENTS DROP CONSTRAINT FK_REPEAT_EVENTS_EVENTS;
2:50:12 PM ALTER TABLE KHADA.EVENTS DROP CONSTRAINT FK_EVENTS_CLASSES;
2:50:12 PM ALTER TABLE KHADA.COURSES DROP CONSTRAINT FK_COURSES_DEPARTMENTS;
2:50:12 PM ALTER TABLE KHADA.ARTICLES DROP CONSTRAINT FK_ARTICLES_PUBLISHER;
2:50:12 PM DROP TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS;
2:50:12 PM DROP TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES;
2:50:12 PM DROP TABLE KHADA.REPEAT_DAYS;
2:50:12 PM DROP TABLE KHADA.AUTHOR_ARTICLES;
2:50:12 PM DROP TABLE KHADA.ASSIGNMENTS;
2:50:12 PM DROP TABLE KHADA.SYLLABUS_INFO;
2:50:13 PM DROP TABLE KHADA.CLASSES;
2:50:13 PM DROP TABLE KHADA.SEMESTERS_YEARS;
2:50:13 PM DROP TABLE KHADA.REPEAT_EVENTS;
2:50:13 PM DROP TABLE KHADA.EVENTS;
2:50:13 PM DROP TABLE KHADA.COURSES;
2:50:13 PM DROP TABLE KHADA.ARTICLES;
2:50:13 PM DROP TABLE KHADA.TEXTBOOKS;
2:50:13 PM DROP TABLE KHADA.SEMESTERS;
2:50:13 PM DROP TABLE KHADA.PUBLISHERS;
2:50:13 PM DROP TABLE KHADA.DEPARTMENTS;
2:50:14 PM DROP TABLE KHADA.AUTHORS;
2:50:14 PM DROP TABLE KHADA.ASSIGNMENT_CATEGORIES;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_USERS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_TEXTBOOKS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_SYLLABUS_INFO;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS_YEARS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_REPEAT_EVENTS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_REPEAT_DAYS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_PUBLISHERS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_GRADE_SCALES;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_EVENTS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_DEPARTMENTS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_COURSES;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_CLASSES;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_AUTHORS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_AUTHOR_ARTICLES;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENTS;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENT_CATEGORIES;
2:50:14 PM DROP SEQUENCE KHADA.SEQ_ARTICLES;
2:50:14 PM DROP TABLE KHADA.USERS;
2:50:14 PM DROP TABLE KHADA.GRADE_SCALES;
2:50:23 PM Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
2:50:23 PM Connecting to Oracle - @loree.minotstateu.edu...
2:50:25 PM Summary: 20 of 20 statements executed in 2267 ms (6608 chars in file)
2:50:36 PM Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
2:50:36 PM Connecting to Oracle - @loree.minotstateu.edu...
2:50:37 PM Summary: 18 of 18 statements executed in 336 ms (1198 chars in file)
2:50:54 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
2:50:54 PM Connecting to Oracle - @loree.minotstateu.edu...
2:50:56 PM Summary: 108 of 108 statements executed in 1844 ms (78143 chars in file)
2:51:45 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (2 s)
4:03:43 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_TEXTBOOKS_SYLLABUS_INFO;
4:03:43 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_SYLLABUS_INFO_TEXTBOOKS;
4:03:43 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_ASSIGN_CAT;
4:03:43 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_SYLLABUS_INFO;
4:03:43 PM ALTER TABLE KHADA.REPEAT_DAYS DROP CONSTRAINT FK_REPEAT_DAYS_REPEAT_EVENTS;
4:03:43 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_ARTICLES;
4:03:43 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_AUTHORS;
4:03:43 PM ALTER TABLE KHADA.ASSIGNMENTS DROP CONSTRAINT FK_ASSIGNMENTS_COURSES;
4:03:43 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES;
4:03:43 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES2;
4:03:43 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_COURSES;
4:03:43 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_SEMESTERS_YEARS;
4:03:43 PM ALTER TABLE KHADA.SEMESTERS_YEARS DROP CONSTRAINT FK_SEMESTERS_YEARS_SEMESTERS;
4:03:43 PM ALTER TABLE KHADA.REPEAT_EVENTS DROP CONSTRAINT FK_REPEAT_EVENTS_EVENTS;
4:03:43 PM ALTER TABLE KHADA.EVENTS DROP CONSTRAINT FK_EVENTS_CLASSES;
4:03:43 PM ALTER TABLE KHADA.COURSES DROP CONSTRAINT FK_COURSES_DEPARTMENTS;
4:03:43 PM ALTER TABLE KHADA.ARTICLES DROP CONSTRAINT FK_ARTICLES_PUBLISHER;
4:03:43 PM DROP TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS;
4:03:43 PM DROP TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES;
4:03:43 PM DROP TABLE KHADA.REPEAT_DAYS;
4:03:43 PM DROP TABLE KHADA.AUTHOR_ARTICLES;
4:03:43 PM DROP TABLE KHADA.ASSIGNMENTS;
4:03:43 PM DROP TABLE KHADA.SYLLABUS_INFO;
4:03:43 PM DROP TABLE KHADA.CLASSES;
4:03:44 PM DROP TABLE KHADA.SEMESTERS_YEARS;
4:03:44 PM DROP TABLE KHADA.REPEAT_EVENTS;
4:03:44 PM DROP TABLE KHADA.EVENTS;
4:03:44 PM DROP TABLE KHADA.COURSES;
4:03:44 PM DROP TABLE KHADA.ARTICLES;
4:03:44 PM DROP TABLE KHADA.TEXTBOOKS;
4:03:44 PM DROP TABLE KHADA.SEMESTERS;
4:03:44 PM DROP TABLE KHADA.PUBLISHERS;
4:03:44 PM DROP TABLE KHADA.DEPARTMENTS;
4:03:44 PM DROP TABLE KHADA.AUTHORS;
4:03:44 PM DROP TABLE KHADA.ASSIGNMENT_CATEGORIES;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_USERS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_TEXTBOOKS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_SYLLABUS_INFO;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS_YEARS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_REPEAT_EVENTS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_REPEAT_DAYS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_PUBLISHERS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_GRADE_SCALES;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_EVENTS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_DEPARTMENTS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_COURSES;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_CLASSES;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_AUTHORS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_AUTHOR_ARTICLES;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENTS;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENT_CATEGORIES;
4:03:44 PM DROP SEQUENCE KHADA.SEQ_ARTICLES;
4:03:44 PM DROP TABLE KHADA.USERS;
4:03:44 PM DROP TABLE KHADA.GRADE_SCALES;
4:04:13 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized
4:04:15 PM Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
4:04:15 PM Connecting to Oracle - @loree.minotstateu.edu...
4:04:17 PM Summary: 20 of 20 statements executed in 2195 ms (6680 chars in file)
4:04:22 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (2 s)
4:21:42 PM Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
4:21:42 PM Connecting to Oracle - @loree.minotstateu.edu...
4:21:42 PM Summary: 18 of 18 statements executed in 358 ms (1198 chars in file)
4:26:24 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
4:26:24 PM Connecting to Oracle - @loree.minotstateu.edu...
4:26:26 PM Summary: 108 of 108 statements executed in 1814 ms (78737 chars in file)
5:42:08 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (3 s)
6:02:34 PM Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
6:02:34 PM Connecting to Oracle - @loree.minotstateu.edu...
6:02:34 PM Summary: 20 of 20 statements executed, 20 failed in 260 ms (6694 chars in file)
6:02:40 PM Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
6:02:40 PM Connecting to Oracle - @loree.minotstateu.edu...
6:02:40 PM Summary: 18 of 18 statements executed, 18 failed in 154 ms (1198 chars in file)
6:02:45 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
6:02:45 PM Connecting to Oracle - @loree.minotstateu.edu...
6:02:47 PM Summary: 119 of 119 statements executed, 108 failed in 2200 ms (99936 chars in file)
6:03:05 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_TEXTBOOKS_SYLLABUS_INFO;
6:03:05 PM ALTER TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS DROP CONSTRAINT FK_SYLLABUS_INFO_TEXTBOOKS;
6:03:06 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_ASSIGN_CAT;
6:03:06 PM ALTER TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES DROP CONSTRAINT FK_SAC_SYLLABUS_INFO;
6:03:06 PM ALTER TABLE KHADA.REPEAT_DAYS DROP CONSTRAINT FK_REPEAT_DAYS_REPEAT_EVENTS;
6:03:06 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_ARTICLES;
6:03:06 PM ALTER TABLE KHADA.AUTHOR_ARTICLES DROP CONSTRAINT FK_AUTHOR_ARTICLES_AUTHORS;
6:03:06 PM ALTER TABLE KHADA.ASSIGNMENTS DROP CONSTRAINT FK_ASSIGNMENTS_COURSES;
6:03:06 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES;
6:03:06 PM ALTER TABLE KHADA.SYLLABUS_INFO DROP CONSTRAINT FK_SYLLABUS_INFO_COURSES2;
6:03:06 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_COURSES;
6:03:06 PM ALTER TABLE KHADA.CLASSES DROP CONSTRAINT FK_CLASSES_SEMESTERS_YEARS;
6:03:06 PM ALTER TABLE KHADA.SEMESTERS_YEARS DROP CONSTRAINT FK_SEMESTERS_YEARS_SEMESTERS;
6:03:06 PM ALTER TABLE KHADA.REPEAT_EVENTS DROP CONSTRAINT FK_REPEAT_EVENTS_EVENTS;
6:03:06 PM ALTER TABLE KHADA.EVENTS DROP CONSTRAINT FK_EVENTS_CLASSES;
6:03:06 PM ALTER TABLE KHADA.COURSES DROP CONSTRAINT FK_COURSES_DEPARTMENTS;
6:03:06 PM ALTER TABLE KHADA.ARTICLES DROP CONSTRAINT FK_ARTICLES_PUBLISHER;
6:03:06 PM DROP TABLE KHADA.SYLLABUS_INFO_TEXTBOOKS;
6:03:06 PM DROP TABLE KHADA.SYLLABUS_ASSIGN_CATEGORIES;
6:03:06 PM DROP TABLE KHADA.REPEAT_DAYS;
6:03:06 PM DROP TABLE KHADA.AUTHOR_ARTICLES;
6:03:06 PM DROP TABLE KHADA.ASSIGNMENTS;
6:03:06 PM DROP TABLE KHADA.SYLLABUS_INFO;
6:03:06 PM DROP TABLE KHADA.CLASSES;
6:03:06 PM DROP TABLE KHADA.SEMESTERS_YEARS;
6:03:06 PM DROP TABLE KHADA.REPEAT_EVENTS;
6:03:06 PM DROP TABLE KHADA.EVENTS;
6:03:06 PM DROP TABLE KHADA.COURSES;
6:03:07 PM DROP TABLE KHADA.ARTICLES;
6:03:07 PM DROP TABLE KHADA.TEXTBOOKS;
6:03:07 PM DROP TABLE KHADA.SEMESTERS;
6:03:07 PM DROP TABLE KHADA.PUBLISHERS;
6:03:07 PM DROP TABLE KHADA.DEPARTMENTS;
6:03:07 PM DROP TABLE KHADA.AUTHORS;
6:03:07 PM DROP TABLE KHADA.ASSIGNMENT_CATEGORIES;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_USERS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_TEXTBOOKS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_SYLLABUS_INFO;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS_YEARS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_SEMESTERS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_REPEAT_EVENTS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_REPEAT_DAYS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_PUBLISHERS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_GRADE_SCALES;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_EVENTS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_DEPARTMENTS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_COURSES;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_CLASSES;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_AUTHORS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_AUTHOR_ARTICLES;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENTS;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_ASSIGNMENT_CATEGORIES;
6:03:07 PM DROP SEQUENCE KHADA.SEQ_ARTICLES;
6:03:07 PM DROP TABLE KHADA.USERS;
6:03:08 PM DROP TABLE KHADA.GRADE_SCALES;
6:03:11 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized
6:03:19 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized
6:03:25 PM Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
6:03:25 PM Connecting to Oracle - @loree.minotstateu.edu...
6:03:28 PM Summary: 20 of 20 statements executed in 2357 ms (6694 chars in file)
6:03:51 PM Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
6:03:51 PM Connecting to Oracle - @loree.minotstateu.edu...
6:03:51 PM Summary: 18 of 18 statements executed in 375 ms (1198 chars in file)
6:04:00 PM Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
6:04:00 PM Connecting to Oracle - @loree.minotstateu.edu...
6:04:02 PM Summary: 119 of 119 statements executed in 2168 ms (99936 chars in file)
6:04:24 PM Oracle - @loree.minotstateu.edu: *.KHADA synchronized (2 s)

[2015-06-03 18:35:51] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-06-03 18:35:52] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_DEPARTMENTS) violated
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_DEPARTMENTS) violated
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Fall')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS) violated
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Spring')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS) violated
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Summer')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2010')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2011')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2011')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2012')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2013')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2014')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2014')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2015')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 3, '2015')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '000', 'Office Hours', 'These are office hours.')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '260', 'UNIX Environment',
                                              'UNIX')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 2, '208', 'Discrete Mathematics',
                                              'Discrete Math')
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:52] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'P. Loree')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K. Nygard')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'X. Du')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K.K. Gagneja')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F. Ranganathan')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.B. Ghosn')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'L.M. Alnemer')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'R.I. Seetan')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F.M. Bassi')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'C. Chitraranjan')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A. Helsene')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'Y.Q. Gu')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.C. Luo')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.J. Iqbqal')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'G.R. Lazo')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A.M. Denton')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.F. Kianin')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, '2009 IEEE GLOBECOM', 'Honolulu, HI', '1999')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_PUBLISHERS) violated
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR) VALUES
  (SEQ_PUBLISHERS.nextval, 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference', 'Indianapolis, IN',
   '2012')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_PUBLISHERS) violated
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, 'Functional & Integrative Geonomics', 'New York City, NY', '2013')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_PUBLISHERS) violated
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks',
   'PID969207.pdf', (SELECT ID
                     FROM PUBLISHERS
                     WHERE TITLE = '2009 IEEE GLOBECOM' AND ROWNUM = 1), NULL)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_ARTICLES) violated
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Limiting transmit power of antennas in Heterogeneous Sensor Networks', 'PID969207.pdf',
   (SELECT ID
    FROM PUBLISHERS
    WHERE TITLE = 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference' AND ROWNUM = 1), NULL)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_ARTICLES) violated
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes',
   'PID06220775.pdf', (SELECT ID
                       FROM PUBLISHERS
                       WHERE TITLE = 'Functional & Integrative Geonomics' AND ROWNUM = 1),
   'Springer-Verlag, 2013, pp. 11-17')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'X. Du'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K.K. Gagneja'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F. Ranganathan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  SEQ_AUTHOR_ARTICLES.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'L.M. Alnemer'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'R.I. Seetan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F.M. Bassi'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'C. Chitraranjan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A. Helsene'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'Y.Q. Gu'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.C. Luo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.J. Iqbqal'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'G.R. Lazo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A.M. Denton'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.F. Kianin'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 90, 100, 'A')
[2015-06-03 18:35:53] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 80, 89, 'B')
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 70, 79, 'C')
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 60, 69, 'D')
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 0, 59, 'F')
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '111'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design',
        'CSCI 101, BIT 127 or dept. approval',
        'There will be several programming assignments throughout the semester. Assignments will range from 100 to 200 points each. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the web server (165.234.216.100) no later than 11:59 PM on the date which they are due.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Text editor, SSH client, SCP client and Web Browser',
        ' ',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '160'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers',
        'CSCI 111 or dept. approval',
        'There will be 13 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time.',
        ' There will be 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Visual Studio 2008 or 2010, ftp client',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '161'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes',
        'CSCI 160 or dept. approval',
        'There will be 8 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Visual Studio 2008 or 2010, ftp client',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '221'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.',
        'CSCI 161 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116 & 119',
        'Text editor, SFTP client (FileZilla, WinSCP), Web browser, (W/L/M)AMP servers installed locally',
        ' ',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '260'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'An introduction to the Unix/Linux Operating System. Students will become familiar with basic commands of *nix based systems including BASH, Perl, and Python scripting languages. Additionally, students will be expected to install, configure and administer a *nix system (CentOS) which includes setup and configuration of a web-hosting and email providing environment. Server configuration will include Apache with OpenSSL, PHP, Perl, Python, and SQL support, MySQL database, and Sendmail or Postfix email.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 3 exams given during this course. Some exams may contain a practical section during which you will be using a computer. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'SSH client, SCP/SFTP client and Web Browser. Additional software will be provided for as needed throughout the course.',
        ' ',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '321'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
        'CSCI 161 or dept. approval',
        'There will be 7 to 10 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Soft copy assignments are due no later than 11:59PM on the date due.',
        ' ',
        'Model Hall 119',
        'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '340'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 to 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Wireshark, NMAP (Zenmap), SSH client, SCP/SFTP client, additional software may be required during the semester.',
        ' ',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '356'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 to 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Microsoft Visio 2010 or 2013 (preferred), SSH client, SCP/SFTP client, Oracle SQL Developer, Oracle SQL*Plus, Web Browser, Oracle 11g Express (optional)',
        ' ',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '370'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures',
        'CSCI 275 or dept. approval.',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Assignments must be turned in within the first 10 minutes of class on the day they are due to be considered on time. If the assignment requires any programming the source code must be zipped and uploaded to the ftp server listed below. Holidays and school closures will not count towards late days. ',
        'There will be 1 or 2 midterm exam and a final exam given during this course. Make-up exams will not be given. If you are unable to make it to an exam during the scheduled time arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Visual Studio 2013, OllyDbg, MASM, SFTP/SCP client (FileZilla, WinSCP)',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '440'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security',
        'CSCI 340 or dept. approval',
        'Several assignments will be given throughout the course. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Hard copy asssignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Soft copy assignments are due no later than 11:59PM on the date due.',
        'There will be 1 to 2 midterm exams and 1 final exam given during this course. Make-up exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        ' ',
        ' ',
        ' ',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '458'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.',
        'CSCI 340 or dept. approval',
        'Several assignments will be given throughout the course. Some of these assignments will be completed during class, otherwise will be due the following lecture day but should not require much work outside of the class period.',
        'There will be 1 midterm exam and 1 final exam given during this course. Students will be allowed to bring a single page of notes to exams which will be turned in. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        ' ',
        ' ',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '460'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.',
        'CSCI 242, 275, and 356',
        'The Capstone project consists of several parts as listed below. Details regarding the requirements for each part will be discussed during the course. Project proposal, Weekly progress reports, Project research/work, Project presentation, Project report/paper',
        ' ',
        ' ',
        ' ',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:35:54] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '208'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'MATH') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        ' Introduction to discrete mathematics and its applications. This course will cover the following topics: Sets, relations and functions, combinatorics, logic, Boolean algebra, difference equations, graph theory, automata.',
        'CSCI 103 or dept. approval',
        'Assignments will not be graded but it is advised that students complete at least the section assignments as we progress between the exams.',
        'Approximately every other Tuesday during the last 1 or 2 hours of class we will have an exam that covers the previous 6 to 8 hours of lectures except for the 2 to 3 hours prior to the exam. Extra credit problems from the 2 hours prior to exam may appear on the exam.',
        ' ',
        ' ',
        ' ',
        1)
[2015-06-03 18:35:54] 1 row(s) affected in 22 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'A Web-Based Introduction to Programming, 2nd Ed.',
    'Mike O''Kane',
    9781594608445
  )
[2015-06-03 18:35:54] 1 row(s) affected in 16 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Program Development and Design Using C++, 3rd Edition',
    'Gary Bronson',
    9780619216771
  )
[2015-06-03 18:35:54] 1 row(s) affected in 12 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Object-Oriented Programming in C++',
    'Richard Johnsonbaugh & Martin Kalin',
    9780130158857
  )
[2015-06-03 18:35:54] 1 row(s) affected in 18 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Unix and Linux System Administration Handbook, 4th Ed.',
    'Evi Nemeth et al.',
    9780131480056
  )
[2015-06-03 18:35:54] 1 row(s) affected in 14 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'The Unix Operating System, 3rd Ed.',
    'Kaare Christian and Susan Richter',
    9780471586845
  )
[2015-06-03 18:35:54] 1 row(s) affected in 15 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Networks',
    'Andrew S. Tanenbaum and David J. Wetherall',
    9780132126953
  )
[2015-06-03 18:35:54] 1 row(s) affected in 21 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Fundamentals of Database Systems, 6th Ed.',
    'Ramez Elmasri and Shamkant B. Navathe',
    9780136086208
  )
[2015-06-03 18:35:54] 1 row(s) affected in 18 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Organization and Architecture, 9th Edition',
    'Stallings',
    9780132936330
  )
[2015-06-03 18:35:54] 1 row(s) affected in 16 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Networks, 5th Edition',
    'Tanenbaum',
    9780132126973
  )
[2015-06-03 18:35:54] 1 row(s) affected in 15 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Security, Principles and Practices, 2nd Edition',
    'Stallings',
    9780132775069
  )
[2015-06-03 18:35:54] 1 row(s) affected in 15 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Network Security Essentials, 4th Edition',
    'William Stallings',
    9780136108054
  )
[2015-06-03 18:35:54] 1 row(s) affected in 16 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Discrete Mathematics with Applications, 4th Edition',
    'Epp',
    9780495391326
  )
[2015-06-03 18:35:54] 1 row(s) affected in 15 ms

[2015-06-03 18:35:54] Summary: 132 of 132 statements executed, 119 failed in 2620 ms (103430 chars in file)
[2015-06-03 18:36:21] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-06-03 18:36:21] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_DEPARTMENTS) violated
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_DEPARTMENTS) violated
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Fall')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS) violated
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Spring')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS) violated
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Summer')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2010')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2011')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2011')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2012')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2013')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2014')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 1, '2014')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 2, '2015')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR) VALUES (SEQ_SEMESTERS_YEARS.nextval, 3, '2015')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SEMESTERS_YEARS) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '000', 'Office Hours', 'These are office hours.')
[2015-06-03 18:36:21] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '260', 'UNIX Environment',
                                              'UNIX')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 2, '208', 'Discrete Mathematics',
                                              'Discrete Math')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_COURSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
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
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_CLASSES) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'P. Loree')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K. Nygard')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'X. Du')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K.K. Gagneja')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F. Ranganathan')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.B. Ghosn')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'L.M. Alnemer')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'R.I. Seetan')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F.M. Bassi')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'C. Chitraranjan')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A. Helsene')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'Y.Q. Gu')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.C. Luo')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.J. Iqbqal')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'G.R. Lazo')
[2015-06-03 18:36:22] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A.M. Denton')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.F. Kianin')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_AUTHORS) violated
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, '2009 IEEE GLOBECOM', 'Honolulu, HI', '1999')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_PUBLISHERS) violated
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR) VALUES
  (SEQ_PUBLISHERS.nextval, 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference', 'Indianapolis, IN',
   '2012')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_PUBLISHERS) violated
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, 'Functional & Integrative Geonomics', 'New York City, NY', '2013')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_PUBLISHERS) violated
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks',
   'PID969207.pdf', (SELECT ID
                     FROM PUBLISHERS
                     WHERE TITLE = '2009 IEEE GLOBECOM' AND ROWNUM = 1), NULL)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_ARTICLES) violated
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Limiting transmit power of antennas in Heterogeneous Sensor Networks', 'PID969207.pdf',
   (SELECT ID
    FROM PUBLISHERS
    WHERE TITLE = 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference' AND ROWNUM = 1), NULL)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_ARTICLES) violated
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes',
   'PID06220775.pdf', (SELECT ID
                       FROM PUBLISHERS
                       WHERE TITLE = 'Functional & Integrative Geonomics' AND ROWNUM = 1),
   'Springer-Verlag, 2013, pp. 11-17')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'X. Du'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K.K. Gagneja'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F. Ranganathan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  SEQ_AUTHOR_ARTICLES.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'L.M. Alnemer'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'R.I. Seetan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F.M. Bassi'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'C. Chitraranjan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A. Helsene'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'Y.Q. Gu'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.C. Luo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.J. Iqbqal'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'G.R. Lazo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A.M. Denton'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.F. Kianin'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.PK_AUTHOR_ARTICLES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 90, 100, 'A')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 80, 89, 'B')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 70, 79, 'C')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 60, 69, 'D')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 0, 59, 'F')
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_GRADE_SCALES) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '111'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design',
        'CSCI 101, BIT 127 or dept. approval',
        'There will be several programming assignments throughout the semester. Assignments will range from 100 to 200 points each. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the web server (165.234.216.100) no later than 11:59 PM on the date which they are due.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Text editor, SSH client, SCP client and Web Browser',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '160'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers',
        'CSCI 111 or dept. approval',
        'There will be 13 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time.',
        ' There will be 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Visual Studio 2008 or 2010, ftp client',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '161'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes',
        'CSCI 160 or dept. approval',
        'There will be 8 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116',
        'Visual Studio 2008 or 2010, ftp client',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '221'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.',
        'CSCI 161 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 116 & 119',
        'Text editor, SFTP client (FileZilla, WinSCP), Web browser, (W/L/M)AMP servers installed locally',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '260'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'An introduction to the Unix/Linux Operating System. Students will become familiar with basic commands of *nix based systems including BASH, Perl, and Python scripting languages. Additionally, students will be expected to install, configure and administer a *nix system (CentOS) which includes setup and configuration of a web-hosting and email providing environment. Server configuration will include Apache with OpenSSL, PHP, Perl, Python, and SQL support, MySQL database, and Sendmail or Postfix email.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 3 exams given during this course. Some exams may contain a practical section during which you will be using a computer. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'SSH client, SCP/SFTP client and Web Browser. Additional software will be provided for as needed throughout the course.',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '321'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s',
        'CSCI 161 or dept. approval',
        'There will be 7 to 10 programming assignments throughout the semester. Each assignment will be worth 100 points. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Soft copy assignments are due no later than 11:59PM on the date due.',
        ' ',
        'Model Hall 119',
        'Visual Studio 2013, SFTP/SCP client (FileZilla or WinSCP)',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '340'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 to 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Wireshark, NMAP (Zenmap), SSH client, SCP/SFTP client, additional software may be required during the semester.',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '356'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.',
        'CSCI 160 or dept. approval',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted and will receive a ZERO. Holidays and campus closures will not count towards late days. Hard copy assignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Additionally, software assignments must be uploaded to the course server no later than 11:59 PM on the date which they are due.',
        'There will be 2 to 3 midterm exams and 1 comprehensive final exam given during this course. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Microsoft Visio 2010 or 2013 (preferred), SSH client, SCP/SFTP client, Oracle SQL Developer, Oracle SQL*Plus, Web Browser, Oracle 11g Express (optional)',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '370'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures',
        'CSCI 275 or dept. approval.',
        'There will be several assignments throughout the semester. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Assignments must be turned in within the first 10 minutes of class on the day they are due to be considered on time. If the assignment requires any programming the source code must be zipped and uploaded to the ftp server listed below. Holidays and school closures will not count towards late days. ',
        'There will be 1 or 2 midterm exam and a final exam given during this course. Make-up exams will not be given. If you are unable to make it to an exam during the scheduled time arrangements must be made to take the exam BEFORE the scheduled time.',
        'Model Hall 119',
        'Visual Studio 2013, OllyDbg, MASM, SFTP/SCP client (FileZilla, WinSCP)',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '440'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security',
        'CSCI 340 or dept. approval',
        'Several assignments will be given throughout the course. Late assignments will have a 10% penalty for each day the assignment is late up to 3 days late. Assignments more than 3 days late will not be accepted. Holidays and school closures will not count towards late days. Hard copy asssignments must be turned in no later than 10 minutes into the start of class on the day which they are due to be considered on time. Soft copy assignments are due no later than 11:59PM on the date due.',
        'There will be 1 to 2 midterm exams and 1 final exam given during this course. Make-up exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        ' ',
        ' ',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '458'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.',
        'CSCI 340 or dept. approval',
        'Several assignments will be given throughout the course. Some of these assignments will be completed during class, otherwise will be due the following lecture day but should not require much work outside of the class period.',
        'There will be 1 midterm exam and 1 final exam given during this course. Students will be allowed to bring a single page of notes to exams which will be turned in. Makeup exams will not be given. If you are unable to make it to an exam during the scheduled time, arrangements must be made to take the exam BEFORE the scheduled time.',
        ' ',
        ' ',
        'Authentication information will be provided in class.',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '460'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'CSCI') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.',
        'CSCI 242, 275, and 356',
        'The Capstone project consists of several parts as listed below. Details regarding the requirements for each part will be discussed during the course. Project proposal, Weekly progress reports, Project research/work, Project presentation, Project report/paper',
        ' ',
        ' ',
        ' ',
        'Instructions for submitting assignments and authentication information will be provided in class.',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO SYLLABUS_INFO (ID, COURSE_ID, OFFICEHOUR_ID, COURSEOBJECTIVE, PREREQUISITECOURSE, ASSIGNMENTS, EXAMS, COMPUTERLABS, SOFTWAREREQUIREMENTS, HOMEWORKINFO, ISACTIVE)
VALUES (SEQ_SYLLABUS_INFO.nextval,
        (SELECT ID
         FROM COURSES
         WHERE NUM = '208'
               AND DEPT_ID = (SELECT ID
                              FROM DEPARTMENTS
                              WHERE NAME = 'MATH') AND ROWNUM = 1),
        (SELECT ID
         FROM COURSES
         WHERE NAME = 'Office Hours' AND ROWNUM = 1),
        ' Introduction to discrete mathematics and its applications. This course will cover the following topics: Sets, relations and functions, combinatorics, logic, Boolean algebra, difference equations, graph theory, automata.',
        'CSCI 103 or dept. approval',
        'Assignments will not be graded but it is advised that students complete at least the section assignments as we progress between the exams.',
        'Approximately every other Tuesday during the last 1 or 2 hours of class we will have an exam that covers the previous 6 to 8 hours of lectures except for the 2 to 3 hours prior to the exam. Extra credit problems from the 2 hours prior to exam may appear on the exam.',
        ' ',
        ' ',
        ' ',
        1)
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_SYLLABUS_INFO) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'A Web-Based Introduction to Programming, 2nd Ed.',
    'Mike O''Kane',
    9781594608445
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Program Development and Design Using C++, 3rd Edition',
    'Gary Bronson',
    9780619216771
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Object-Oriented Programming in C++',
    'Richard Johnsonbaugh & Martin Kalin',
    9780130158857
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Unix and Linux System Administration Handbook, 4th Ed.',
    'Evi Nemeth et al.',
    9780131480056
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'The Unix Operating System, 3rd Ed.',
    'Kaare Christian and Susan Richter',
    9780471586845
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Networks',
    'Andrew S. Tanenbaum and David J. Wetherall',
    9780132126953
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Fundamentals of Database Systems, 6th Ed.',
    'Ramez Elmasri and Shamkant B. Navathe',
    9780136086208
  )
[2015-06-03 18:36:23] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Organization and Architecture, 9th Edition',
    'Stallings',
    9780132936330
  )
[2015-06-03 18:36:24] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Networks, 5th Edition',
    'Tanenbaum',
    9780132126973
  )
[2015-06-03 18:36:24] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Security, Principles and Practices, 2nd Edition',
    'Stallings',
    9780132775069
  )
[2015-06-03 18:36:24] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Network Security Essentials, 4th Edition',
    'William Stallings',
    9780136108054
  )
[2015-06-03 18:36:24] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Discrete Mathematics with Applications, 4th Edition',
    'Epp',
    9780495391326
  )
[2015-06-03 18:36:24] [23000][1] ORA-00001: unique constraint (KHADA.UNQ_TEXTBOOK_ISBN) violated

[2015-06-03 18:36:24] Summary: 132 of 132 statements executed, 132 failed in 2483 ms (103430 chars in file)
