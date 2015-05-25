Motivation for table structure

    Table names are always plural where possible.
    For example, we will use persons over person as a table name.

    The primary key in each of the tables below is an integer.
    We will need some kind of a trigger to increment this integer when we insert a new row.

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
  Dept_ID     NUMBER(5)      NOT NULL,
  Num         VARCHAR2(6)    NOT NULL,
  Name        VARCHAR2(40)   NOT NULL,
  Description VARCHAR2(2000) NOT NULL,
  CONSTRAINT pk_courses PRIMARY KEY (ID),
  CONSTRAINT unq_courses UNIQUE (Dept_ID, Num),
  CONSTRAINT fk_courses_departments FOREIGN KEY (Dept_ID) REFERENCES departments (ID)
);
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  Year VARCHAR2(4)  NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID),
  CONSTRAINT unq_semesters UNIQUE (Name, Year)
);
CREATE TABLE classes
(
  ID          NUMBER(5),
  Num         VARCHAR2(6) NOT NULL,
  Course_ID   NUMBER(5)   NOT NULL,
  Semester_ID NUMBER(5)   NOT NULL,
  CONSTRAINT pk_classes PRIMARY KEY (ID),
  CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
  CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID)
);
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
);
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
);
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek)
);
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
);
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
);
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR(40) NOT NULL,
  Weight   NUMBER(3)   NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
);
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  Textbook             VARCHAR2(2000) NOT NULL,
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
);
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID              NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID)
);
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  YEAR     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID)
);
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
);
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
);
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
);
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
);

[2015-05-25 12:09:06] Run C:\Users\minot_000\Source\Repos\ora\CreateTables.sql
[2015-05-25 12:09:06] Connecting to Oracle - @loree.minotstateu.edu...
CREATE TABLE departments
(
  ID   NUMBER(5),
  Name VARCHAR2(4) NOT NULL,
  CONSTRAINT pk_departments PRIMARY KEY (ID),
  CONSTRAINT unq_departments UNIQUE (Name)
)
[2015-05-25 12:09:06] 0 row(s) affected in 151 ms
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
[2015-05-25 12:09:07] 0 row(s) affected in 175 ms
CREATE TABLE semesters
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  Year VARCHAR2(4)  NOT NULL,
  CONSTRAINT pk_semesters PRIMARY KEY (ID),
  CONSTRAINT unq_semesters UNIQUE (Name, Year)
)
[2015-05-25 12:09:07] 0 row(s) affected in 116 ms
CREATE TABLE classes
(
  ID          NUMBER(5),
  Num         VARCHAR2(6) NOT NULL,
  Course_ID   NUMBER(5)   NOT NULL,
  Semester_ID NUMBER(5)   NOT NULL,
  CONSTRAINT pk_classes PRIMARY KEY (ID),
  CONSTRAINT unq_classes UNIQUE (Num, Course_ID),
  CONSTRAINT fk_classes_courses FOREIGN KEY (Course_ID) REFERENCES courses (ID)
)
[2015-05-25 12:09:07] 0 row(s) affected in 191 ms
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
[2015-05-25 12:09:07] 0 row(s) affected in 246 ms
CREATE TABLE repeat_events
(
  ID            NUMBER(5),
  Event_ID      NUMBER(5) NOT NULL,
  StartDateTime DATE      NOT NULL,
  EndDateTime   DATE      NOT NULL,
  CONSTRAINT pk_repeat_events PRIMARY KEY (ID),
  CONSTRAINT fk_repeat_events_events FOREIGN KEY (Event_ID) REFERENCES events (ID)
)
[2015-05-25 12:09:07] 0 row(s) affected in 73 ms
CREATE TABLE repeat_days
(
  RepeatEvent_ID  NUMBER(5),
  DayNumberOfWeek NUMBER(1),
  CONSTRAINT pk_repeat_days PRIMARY KEY (RepeatEvent_ID, DayNumberOfWeek)
)
[2015-05-25 12:09:07] 0 row(s) affected in 132 ms
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
[2015-05-25 12:09:08] 0 row(s) affected in 276 ms
CREATE TABLE grade_scales
(
  ID     NUMBER(5),
  Low    NUMBER(3) NOT NULL,
  High   NUMBER(3) NOT NULL,
  Letter CHAR(1)   NOT NULL,
  CONSTRAINT pk_grade_scales PRIMARY KEY (ID),
  CONSTRAINT unq_grade_scales UNIQUE (Low, High, Letter)
)
[2015-05-25 12:09:08] 0 row(s) affected in 135 ms
CREATE TABLE assignment_categories
(
  ID       NUMBER(5),
  Category VARCHAR(40) NOT NULL,
  Weight   NUMBER(3)   NOT NULL,
  CONSTRAINT pk_assignment_categories PRIMARY KEY (ID),
  CONSTRAINT unq_assignment_categories UNIQUE (Category, Weight)
)
[2015-05-25 12:09:08] 0 row(s) affected in 188 ms
CREATE TABLE syllabus_info
(
  ID                   NUMBER(5),
  Course_ID            NUMBER(5)      NOT NULL,
  OfficeHour_ID        NUMBER(5)      NOT NULL,
  Textbook             VARCHAR2(2000) NOT NULL,
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
[2015-05-25 12:09:08] 0 row(s) affected in 326 ms
CREATE TABLE syllabus_assign_categories
(
  Syllabus_ID NUMBER(5),
  AssignmentCategories_ID NUMBER(5),
  CONSTRAINT pk_syllabus_assign_categories PRIMARY KEY (Syllabus_ID, AssignmentCategories_ID)
)
[2015-05-25 12:09:08] 0 row(s) affected in 107 ms
CREATE TABLE publishers
(
  ID       NUMBER(5),
  Title    VARCHAR2(80) NOT NULL,
  Location VARCHAR2(80) NOT NULL,
  YEAR     VARCHAR2(4),
  CONSTRAINT pk_publishers PRIMARY KEY (ID)
)
[2015-05-25 12:09:09] 0 row(s) affected in 149 ms
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
[2015-05-25 12:09:09] 0 row(s) affected in 209 ms
CREATE TABLE authors
(
  ID   NUMBER(5),
  Name VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_authors PRIMARY KEY (ID),
  CONSTRAINT unq_authors UNIQUE (Name)
)
[2015-05-25 12:09:09] 0 row(s) affected in 183 ms
CREATE TABLE author_articles
(
  Author_ID  NUMBER(5) NOT NULL,
  Article_ID NUMBER(5) NOT NULL,
  CONSTRAINT pk_author_articles PRIMARY KEY (Author_ID, Article_ID),
  CONSTRAINT fk_author_articles_authors FOREIGN KEY (Author_ID) REFERENCES authors (ID),
  CONSTRAINT fk_author_articles_articles FOREIGN KEY (Article_ID) REFERENCES articles (ID)
)
[2015-05-25 12:09:09] 0 row(s) affected in 116 ms
CREATE TABLE users
(
  ID           NUMBER(5)      NOT NULL,
  Name         VARCHAR2(255)  NOT NULL,
  Password     VARCHAR2(2000) NOT NULL,
  AttemptCount NUMBER(5)      NOT NULL,
  LastAttempt  TIMESTAMP      NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (ID)
)
[2015-05-25 12:09:09] 0 row(s) affected in 142 ms

[2015-05-25 12:09:09] Summary: 17 of 17 statements executed in 3166 ms (5292 chars in file)


[2015-05-25 12:09:51] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-05-25 12:09:51] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'ntroduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-05-25 12:09:51] [42000][2289] ORA-02289: sequence does not exist
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-05-25 12:09:52] [42000][2289] ORA-02289: sequence does not exist

[2015-05-25 12:09:52] Summary: 13 of 13 statements executed, 13 failed in 774 ms (6558 chars in file)


[2015-05-25 12:10:13] Run C:\Users\minot_000\Source\Repos\ora\CreateSequences
[2015-05-25 12:10:13] Connecting to Oracle - @loree.minotstateu.edu...
CREATE SEQUENCE seq_departments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 42 ms
CREATE SEQUENCE seq_courses
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 31 ms
CREATE SEQUENCE seq_semesters
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_classes
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_repeat_events
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_repeat_days
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 33 ms
CREATE SEQUENCE seq_assignments
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_grade_scales
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 34 ms
CREATE SEQUENCE seq_assignment_categories
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_syllabus_info
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_publishers
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 32 ms
CREATE SEQUENCE seq_articles
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 31 ms
CREATE SEQUENCE seq_authors
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 33 ms
CREATE SEQUENCE seq_users
START WITH 1
INCREMENT BY 1 NOCACHE
[2015-05-25 12:10:13] 0 row(s) affected in 34 ms

[2015-05-25 12:10:13] Summary: 15 of 15 statements executed in 734 ms (991 chars in file)

[2015-05-25 12:10:38] Run C:\Users\minot_000\Source\Repos\ora\InsertData.sql
[2015-05-25 12:10:38] Connecting to Oracle - @loree.minotstateu.edu...
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'CSCI')
[2015-05-25 12:10:38] 1 row(s) affected in 47 ms
INSERT INTO DEPARTMENTS
(ID, NAME) VALUES (SEQ_DEPARTMENTS.nextval, 'MATH')
[2015-05-25 12:10:38] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '111', 'Introduction to Web Languages',
                                              'Basic tools and principles of programming with focus on development of web applications using the PHP programming language. This course will cover the following topics: HTML, CSS, PHP, file handling, database management, logic, repetition, UNIX commands, and software design')
[2015-05-25 12:10:38] 1 row(s) affected in 33 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '160', 'Computer Science I',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Data Types, Assignments, Selection, Repetition, Functions and Procedures, Arrays and Pointers')
[2015-05-25 12:10:38] 1 row(s) affected in 31 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '161', 'Computer Science II',
                                              'Basic tools and principles of programming with focus on developing software using the C++ programming language. This course will cover the following topics: Classes, Inheritance, Polymorphism, Operator overloading Templates Hierarchy, Exceptions and object oriented programming in the microsoft foundation classes')
[2015-05-25 12:10:38] 1 row(s) affected in 40 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '221', 'Web and Internet Programming',
                                              'Introduction to web and internet programming. Topics covered will be web application development using HTML, CSS, PHP, JavaScript, AJAX, JQuery, JSON, XML, SQL, and web application and server security. ASP .NET website development using C# may also be introduced if time allows during the semester.')
[2015-05-25 12:10:38] 1 row(s) affected in 31 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '321', 'Windows Programming',
                                              'Introduction to Windows programming in Visual C# .NET Windows Forms and WPF development, icons, controls, dialogs, threads, sockets, DLL''s')
[2015-05-25 12:10:38] 1 row(s) affected in 33 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '340', 'Local Area Networks',
                                              'Introduction to basic networking including the layered OSI and TCP models, IPv4, IPv6 addressing, CIDR addressing, Network Address Translation, routing algorithms, common network protocols such as the IEEE 802.1x protocols, IP, TCP, UDP, FTP, HTTP, SMTP, etc. Additionally, an introduction to network security and network organization concepts will be covered such as local area networks (LANs), wide area networks (WANs), and ad hoc networking.')
[2015-05-25 12:10:38] 1 row(s) affected in 33 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '356', 'Database Management',
                                              'Introduction of database management systems including relational, hierarchical, and network models. Usage of tools and procedures for designing relational database models for provided datasets. Implementation of database models into a database management system (DBMS). Managing data using the SQL and PL/SQL languages. Concepts covered will include normalization, set theory, DBMS indexing, creating and deleting tables, inserting data into tables, and retrieving data from databases using select, nested select, joins, database security and other advanced SQL techniques.')
[2015-05-25 12:10:38] 1 row(s) affected in 40 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '370', 'Computer Organization and Architecture',
                                              'Introduction to the internal organization of computers and computer architectures. This course will cover the following topics: representation of data, Boolean algebra and digital logic, assembly, memory organization and architecture, I/O and storage, system software, network organization and architecture, data structures')
[2015-05-25 12:10:38] 1 row(s) affected in 32 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES
  (SEQ_COURSES.nextval, 1, '440', 'Data Communications - Wireless Networking and Communications',
   'ntroduction to advanced networking technologies and computer security. This course will cover the following topics: fundamentals of wireless transmission, communication networks, OSI model and TCP/IP, signaling techniques, wireless routing, wireless medium error detection and correction, satellite communications, cellular networks, ad hoc networks, sensor networks, IEEE 802.11, IEEE 802.16, IEEE 802.15.4 in the first 1 month of the course. The remainder of the course will focus on network/computer security and forensics including but not limited to the following topics: security concepts, threats, attacks and assets, cryptographic tools: symmetric and public-key encryption algorithms, authentication, malicious software, DoS attacks, intrusion detection, firewalls and prevention systems, buffer overflows, email security, X.509 certificates, legal and ethical issues in computer security')
[2015-05-25 12:10:38] 1 row(s) affected in 43 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '458', 'Computer Security',
                                              'This course will provide an introduction to computer and network security methods and procedures. This course will cover the following topics: security attacks, services and mechanisms, symmetric encryption, asymmetric encryption, hash functions and digital signatures, key management, Kerberos, X.509 Authentication, PHP, S/MIME, IPSec, SSL, TLS, IDS, security threats, firewalls, etc.')
[2015-05-25 12:10:38] 1 row(s) affected in 38 ms
INSERT INTO COURSES
(ID, DEPT_ID, NUM, NAME, DESCRIPTION) VALUES (SEQ_COURSES.nextval, 1, '460', 'Capstone Project Development', 'The Capstone Project is a substantial, semester-long endeavor allowing students to apply and or enhance the knowledge they have gained within the Computer Science curriculum. Each project is to be completed by an individual or group of students.
Topics for projects can be based on the interests of the students, chosen from ideas submitted by CS faculty, or coordinated with needs of other departments or from organizations outside the university. Students should be involved in the project selection, but the instructor has final authority on what is considered a suitable project. There will be greater expectations for teams of two or more students.')
[2015-05-25 12:10:38] 1 row(s) affected in 32 ms

[2015-05-25 12:10:38] Summary: 13 of 13 statements executed in 722 ms (6558 chars in file)
