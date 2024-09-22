CREATE DATABASE SP_EMPLOYEEDEMO;
USE SP_EMPLOYEEDEMO;

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Employee_Salary DECIMAL(10, 2),
    Department VARCHAR(50)
);

INSERT INTO Employee (Employee_ID, Employee_Name, Employee_Salary, Department)
VALUES 
(1, 'John Doe', 75000.00, 'IT'),
(2, 'Jane Smith', 85000.00, 'HR'),
(3, 'David Johnson', 95000.00, 'Finance'),
(4, 'Emily Davis', 70000.00, 'Marketing'),
(5, 'Michael Wilson', 90000.00, 'Operations');
SELECT * FROM Employee;
-- #Stored Procedure: Encapsulates SQL code for reuse and efficient execution.
-- #Basic syntax for creating a stored procedure in SQL
DELIMITER //
CREATE PROCEDURE procedure_name (IN parameter1 datatype, OUT parameter2 datatype, INOUT parameter3 datatype)
BEGIN
    -- SQL statements go here
END; //
DELIMITER ;

DELIMITER //: Changes the statement delimiter to // instead of the default ; 
CREATE PROCEDURE: Used to create the stored procedure.
procedure_name: The name of the stored procedure.
IN, OUT, INOUT: Specifies the mode of parameters:
IN: Input parameter.
OUT: Output parameter.
INOUT: Both input and output parameter.
datatype: The data type of the parameter (e.g., INT, VARCHAR).
BEGIN...END: The block where you write the SQL statements that the procedure will execute.

DELIMITER //
CREATE PROCEDURE GetEmployeeDetails(IN emp_id INT)
BEGIN
    SELECT * 
    FROM Employee 
    WHERE Employee_ID = emp_id;
END //
DELIMITER ;

-- #GetEmployeeDetails: The name of the stored procedure.
-- #IN emp_id INT: An input parameter emp_id of type INT, which will be used to filter the query.
-- #SELECT * FROM Employee WHERE Employee_ID = emp_id: Retrieves all details of the employee whose Employee_ID 
-- #matches the input parameter.

-- #Syntax to Call a Stored Procedure:
CALL procedure_name();

CALL GetEmployeeDetails(3);

-- #Syntax to Drop a Stored Procedure:
DROP PROCEDURE procedure_name;

DROP PROCEDURE IF EXISTS GetEmployeeDetails;



DELIMITER //
CREATE PROCEDURE GetEmployeeDetailsOUT(
    IN emp_id INT,
    OUT emp_name VARCHAR(100),
    OUT emp_salary DECIMAL(10, 2)
)
BEGIN
    SELECT Employee_Name, Employee_Salary 
    INTO emp_name, emp_salary
    FROM Employee 
    WHERE Employee_ID = emp_id;
END //
DELIMITER ;

CALL GetEmployeeDetailsOUT(4, @emp_name, @emp_salary);
SELECT @emp_name AS Employee_Name, @emp_salary AS Employee_Salary;

DELIMITER //
CREATE PROCEDURE UpdateSalary(
    IN emp_id INT,
    INOUT salary DECIMAL(10, 2),
    IN percentage DECIMAL(5, 2)
)
BEGIN
    SET salary = salary + (salary * (percentage / 100));
    UPDATE Employee 
    SET Employee_Salary = salary 
    WHERE Employee_ID = emp_id;
END //
DELIMITER ;

SET @current_salary = 75000.00; -- Initial salary value
CALL UpdateSalary(4, @current_salary, 10);
SELECT @current_salary AS Updated_Salary;

SHOW PROCEDURE STATUS WHERE Db = 'SP_EMPLOYEEDEMO';

-- #Stored Procedure: Encapsulates SQL code for reuse and efficient execution.
-- #Procedure Execution: Uses CALL to execute the procedure.
-- #Drop Procedure: Deletes the stored procedure from the database.