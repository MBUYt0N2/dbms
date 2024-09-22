CREATE DATABASE IN_EXIST_WITHDEMO;
USE IN_EXIST_WITHDEMO;
#Employee Table:
CREATE TABLE Employee (
    EID INT PRIMARY KEY,
    EName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employee (EID, EName, DepartmentID, Salary) VALUES
(1, 'John', 1, 45000),
(2, 'Jane', 2, 55000),
(3, 'Bob', 1, 60000),
(4, 'Alice', 3, 70000),
(5, 'Charlie', 2, 35000);

#Department Table:
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DName VARCHAR(100)
);

INSERT INTO Department (DepartmentID, DName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

#Project Table:
CREATE TABLE Project (
    PID INT PRIMARY KEY,
    PName VARCHAR(100),
    DepartmentID INT
);

INSERT INTO Project (PID, PName, DepartmentID) VALUES
(101, 'Proj_A', 1),
(102, 'Proj_B', 2),
(103, 'Proj_C', 3);

#Works_On Table:
CREATE TABLE Works_On (
    EID INT,
    PID INT,
    Hours_Worked INT
);

INSERT INTO Works_On (EID, PID, Hours_Worked) VALUES
(1, 101, 10),
(2, 102, 15),
(3, 103, 20),
(4, 101, 25),
(5, 102, 30);

SELECT * FROM Employee; 
SELECT * FROM Department; 
SELECT * FROM Project; 
SELECT * FROM Works_On; 
#IN Clause
#The IN clause is used to specify multiple possible values for a column in a WHERE clause. 
#It's useful for filtering data that matches any value in a list or a subquery.
#Syntax:
SELECT columns
FROM table
WHERE column IN (value1, value2, ...);

#1: Find employees who work in department 1 or department 2.
SELECT EName
FROM Employee
WHERE DepartmentID IN (1, 2);

#2: Retrieve employees who are working on project 101, 102, or 103.
SELECT EName
FROM Employee E
WHERE E.EID IN (
    SELECT EID
    FROM Works_On
    WHERE PID IN (101, 102, 103)
);

#3: Get projects handled by department 2 or 3.
SELECT PName
FROM Project
WHERE DepartmentID IN (2, 3);

#NOT IN Clause
#The NOT IN clause is used to exclude rows with values specified in the NOT IN list or subquery.
SELECT columns
FROM table
WHERE column NOT IN (value1, value2, ...);

#1: Find employees not working in department 3 or 4.
SELECT EName
FROM Employee
WHERE DepartmentID NOT IN (3, 4);

#2: Retrieve projects not handled by department 1.
SELECT PName
FROM Project
WHERE DepartmentID NOT IN (1);

#3: Get employees who are not working on project 101 or 102.
SELECT EName
FROM Employee
WHERE EID NOT IN (
    SELECT EID
    FROM Works_On
    WHERE PID IN (101, 102)
);


#WITH Clause
#Definition:
#The WITH clause allows you to define a common table expression (CTE), which can be referenced within the main query. 
#This helps to make complex queries more readable.
#Syntax:
WITH CTE AS (subquery)
SELECT columns
FROM CTE;

#1: Find employees in department 2 with more than 5 hours worked.
WITH Dept_Employees AS (
    SELECT EID, EName
    FROM Employee
    WHERE DepartmentID = 2
)
SELECT EName
FROM Dept_Employees D
JOIN Works_On W ON D.EID = W.EID
WHERE W.Hours_Worked > 5;


#2: Retrieve employees with high salary (>50000) using CTE.
WITH High_Salary AS (
    SELECT EID, EName, Salary
    FROM Employee
    WHERE Salary > 50000
)
SELECT EName, Salary
FROM High_Salary;


#3: Retrieve projects handled by department 1, using CTE for filtering.
WITH Dept_Projects AS (
    SELECT PName, DepartmentID
    FROM Project
    WHERE DepartmentID = 1
)
SELECT PName
FROM Dept_Projects;

#EXISTS Clause
#Definition:
#The EXISTS clause is used to test for the existence of any record in a subquery. 
#It returns TRUE if the subquery returns one or more records.
#Syntax:
SELECT columns
FROM table
WHERE EXISTS (subquery);

#1: Find employees who work on at least one project.
SELECT EName
FROM Employee E
WHERE EXISTS (
    SELECT *
    FROM Works_On W
    WHERE E.EID = W.EID
);


#2: Find departments that have employees.
SELECT DName
FROM Department D
WHERE EXISTS (
    SELECT *
    FROM Employee E
    WHERE E.DepartmentID = D.DepartmentID
);

#3: Retrieve projects that have more than 5 employees working.
SELECT PName
FROM Project P
WHERE EXISTS (
    SELECT 1
    FROM Works_On W
    WHERE W.PID = P.PID
    GROUP BY W.PID
    HAVING COUNT(W.EID) > 5
);

#The EXISTS clause evaluates whether the subquery returns any rows. 
#If the subquery returns at least one row, EXISTS returns TRUE; otherwise, FALSE.


#NOT EXISTS Clause
#The NOT EXISTS clause returns TRUE if the subquery does not return any records.
SELECT columns
FROM table
WHERE NOT EXISTS (subquery);

#1: Find employees who are not working on any project.
SELECT EName
FROM Employee E
WHERE NOT EXISTS (
    SELECT *
    FROM Works_On W
    WHERE E.EID = W.EID
);

#2: Retrieve departments that have no employees.
SELECT DName
FROM Department D
WHERE NOT EXISTS (
    SELECT *
    FROM Employee E
    WHERE E.DepartmentID = D.DepartmentID
);


#3: Find projects with no assigned employees.
SELECT PName
FROM Project P
WHERE NOT EXISTS (
    SELECT *
    FROM Works_On W
    WHERE W.PID = P.PID
);

