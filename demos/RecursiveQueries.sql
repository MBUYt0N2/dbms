CREATE DATABASE CTEDEMO;
USE CTEDEMO;

#A Recursive Query in SQL is a query that refers to itself. 
#It is used to handle hierarchical data or situations where a set of rows is defined in terms of other rows 
#in the same table, such as in organizational structures. 
#Recursive queries are typically written using Common Table Expressions (CTEs) with the WITH RECURSIVE clause.

WITH RECURSIVE cte_name AS (
    -- Anchor member: base case query
    SELECT column1, column2, ...
    FROM table
    WHERE condition
  
    UNION ALL

    -- Recursive member: recursive query
    SELECT column1, column2, ...
    FROM table
    JOIN cte_name ON condition
)
SELECT * FROM cte_name;

#WITH RECURSIVE: This keyword starts the recursive CTE.
#cte_name: The name of the Common Table Expression (CTE).
#The Anchor member is the initial query that fetches the starting set of data.
#UNION ALL: Combines the anchor query result with the recursive result.
#The Recursive member retrieves data recursively by referring back to the CTE itself.
#SELECT * FROM cte_name gives the full result after recursion completes.


CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Manager_ID INT
);

INSERT INTO Employee (Employee_ID, Employee_Name, Manager_ID) VALUES
(1, 'Alice', NULL),   -- Top-level manager (CEO)
(2, 'Bob', 1),        -- Bob reports to Alice
(3, 'Charlie', 1),    -- Charlie reports to Alice
(4, 'David', 2),      -- David reports to Bob
(5, 'Eva', 2);        -- Eva reports to Bob

SELECT * FROM Employee;

#Example 1: Retrieve Employee Hierarchy
#This query retrieves all employees and their managers recursively.

WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the top-level employees (those without a manager)
    SELECT Employee_ID, Employee_Name, Manager_ID
    FROM Employee
    WHERE Manager_ID IS NULL

    UNION ALL

    -- Recursive member: Select employees who report to those in the previous level
    SELECT e.Employee_ID, e.Employee_Name, e.Manager_ID
    FROM Employee e
    JOIN EmployeeHierarchy eh ON e.Manager_ID = eh.Employee_ID
)
SELECT * FROM EmployeeHierarchy;


#Example 2: Find All Employees Under a Specific Manager
#This query finds all employees under a specific manager (e.g., Alice).
WITH RECURSIVE EmployeeUnderManager AS (
    -- Anchor member: Select Alice (Employee_ID = 1)
    SELECT Employee_ID, Employee_Name, Manager_ID
    FROM Employee
    WHERE Employee_ID = 1

    UNION ALL

    -- Recursive member: Select employees reporting to Alice's subordinates
    SELECT e.Employee_ID, e.Employee_Name, e.Manager_ID
    FROM Employee e
    JOIN EmployeeUnderManager eum ON e.Manager_ID = eum.Employee_ID
)
SELECT * FROM EmployeeUnderManager;


SELECT Employee_ID, Employee_Name, Manager_ID
FROM Employee
WHERE Employee_ID = 1;


#Scenario: Student and Mentor Hierarchy
#Consider a scenario where you have students, and each student may have a mentor. 
#A mentor is also a student, and there can be multiple levels of mentorship. 
#You want to find all students and their mentors starting from a specific student.

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Mentor_ID INT
);

INSERT INTO Student (Student_ID, Student_Name, Mentor_ID) VALUES 
(1, 'Alice', NULL),    -- Alice has no mentor
(2, 'Bob', 1),         -- Bob is mentored by Alice
(3, 'Charlie', 1),     -- Charlie is mentored by Alice
(4, 'David', 2),       -- David is mentored by Bob
(5, 'Eva', 3);         -- Eva is mentored by Charlie

#Query 1: Retrieve all students under a specific student (e.g., Alice)
#This query retrieves all students directly or indirectly mentored by Alice, using recursive SQL.

WITH RECURSIVE StudentHierarchy AS (
    -- Anchor member: Select Alice
    SELECT Student_ID, Student_Name, Mentor_ID
    FROM Student
    WHERE Student_ID = 1

    UNION ALL

    -- Recursive member: Find students mentored by Alice's mentees
    SELECT s.Student_ID, s.Student_Name, s.Mentor_ID
    FROM Student s
    JOIN StudentHierarchy sh ON s.Mentor_ID = sh.Student_ID
)
SELECT * FROM StudentHierarchy;

#Query 2: Retrieve the mentor chain for a specific student (e.g., David)
#This query retrieves the mentor hierarchy for David, showing who mentors whom, all the way up the chain.

WITH RECURSIVE MentorChain AS (
    -- Anchor member: Select David
    SELECT Student_ID, Student_Name, Mentor_ID
    FROM Student
    WHERE Student_ID = 4

    UNION ALL

    -- Recursive member: Find mentors of David's mentors
    SELECT s.Student_ID, s.Student_Name, s.Mentor_ID
    FROM Student s
    JOIN MentorChain mc ON s.Student_ID = mc.Mentor_ID
)
SELECT * FROM MentorChain;
