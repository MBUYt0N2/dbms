CREATE DATABASE ROLEDEMO;
USE ROLEDEMO;

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Employee_Salary DECIMAL(10, 2),
    Department VARCHAR(100)
);

INSERT INTO Employee (Employee_ID, Employee_Name, Employee_Salary, Department)
VALUES (1, 'John Doe', 60000.00, 'Sales'),
       (2, 'Jane Smith', 75000.00, 'Marketing'),
       (3, 'Sam Johnson', 55000.00, 'HR'),
       (4, 'Chris Evans', 68000.00, 'IT'),
       (5, 'Tom Hanks', 72000.00, 'Finance');
       
SELECT * FROM Employee;       

-- #Syntax to Create Role:
CREATE ROLE role_name;

CREATE ROLE manager;
CREATE ROLE hr_rep;

-- #Syntax to Grant Privileges to Roles:
GRANT privilege_name ON table_name TO role_name;

-- #Granting the manager role the ability to view and update employee details:
GRANT SELECT, UPDATE ON Employee TO manager;

-- #Granting the hr_rep role the ability to insert new employee records:
GRANT INSERT ON Employee TO hr_rep;

-- #Syntax to Assign Role to Users:
GRANT role_name TO 'user_name';


-- #Assigning the manager role to a user named john_doe:
GRANT manager TO 'John Doe';

-- #Assigning the hr_rep role to a user named mary_smith:
GRANT hr_rep TO 'mary_smith';

-- #Syntax to Revoke Privileges:
REVOKE privilege_name ON table_name FROM role_name;

-- #Revoking the UPDATE privilege from the manager role on the Employee table:
REVOKE UPDATE ON Employee FROM manager;

-- #Revoking a role from a user:
REVOKE manager FROM 'john_doe';

-- #Syntax to Drop a Role:
DROP ROLE role_name;

-- #If you want to drop the manager role, the command would be:
DROP ROLE manager;

-- #To drop the hr_rep role:
DROP ROLE hr_rep;

-- #Summary of Commands:
-- #1. Create a Role:
CREATE ROLE role_name;

-- #2. Grant Privileges to a Role:
GRANT privilege_name ON table_name TO role_name;

-- #3. Assign Role to a User:
GRANT role_name TO 'user_name';

-- #4. Check Grants for a User:
SHOW GRANTS FOR 'user_name';

-- #5. Revoke Privileges from a Role:
REVOKE privilege_name ON table_name FROM role_name;

-- #6. Revoke a Role from a User:
REVOKE role_name FROM 'user_name';


SHOW GRANTS for root@localhost;
show grants for root@localhost using Manager;
