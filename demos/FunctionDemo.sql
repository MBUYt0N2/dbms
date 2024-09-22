CREATE DATABASE FUNCTIONDEMO;
USE FUNCTIONDEMO;

#Syntax to Create a Function:
CREATE FUNCTION function_name (parameter1 datatype, parameter2 datatype, ...)
RETURNS return_datatype
DETERMINISTIC
BEGIN
    DECLARE variable datatype;
    
    -- Function logic here
    
    RETURN result;
END;

#function_name: Name of the function.
#parameter1, parameter2: Input parameters.
#return_datatype: The type of value the function will return (e.g., INT, VARCHAR, etc.).
#DETERMINISTIC: Specifies whether the function will return the same value when given the same input.

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Employee_Salary DECIMAL(10, 2),
    Department_ID INT
);

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100)
);

INSERT INTO Employee (Employee_ID, Employee_Name, Employee_Salary, Department_ID) 
VALUES (1, 'John Doe', 55000.00, 101),
       (2, 'Jane Smith', 75000.00, 102),
       (3, 'Robert Brown', 60000.00, 101);

INSERT INTO Department (Department_ID, Department_Name)
VALUES (101, 'HR'),
       (102, 'Finance'),
       (103, 'Marketing');

#Function to Get Department Name
#Create a function to retrieve the department name for a given department ID.
DELIMITER //       
CREATE FUNCTION Get_Department_Name (dept_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE dept_name VARCHAR(100);
    
    -- Fetch the department name from the Department table
    SELECT Department_Name INTO dept_name FROM Department WHERE Department_ID = dept_id;
    
    RETURN dept_name;
END;//
DELIMITER ;

SELECT Employee_Name, Get_Department_Name(Department_ID) AS Department
FROM Employee;


#To Drop a Function:
DROP FUNCTION IF EXISTS function_name;

DROP FUNCTION IF EXISTS Get_Department_Name;


DROP FUNCTION IF EXISTS Calculate_Bonus;

SHOW FUNCTION STATUS WHERE Db = 'your_database_name';
SHOW FUNCTION STATUS WHERE Db = 'FUNCTIONDEMO';



