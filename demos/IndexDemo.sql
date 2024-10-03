CREATE DATABASE INDEX_DEMO;
USE INDEX_DEMO;

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Employee_Salary DECIMAL(10, 2),
    Department_ID INT
);

DELIMITER //
CREATE PROCEDURE Insert_Employee_Data()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Employee (Employee_ID, Employee_Name, Employee_Salary, Department_ID)
        VALUES (i, CONCAT('Employee', i), ROUND(RAND() * (100000 - 20000) + 20000, 2), FLOOR(RAND() * 10) + 1);
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL Insert_Employee_Data();

SELECT COUNT(*) FROM Employee;

-- Measure time taken to execute the query
SELECT * FROM Employee WHERE Department_ID = 50000;

CREATE INDEX idx_department_id ON Employee (Department_ID);

-- Measure time taken to execute the query with index
SELECT * FROM Employee WHERE Department_ID = 50000;

DROP INDEX idx_department_id 
ON Employee;

SHOW INDEX FROM table_name;
SHOW INDEX FROM Employee;

EXPLAIN SELECT * FROM Employee WHERE Department_ID = 50000;


SET @start_time = NOW();
SELECT * FROM Employee WHERE Department_ID = 5;
SET @end_time = NOW();
SELECT TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) AS ExecutionTime;


