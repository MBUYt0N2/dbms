CREATE DATABASE DQLDEMO;
USE DQLDEMO;

CREATE TABLE EMPLOYEE (
    Ename VARCHAR(50),
    Minit CHAR(1),
    Lname VARCHAR(50),
    SSN CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Gender CHAR(1),
    Salary DECIMAL(10, 2),
    Super_SSN CHAR(9),
    Dno INT
);

INSERT INTO EMPLOYEE VALUES ('John', 'A', 'Doe', '123456789', '1985-07-25', '123 Elm St, Houston, TX', 'M', 60000.00, NULL, 1);
INSERT INTO EMPLOYEE VALUES ('Jane', 'B', 'Smith', '987654321', '1990-11-12', '456 Oak St, Dallas, TX', 'F', 80000.00, '123456789', 2);
INSERT INTO EMPLOYEE VALUES ('Michael', 'C', 'Johnson', '456789123', '1975-05-05', '789 Pine St, Stafford, TX', 'M', 75000.00, '987654321', 3);
INSERT INTO EMPLOYEE VALUES ('Emily', 'D', 'Davis', '159357456', '1982-09-18', '234 Maple St, Houston, TX', 'F', 90000.00, '456789123', 4);
INSERT INTO EMPLOYEE VALUES ('David', 'E', 'Wilson', '951753852', '1979-04-10', '567 Birch St, Houston, TX', 'M', 65000.00, '159357456', 5);
INSERT INTO EMPLOYEE VALUES ('Sophia', 'F', 'Garcia', '753951456', '1965-12-28', '345 Cedar St, Dallas, TX', 'F', 85000.00, '951753852', 1);
INSERT INTO EMPLOYEE VALUES ('Ethan', 'G', 'Martinez', '258741369', '1968-03-15', '678 Spruce St, Houston, TX', 'M', 55000.00, '753951456', 2);
INSERT INTO EMPLOYEE VALUES ('Olivia', 'H', 'Lopez', '369852147', '1970-07-29', '910 Willow St, Houston, TX', 'F', 72000.00, '258741369', 3);
INSERT INTO EMPLOYEE VALUES ('Daniel', 'I', 'Lee', '147852369', '1963-10-10', '112 Cypress St, Stafford, TX', 'M', 68000.00, '369852147', 4);
INSERT INTO EMPLOYEE VALUES ('Ava', 'J', 'Brown', '321654987', '1987-01-20', '134 Elm St, Houston, TX', 'F', 77000.00, '147852369', 5);

SELECT * 
FROM EMPLOYEE;

#1. Find the Names of All Employees
SELECT Ename, Minit, Lname 
FROM EMPLOYEE;

#2. Retrieve the Name and Address of All Employees
SELECT Ename, Lname, Address 
FROM EMPLOYEE;

#3. Retrieve the Distinct Name and Address of All Employees
SELECT DISTINCT Ename, Lname, Address 
FROM EMPLOYEE;
#The DISTINCT keyword ensures that only unique combinations of name and address are displayed.

#4. Find All Employees in Department No 5
SELECT Ename, Lname 
FROM EMPLOYEE 
WHERE Dno = 5;

#5. For Every Project Located in ‘Stafford’, List the Project Info and Manager Details
SELECT Pnumber, Dno, Lname, Address, Bdate
FROM PROJECT
JOIN DEPARTMENT ON PROJECT.Dno = DEPARTMENT.Dnumber
JOIN EMPLOYEE ON DEPARTMENT.Mgr_SSN = EMPLOYEE.SSN
WHERE Plocation = 'Stafford';

#6. List the Number of Male and Female Employees
SELECT Gender, COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY Gender;

#7. List the Department Number Along With the Number of Employees Where the Department Has More Than or 
#Equal to 2 Employees.
SELECT Dno, COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY Dno
HAVING COUNT(*) >= 2;

#8.  List the Employees Based on Descending Order of Their Salary
SELECT Ename, Lname, Salary 
FROM EMPLOYEE
ORDER BY Salary DESC;

#9. List the Employees Based on Ascending Order of Their Salary
SELECT Ename, Lname, Salary 
FROM EMPLOYEE
ORDER BY Salary ASC;


#10. Find the Annual Salary of Employees.
SELECT Ename, Lname, Salary * 12 AS Annual_Salary
FROM EMPLOYEE;


#11. Retrieve All Employees Whose Address is in Houston, Texas
SELECT Ename, Lname, Address 
FROM EMPLOYEE 
WHERE Address LIKE '%Houston, TX%';


#12. Find All Employees Who Were Born During the 1960s
SELECT Ename, Lname, Bdate 
FROM EMPLOYEE 
WHERE Bdate BETWEEN '1960-01-01' AND '1969-12-31';
