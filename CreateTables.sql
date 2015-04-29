create table Departments
(
  DepartmentID number(5) primary key,
  DepartmentIdentifier nvarchar2(5) not null,
  DepartmentName nvarchar2(40) not null,
  constraint DepartmentIdentifer_Unique 
    unique (DepartmentIdentifier)
);
  
create table Courses
(
  ID number(5) primary key,
  DepartmentID number(5) not null,
  CourseNumber number(5) not null,
  CourseName nvarchar2(40) not null, 
  CourseDescription nvarchar2(2000) not null,
  constraint CourseNumber_Unique 
    unique (DepartmentID, CourseNumber)
);