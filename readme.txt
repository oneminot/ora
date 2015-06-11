[2015-06-10 21:16:43] Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
[2015-06-10 21:16:43] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-06-10 21:16:43] 0 row(s) affected in 113 ms
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
[2015-06-10 21:16:44] 0 row(s) affected in 129 ms
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID),
  CONSTRAINT unq_semesters UNIQUE (Name)
)
[2015-06-10 21:16:44] 0 row(s) affected in 174 ms
CREATE TABLE semesters_years (
  ID          NUMBER(5),
  Semester_ID NUMBER(5),
  Year        VARCHAR2(4),
  StartDate DATE,
  EndDate   DATE,
  CONSTRAINT pk_semesters_years PRIMARY KEY (ID),
  CONSTRAINT unq_semesters_years UNIQUE (Semester_ID, Year),
  CONSTRAINT fk_semesters_years_semesters FOREIGN KEY (Semester_ID) REFERENCES semesters (ID)
)
[2015-06-10 21:16:44] 0 row(s) affected in 173 ms
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
[2015-06-10 21:16:44] 0 row(s) affected in 141 ms
CREATE TABLE events
(
  ID        NUMBER(5),
  Class_ID  NUMBER(5) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate   DATE NOT NULL,
  CONSTRAINT pk_events PRIMARY KEY (ID),
  CONSTRAINT fk_events_classes FOREIGN KEY (Class_ID) REFERENCES classes (ID)
)
[2015-06-10 21:16:44] 0 row(s) affected in 76 ms
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-06-10 21:16:44] 0 row(s) affected in 111 ms
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek),
  CONSTRAINT fk_repeat_days_repeat_events FOREIGN KEY (RepeatEvent_ID) REFERENCES repeat_events (ID)
)
[2015-06-10 21:16:44] 0 row(s) affected in 133 ms
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
[2015-06-10 21:16:45] 0 row(s) affected in 138 ms
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-06-10 21:16:45] 0 row(s) affected in 132 ms
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR2(40) NOT NULL,
  Weight   NUMBER(3)    NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-06-10 21:16:45] 0 row(s) affected in 151 ms
CREATE TABLE textbooks (
  ID     NUMBER(5),
  Title  VARCHAR2(80) NOT NULL,
  Author VARCHAR2(80) NOT NULL,
  ISBN   VARCHAR2(13) NOT NULL,
  CONSTRAINT pk_textbook PRIMARY KEY (ID),
  CONSTRAINT unq_textbook_isbn UNIQUE (ISBN)
)
[2015-06-10 21:16:45] 0 row(s) affected in 141 ms
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
[2015-06-10 21:16:45] 0 row(s) affected in 145 ms
CREATE TABLE syllabus_info_textbooks (
  Textbook_ID      NUMBER(5) NOT NULL,
  Syllabus_Info_ID NUMBER(5) NOT NULL,
  CONSTRAINT fk_syllabus_info_textbooks FOREIGN KEY (Textbook_ID) REFERENCES textbooks (ID),
  CONSTRAINT fk_textbooks_syllabus_info FOREIGN KEY (Syllabus_Info_ID) REFERENCES syllabus_info (ID)
)
[2015-06-10 21:16:45] 0 row(s) affected in 106 ms
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID             NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID),
  CONSTRAINT fk_sac_syllabus_info FOREIGN KEY (Syllabus_ID) REFERENCES syllabus_info (ID),
  CONSTRAINT fk_sac_assign_cat FOREIGN KEY (AssignmentCategories_ID) REFERENCES assignment_categories (ID)
)
[2015-06-10 21:16:45] 0 row(s) affected in 115 ms
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  Year     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID),
  CONSTRAINT unq_publishers UNIQUE (Title, Location, Year)
)
[2015-06-10 21:16:46] 0 row(s) affected in 123 ms
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
[2015-06-10 21:16:46] 0 row(s) affected in 138 ms
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-06-10 21:16:46] 0 row(s) affected in 159 ms
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  Sequence_Number NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-06-10 21:16:46] 0 row(s) affected in 72 ms
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-06-10 21:16:46] 0 row(s) affected in 124 ms

[2015-06-10 21:16:46] Summary: 20 of 20 statements executed in 2915 ms (6593 chars in file)
[2015-06-10 21:17:02] Run C:\Users\minot_000\Source\Repos\ora\CreateSequences.sql
[2015-06-10 21:17:02] Connecting to Oracle - @loree.minotstateu.edu...
CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 39 ms
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 65 ms
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 37 ms
CREATE SEQUENCE seq_semesters_years
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 41 ms
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 38 ms
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 40 ms
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 37 ms
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 33 ms
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_textbooks
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 33 ms
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 38 ms
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 38 ms
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:02] 0 row(s) affected in 31 ms
CREATE SEQUENCE seq_author_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:03] 0 row(s) affected in 41 ms
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-06-10 21:17:03] 0 row(s) affected in 38 ms

[2015-06-10 21:17:03] Summary: 18 of 18 statements executed in 1019 ms (1198 chars in file)
[2015-06-10 21:17:50] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-06-10 21:17:50] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-06-10 21:17:50] 1 row(s) affected in 89 ms
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-06-10 21:17:50] 1 row(s) affected in 39 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Fall')
[2015-06-10 21:17:50] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Spring')
[2015-06-10 21:17:50] 1 row(s) affected in 35 ms
INSERT INTO SEMESTERS (ID, NAME) VALUES (SEQ_SEMESTERS.nextval, 'Summer')
[2015-06-10 21:17:51] 1 row(s) affected in 38 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    1,
    '2010',
    TO_DATE('2010/08/24 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2010/12/17 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    2,
    '2011',
    TO_DATE('2011/01/11 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2011/05/13 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    1,
    '2011',
    TO_DATE('2011/08/23 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2011/12/16 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    2,
    '2012',
    TO_DATE('2012/01/10 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2012/05/11 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    1,
    '2013',
    TO_DATE('2012/08/27 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2013/12/20 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 39 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    2,
    '2014',
    TO_DATE('2014/01/14 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2014/05/16 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    1,
    '2014',
    TO_DATE('2014/08/26 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2014/12/19 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 38 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    2,
    '2015',
    TO_DATE('2015/01/13 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2015/05/15 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO SEMESTERS_YEARS (ID, SEMESTER_ID, YEAR, STARTDATE, ENDDATE) VALUES
  (
    SEQ_SEMESTERS_YEARS.nextval,
    3,
    '2015',
    TO_DATE('2015/06/02 00:00:00', 'yyyy/mm/dd hh24:mi:ss'),
    TO_DATE('2015/07/30 23:59:59', 'yyyy/mm/dd hh24:mi:ss')
  )
[2015-06-10 21:17:51] 1 row(s) affected in 39 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '000', 'Office Hours', 'These are office hours.')
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-06-10 21:17:51] 1 row(s) affected in 37 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-06-10 21:17:51] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-06-10 21:17:51] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '260', 'UNIX Environment',
                                              'UNIX')
[2015-06-10 21:17:51] 1 row(s) affected in 33 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-06-10 21:17:51] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-06-10 21:17:51] 1 row(s) affected in 42 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-06-10 21:17:51] 1 row(s) affected in 39 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-06-10 21:17:51] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'Introduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-06-10 21:17:51] 1 row(s) affected in 45 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-06-10 21:17:51] 1 row(s) affected in 35 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-06-10 21:17:51] 1 row(s) affected in 39 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 2, '208', 'Discrete Mathematics',
                                              'Discrete Math')
[2015-06-10 21:17:51] 1 row(s) affected in 40 ms
INSERT INTO CLASSES (ID, NUM, COURSE_ID, SEMESTER_YEAR_ID) VALUES
  (
    SEQ_CLASSES.nextval,
    '000',
    (
      SELECT ID
      FROM COURSES
      WHERE NAME = 'Office Hours'
    ),
    (
      SELECT ID
      FROM SEMESTERS_YEARS
      WHERE SEMESTER_ID =
            (
              SELECT ID
              FROM SEMESTERS
              WHERE NAME = 'Summer'
            )
            AND YEAR = '2015'
            AND ROWNUM = 1
    )
  )
[2015-06-10 21:17:51] 1 row(s) affected in 39 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 48 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 47 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 50 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 39 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 49 ms
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
[2015-06-10 21:17:52] 1 row(s) affected in 39 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 49 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 43 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 46 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 39 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 43 ms
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
[2015-06-10 21:17:53] 1 row(s) affected in 49 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'P. Loree')
[2015-06-10 21:17:53] 1 row(s) affected in 32 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K. Nygard')
[2015-06-10 21:17:53] 1 row(s) affected in 41 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'X. Du')
[2015-06-10 21:17:53] 1 row(s) affected in 33 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'K.K. Gagneja')
[2015-06-10 21:17:53] 1 row(s) affected in 41 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F. Ranganathan')
[2015-06-10 21:17:53] 1 row(s) affected in 34 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.B. Ghosn')
[2015-06-10 21:17:53] 1 row(s) affected in 39 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'L.M. Alnemer')
[2015-06-10 21:17:53] 1 row(s) affected in 31 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'R.I. Seetan')
[2015-06-10 21:17:53] 1 row(s) affected in 41 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'F.M. Bassi')
[2015-06-10 21:17:53] 1 row(s) affected in 51 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'C. Chitraranjan')
[2015-06-10 21:17:53] 1 row(s) affected in 37 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A. Helsene')
[2015-06-10 21:17:53] 1 row(s) affected in 32 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'Y.Q. Gu')
[2015-06-10 21:17:53] 1 row(s) affected in 32 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.C. Luo')
[2015-06-10 21:17:53] 1 row(s) affected in 33 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'M.J. Iqbqal')
[2015-06-10 21:17:53] 1 row(s) affected in 31 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'G.R. Lazo')
[2015-06-10 21:17:53] 1 row(s) affected in 32 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'A.M. Denton')
[2015-06-10 21:17:53] 1 row(s) affected in 52 ms
INSERT INTO AUTHORS (ID, NAME) VALUES (SEQ_AUTHORS.nextval, 'S.F. Kianin')
[2015-06-10 21:17:53] 1 row(s) affected in 46 ms
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, '2009 IEEE GLOBECOM', 'Honolulu, HI', '1999')
[2015-06-10 21:17:54] 1 row(s) affected in 32 ms
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR) VALUES
  (SEQ_PUBLISHERS.nextval, 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference', 'Indianapolis, IN',
   '2012')
[2015-06-10 21:17:54] 1 row(s) affected in 41 ms
INSERT INTO PUBLISHERS (ID, TITLE, LOCATION, YEAR)
VALUES (SEQ_PUBLISHERS.nextval, 'Functional & Integrative Geonomics', 'New York City, NY', '2013')
[2015-06-10 21:17:54] 1 row(s) affected in 40 ms
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks',
   'PID969207.pdf', (SELECT ID
                     FROM PUBLISHERS
                     WHERE TITLE = '2009 IEEE GLOBECOM' AND ROWNUM = 1), NULL)
[2015-06-10 21:17:54] 1 row(s) affected in 41 ms
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Limiting transmit power of antennas in Heterogeneous Sensor Networks', 'PID969207.pdf',
   (SELECT ID
    FROM PUBLISHERS
    WHERE TITLE = 'Electro/Information Technology (EIT), 2012 IEEE Int''l Conference' AND ROWNUM = 1), NULL)
[2015-06-10 21:17:54] 1 row(s) affected in 40 ms
INSERT INTO ARTICLES (ID, TITLE, RELATIVEFILELOCATION, PUBLISHER_ID, PAGEREFERENCE) VALUES
  (SEQ_ARTICLES.nextval, 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes',
   'PID06220775.pdf', (SELECT ID
                       FROM PUBLISHERS
                       WHERE TITLE = 'Functional & Integrative Geonomics' AND ROWNUM = 1),
   'Springer-Verlag, 2013, pp. 11-17')
[2015-06-10 21:17:54] 1 row(s) affected in 32 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 32 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 36 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'X. Du'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Efficient Post-Deployment Key Establishment Scheme for Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 46 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K.K. Gagneja'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 33 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F. Ranganathan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  SEQ_AUTHOR_ARTICLES.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 48 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 56 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 40 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'K. Nygard'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Limiting transmit power of antennas in Heterogeneous Sensor Networks'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 40 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'L.M. Alnemer'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 56 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'R.I. Seetan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 49 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'F.M. Bassi'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 68 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'C. Chitraranjan'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 36 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A. Helsene'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 41 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'P. Loree'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 40 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.B. Ghosn'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 41 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'Y.Q. Gu'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 56 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.C. Luo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:54] 1 row(s) affected in 43 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'M.J. Iqbqal'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:55] 1 row(s) affected in 38 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'G.R. Lazo'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:55] 1 row(s) affected in 32 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'A.M. Denton'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:55] 1 row(s) affected in 40 ms
INSERT INTO AUTHOR_ARTICLES (AUTHOR_ID, ARTICLE_ID, SEQUENCE_NUMBER) VALUES (
  (SELECT ID
   FROM AUTHORS
   WHERE NAME = 'S.F. Kianin'),
  (SELECT ID
   FROM ARTICLES
   WHERE TITLE = 'Wheat Zapper: a flexible online tool for colinearity studies in grass genomes'),
  seq_author_articles.nextval)
[2015-06-10 21:17:55] 1 row(s) affected in 32 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 90, 100, 'A')
[2015-06-10 21:17:55] 1 row(s) affected in 38 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 80, 89, 'B')
[2015-06-10 21:17:55] 1 row(s) affected in 33 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 70, 79, 'C')
[2015-06-10 21:17:55] 1 row(s) affected in 33 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 60, 69, 'D')
[2015-06-10 21:17:55] 1 row(s) affected in 46 ms
INSERT INTO GRADE_SCALES (ID, LOW, HIGH, LETTER) VALUES (SEQ_GRADE_SCALES.nextval, 0, 59, 'F')
[2015-06-10 21:17:55] 1 row(s) affected in 32 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 42 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 42 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 41 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 39 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 42 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 40 ms
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
[2015-06-10 21:17:55] 1 row(s) affected in 58 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'A Web-Based Introduction to Programming, 2nd Ed.',
    'Mike O''Kane',
    9781594608445
  )
[2015-06-10 21:17:55] 1 row(s) affected in 46 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Program Development and Design Using C++, 3rd Edition',
    'Gary Bronson',
    9780619216771
  )
[2015-06-10 21:17:55] 1 row(s) affected in 46 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Object-Oriented Programming in C++',
    'Richard Johnsonbaugh & Martin Kalin',
    9780130158857
  )
[2015-06-10 21:17:56] 1 row(s) affected in 37 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Unix and Linux System Administration Handbook, 4th Ed.',
    'Evi Nemeth et al.',
    9780131480056
  )
[2015-06-10 21:17:56] 1 row(s) affected in 31 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'The Unix Operating System, 3rd Ed.',
    'Kaare Christian and Susan Richter',
    9780471586845
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Networks',
    'Andrew S. Tanenbaum and David J. Wetherall',
    9780132126953
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Fundamentals of Database Systems, 6th Ed.',
    'Ramez Elmasri and Shamkant B. Navathe',
    9780136086208
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Organization and Architecture, 9th Edition',
    'Stallings',
    9780132936330
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Networks, 5th Edition',
    'Tanenbaum',
    9780132126973
  )
[2015-06-10 21:17:56] 1 row(s) affected in 34 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Computer Security, Principles and Practices, 2nd Edition',
    'Stallings',
    9780132775069
  )
[2015-06-10 21:17:56] 1 row(s) affected in 38 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Network Security Essentials, 4th Edition',
    'William Stallings',
    9780136108054
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO TEXTBOOKS (ID, TITLE, AUTHOR, ISBN) VALUES
  (
    SEQ_TEXTBOOKS.nextval,
    'Discrete Mathematics with Applications, 4th Edition',
    'Epp',
    9780495391326
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9781594608445
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 111
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 41 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780619216771
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 160
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780130158857
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 161
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780131480056
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 260
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 42 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780471586845
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 260
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 31 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780132126953
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 340
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780136086208
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 356
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780132936330
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 370
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780132126973
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 440
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780132775069
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 440
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'CSCI'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780136108054
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 208
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'MATH'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_INFO_TEXTBOOKS (TEXTBOOK_ID, SYLLABUS_INFO_ID) VALUES
  (
    (
      SELECT ID
      FROM TEXTBOOKS
      WHERE ISBN = 9780495391326
    ),
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE NUM = 208
                    AND DEPT_ID =
                        (
                          SELECT id
                          FROM departments
                          WHERE name = 'MATH'
                        )
            )
    )
  )
[2015-06-10 21:17:56] 1 row(s) affected in 41 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Exams',
    35
  )
[2015-06-10 21:17:56] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Exams',
    40
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Exams',
    50
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Exams',
    60
  )
[2015-06-10 21:17:56] 1 row(s) affected in 38 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Exams',
    90
  )
[2015-06-10 21:17:56] 1 row(s) affected in 33 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Assignments',
    40
  )
[2015-06-10 21:17:56] 1 row(s) affected in 40 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Assignments',
    60
  )
[2015-06-10 21:17:57] 1 row(s) affected in 33 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Assignments',
    35
  )
[2015-06-10 21:17:57] 1 row(s) affected in 31 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Assignments',
    90
  )
[2015-06-10 21:17:57] 1 row(s) affected in 33 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Assignments',
    25
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Assignments',
    10
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Labs',
    10
  )
[2015-06-10 21:17:57] 1 row(s) affected in 31 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Labs',
    25
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Discussion Participation',
    5
  )
[2015-06-10 21:17:57] 1 row(s) affected in 37 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Discussion Participation',
    10
  )
[2015-06-10 21:17:57] 1 row(s) affected in 38 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Project Proposal',
    10
  )
[2015-06-10 21:17:57] 1 row(s) affected in 39 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Weekly Progress Reports',
    5
  )
[2015-06-10 21:17:57] 1 row(s) affected in 33 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Project research/work',
    50
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Project research/work',
    60
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Project Presentation',
    10
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO ASSIGNMENT_CATEGORIES (ID, CATEGORY, WEIGHT) VALUES
  (
    SEQ_ASSIGNMENT_CATEGORIES.nextval,
    'Project Paper/report',
    15
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '111'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 74 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '111'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 40
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 34 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '160'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '160'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 40
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 31 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '161'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 40
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '161'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 41 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '221'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 35
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '221'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 46 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '221'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 5
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 29 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '260'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 30 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '260'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 35
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 34 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '260'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 5
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 31 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '321'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 90
    )
  )
[2015-06-10 21:17:57] 1 row(s) affected in 31 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '221'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 40 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '340'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 50
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '340'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 35
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '340'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 5
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '340'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Labs'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '356'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '356'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 35
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 24 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '356'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 5
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '370'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 50
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '370'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 40
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '370'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '440'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 40
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '440'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 25
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '440'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '440'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Labs'
            AND WEIGHT = 25
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '458'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 40
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '458'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Assignments'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 54 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '458'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Project research/work'
            AND WEIGHT = 50
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 35 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '460'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Project Proposal'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 31 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '460'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Weekly Progress Reports'
            AND WEIGHT = 5
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 25 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '460'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Project research/work'
            AND WEIGHT = 60
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '460'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Project Presentation'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 31 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'CSCI'
                    )
                    AND num = '460'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Project Paper/report'
            AND WEIGHT = 15
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'MATH'
                    )
                    AND num = '208'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Exams'
            AND WEIGHT = 90
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 34 ms
INSERT INTO SYLLABUS_ASSIGN_CATEGORIES (SYLLABUS_ID, ASSIGNMENTCATEGORIES_ID) VALUES
  (
    (
      SELECT ID
      FROM SYLLABUS_INFO
      WHERE COURSE_ID =
            (
              SELECT ID
              FROM COURSES
              WHERE DEPT_ID =
                    (
                      SELECT ID
                      FROM DEPARTMENTS
                      WHERE name = 'MATH'
                    )
                    AND num = '208'
            )
    ),
    (
      SELECT ID
      FROM ASSIGNMENT_CATEGORIES
      WHERE CATEGORY = 'Discussion Participation'
            AND WEIGHT = 10
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 31 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '20012'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2010
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2010
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 40 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '20627'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2010
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2010
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '19567'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2010
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2010
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 32 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '19670'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:58] 1 row(s) affected in 33 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '3645'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 33 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '19667'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 43 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '6132'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 37 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '6863'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 40 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '7055'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 32 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '6630'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2011
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 33 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4876'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 41 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4457'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 49 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4458'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 32 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4668'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2012
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 44 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '13412'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2013
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2013
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 36 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '13414'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2013
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2013
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 42 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '13416'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2013
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2013
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 56 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '5132'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 32 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '5285'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 42 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '5518'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 41 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '5286'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 38 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '12317'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 42 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '12102'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 47 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '12104'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 1
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2014
            AND SEMESTER_ID = 1
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 59 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4154'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 49 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '26115'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 47 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4294'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 40 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4431'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:17:59] 1 row(s) affected in 40 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '4295'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 2
    )
  )
[2015-06-10 21:18:00] 1 row(s) affected in 39 ms
INSERT INTO EVENTS
(
  ID,
  CLASS_ID,
  STARTDATE,
  ENDDATE
)
VALUES
  (
    SEQ_EVENTS.nextval,
    (
      SELECT ID
      FROM CLASSES
      WHERE NUM = '10930'
    ),
    (
      SELECT STARTDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 3
    ),
    (
      SELECT ENDDATE
      FROM SEMESTERS_YEARS
      WHERE year = 2015
            AND SEMESTER_ID = 3
    )
  )
[2015-06-10 21:18:00] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '10930'
            )
    ),
    TO_DATE('09:00:00', 'hh24:mi:ss'),
    TO_DATE('13:00:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 40 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4154'
            )
    ),
    TO_DATE('14:00:00', 'hh24:mi:ss'),
    TO_DATE('14:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 53 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4294'
            )
    ),
    TO_DATE('12:00:00', 'hh24:mi:ss'),
    TO_DATE('12:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 37 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4431'
            )
    ),
    TO_DATE('8:00:00', 'hh24:mi:ss'),
    TO_DATE('8:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4295'
            )
    ),
    TO_DATE('15:00:00', 'hh24:mi:ss'),
    TO_DATE('15:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '12317'
            )
    ),
    TO_DATE('14:00:00', 'hh24:mi:ss'),
    TO_DATE('14:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '12102'
            )
    ),
    TO_DATE('8:00:00', 'hh24:mi:ss'),
    TO_DATE('8:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 50 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '12104'
            )
    ),
    TO_DATE('13:00:00', 'hh24:mi:ss'),
    TO_DATE('13:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 37 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '5132'
            )
    ),
    TO_DATE('9:00:00', 'hh24:mi:ss'),
    TO_DATE('9:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '5285'
            )
    ),
    TO_DATE('12:00:00', 'hh24:mi:ss'),
    TO_DATE('12:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 43 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '5518'
            )
    ),
    TO_DATE('11:00:00', 'hh24:mi:ss'),
    TO_DATE('11:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 41 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '5286'
            )
    ),
    TO_DATE('14:00:00', 'hh24:mi:ss'),
    TO_DATE('14:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 48 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '13412'
            )
    ),
    TO_DATE('14:00:00', 'hh24:mi:ss'),
    TO_DATE('14:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 41 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '13414'
            )
    ),
    TO_DATE('8:00:00', 'hh24:mi:ss'),
    TO_DATE('8:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 39 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '13416'
            )
    ),
    TO_DATE('13:00:00', 'hh24:mi:ss'),
    TO_DATE('13:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4876'
            )
    ),
    TO_DATE('13:00:00', 'hh24:mi:ss'),
    TO_DATE('13:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 50 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4457'
            )
    ),
    TO_DATE('11:00:00', 'hh24:mi:ss'),
    TO_DATE('11:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 39 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4458'
            )
    ),
    TO_DATE('9:00:00', 'hh24:mi:ss'),
    TO_DATE('9:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '4668'
            )
    ),
    TO_DATE('12:00:00', 'hh24:mi:ss'),
    TO_DATE('12:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 44 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '6863'
            )
    ),
    TO_DATE('10:00:00', 'hh24:mi:ss'),
    TO_DATE('10:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 59 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '7055'
            )
    ),
    TO_DATE('11:00:00', 'hh24:mi:ss'),
    TO_DATE('11:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 35 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '6630'
            )
    ),
    TO_DATE('13:00:00', 'hh24:mi:ss'),
    TO_DATE('13:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:00] 1 row(s) affected in 36 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '19670'
            )
    ),
    TO_DATE('13:00:00', 'hh24:mi:ss'),
    TO_DATE('13:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 28 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '3645'
            )
    ),
    TO_DATE('12:00:00', 'hh24:mi:ss'),
    TO_DATE('12:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '19667'
            )
    ),
    TO_DATE('8:00:00', 'hh24:mi:ss'),
    TO_DATE('8:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 40 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '6132'
            )
    ),
    TO_DATE('11:00:00', 'hh24:mi:ss'),
    TO_DATE('11:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 43 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '20012'
            )
    ),
    TO_DATE('10:00:00', 'hh24:mi:ss'),
    TO_DATE('10:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 37 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '20627'
            )
    ),
    TO_DATE('11:00:00', 'hh24:mi:ss'),
    TO_DATE('11:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_EVENTS (ID, EVENT_ID, STARTDATETIME, ENDDATETIME)
VALUES
  (
    SEQ_REPEAT_EVENTS.nextval,
    (
      SELECT ID
      FROM EVENTS
      WHERE CLASS_ID =
            (
              SELECT ID
              FROM CLASSES
              WHERE NUM = '19567'
            )
    ),
    TO_DATE('13:00:00', 'hh24:mi:ss'),
    TO_DATE('13:50:00', 'hh24:mi:ss')
  )
[2015-06-10 21:18:01] 1 row(s) affected in 46 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '10930'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 35 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '10930'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4154'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 23 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4154'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4154'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:01] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4154'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:01] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4294'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4294'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4294'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4294'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:01] 1 row(s) affected in 23 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4431'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4431'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4431'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4431'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:01] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4295'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4295'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4295'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:01] 1 row(s) affected in 34 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4295'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12317'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12317'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12317'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:01] 1 row(s) affected in 37 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12317'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:01] 1 row(s) affected in 34 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12102'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:01] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12102'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:01] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12102'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:01] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12102'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:02] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12104'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12104'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12104'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '12104'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:02] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5132'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5132'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 23 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5132'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5132'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:02] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5285'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 27 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5285'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5285'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5285'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5518'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5518'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 36 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5518'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5518'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5286'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5286'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5286'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 23 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '5286'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:02] 1 row(s) affected in 36 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 29 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:02] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] [23000][1] ORA-00001: unique constraint (KHADA.PK_REPEAT_DAYS) violated
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] [23000][1] ORA-00001: unique constraint (KHADA.PK_REPEAT_DAYS) violated
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13412'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] [23000][1] ORA-00001: unique constraint (KHADA.PK_REPEAT_DAYS) violated
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13414'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:02] 1 row(s) affected in 37 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13416'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:02] 1 row(s) affected in 37 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13416'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13416'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:02] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '13416'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:02] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4876'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4876'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4876'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4876'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4457'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4457'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4457'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 38 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4457'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 27 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4458'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4458'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 35 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4458'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 28 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4458'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4668'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4668'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 34 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4668'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 42 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '4668'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6863'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6863'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6863'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6863'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 54 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '7055'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '7055'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '7055'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '7055'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6630'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6630'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6630'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:03] 1 row(s) affected in 47 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6630'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:03] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19670'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:03] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19670'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:03] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19670'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 28 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19670'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:04] 1 row(s) affected in 27 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '3645'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '3645'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '3645'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '3645'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:04] 1 row(s) affected in 43 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19667'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:04] 1 row(s) affected in 28 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19667'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19667'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 36 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19667'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:04] 1 row(s) affected in 28 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6132'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6132'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6132'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 32 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '6132'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:04] 1 row(s) affected in 24 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20012'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:04] 1 row(s) affected in 25 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20012'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:04] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20012'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 26 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20012'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:04] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20627'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:04] 1 row(s) affected in 28 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20627'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:04] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20627'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 31 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '20627'
                   )
           )
    ),
    4
  )
[2015-06-10 21:18:04] 1 row(s) affected in 33 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19567'
                   )
           )
    ),
    1
  )
[2015-06-10 21:18:04] 1 row(s) affected in 30 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19567'
                   )
           )
    ),
    2
  )
[2015-06-10 21:18:04] 1 row(s) affected in 27 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19567'
                   )
           )
    ),
    3
  )
[2015-06-10 21:18:04] 1 row(s) affected in 29 ms
INSERT INTO REPEAT_DAYS (REPEATEVENT_ID, DAYNUMBEROFWEEK)
VALUES
  (
    (SELECT ID
     FROM REPEAT_EVENTS
     WHERE EVENT_ID =
           (
             SELECT ID
             FROM EVENTS
             WHERE CLASS_ID =
                   (
                     SELECT ID
                     FROM CLASSES
                     WHERE NUM = '19567'
                   )
           )
    ),
    5
  )
[2015-06-10 21:18:04] 1 row(s) affected in 25 ms

[2015-06-10 21:18:04] Summary: 377 of 377 statements executed, 3 failed in 14292 ms (206183 chars in file)
