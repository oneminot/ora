create table Departments
  (
    id number(5) primary key,
    DepartmentIdentifier nvarchar2(5),
    constraint DepartmentIdentifer_Unique unique (DepartmentIdentifier)
  );