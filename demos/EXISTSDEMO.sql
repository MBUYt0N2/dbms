CREATE DATABASE EXISTSDEMO;
USE EXISTSDEMO;

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Department_ID INT
);

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);

INSERT INTO Employee VALUES (1, 'John Doe', 101);
INSERT INTO Employee VALUES (2, 'Jane Smith', 102);
INSERT INTO Employee VALUES (3, 'Michael Brown', 101);
INSERT INTO Employee VALUES (4, 'Sarah Davis', 103);
INSERT INTO Employee VALUES (5, 'James Wilson', 104);

INSERT INTO Department VALUES (101, 'HR');
INSERT INTO Department VALUES (102, 'Finance');
INSERT INTO Department VALUES (103, 'IT');
INSERT INTO Department VALUES (104, 'Marketing');

SELECT * FROM Employee;
SELECT * FROM Department;

-- -- #Retrieve employees working in a department that starts with 'M'.
SELECT Employee_Name 
FROM Employee e
WHERE EXISTS 
(SELECT Department_ID  FROM Department d WHERE d.Department_Name LIKE 'M%' AND e.Department_ID = d.Department_ID);

SELECT * FROM Department d WHERE d.Department_Name LIKE 'M%'; 

-- -- #Find all employees who are not part of the 'Marketing' department.
SELECT Employee_Name 
FROM Employee e
WHERE NOT EXISTS (SELECT 1 FROM Department d WHERE d.Department_Name = 'Marketing' AND d.Department_ID = e.Department_ID);

-- -- #Retrieve the names of employees who belong to departments with an "IT" department.
SELECT Employee_Name 
FROM Employee e
WHERE EXISTS (SELECT 1 FROM Department d WHERE d.Department_Name = 'IT' AND d.Department_ID = e.Department_ID);

-- -- #Check if there are any employees in the "HR" department.
SELECT 'HR Department Exists'
WHERE EXISTS (SELECT 1 FROM Employee WHERE Department_ID = 101);


-- -- #List all departments that don’t have any employees.
SELECT Department_Name 
FROM Department d
WHERE NOT EXISTS (SELECT 1 FROM Employee e WHERE e.Department_ID = d.Department_ID);


-- -- #Check if any department has a name containing the letter 'F'.
SELECT 'Departments with F exists'
WHERE EXISTS (SELECT 1 FROM Department WHERE Department_Name LIKE '%F%');
