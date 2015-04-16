CREATE TABLE Departments
  (
    ID NUMBER(5) PRIMARY KEY,
    DepartmentIdentifier NVARCHAR2(5) NOT NULL,
    CONSTRAINT DepartmentIdentifer_Unique UNIQUE (DepartmentIdentifier)
  );