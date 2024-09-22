# 1. Definition:
#Query Optimization in SQL is the process of enhancing the performance of a query by choosing the most efficient 
way to execute it. The SQL engine uses an optimizer to decide the best strategy (execution plan) for retrieving 
the requested data. 
Query optimization aims to reduce the response time, memory usage, and CPU load when accessing or modifying the 
database.

#2. Why is Query Optimization Important?
- Faster Query Execution: Optimized queries run faster, saving time and resources.
- Efficient Resource Usage: Helps minimize CPU, memory, and disk usage.
- Handles Large Data Efficiently: Optimized queries perform well even with large datasets, improving scalability.
  
# 3. Query Optimization Techniques:
1. Indexes: Use indexes on columns that are frequently queried to improve search performance.
2. Avoid Select *: Instead of retrieving all columns using `SELECT *`, specify only the required columns.
3. Joins vs Subqueries: Use JOINS instead of subqueries where applicable for better performance.
4. Use of EXISTS vs IN: The `EXISTS` clause is often faster than `IN`, especially with large datasets.
5. Limit the Rows: Use `LIMIT` or `TOP` to restrict the number of rows retrieved when only a subset is required.
6. Avoid Functions on Indexed Columns: Performing operations like `UPPER()` or `LOWER()` on indexed columns 
can prevent the index from being used.

# 4. Example of Basic Query Optimization:

#Inefficient Query:

SELECT * FROM Employee WHERE UPPER(Name) = 'JOHN';

#- In this query, the function `UPPER(Name)` prevents the use of an index on `Name`, leading to slower execution.

#Optimized Query:

SELECT * FROM Employee WHERE Name = 'John';

#- Here, no function is used on the column, allowing the index to be used for faster retrieval.

# 5. Use of Indexes in Query Optimization:
#Indexes play a vital role in speeding up SELECT queries. 
#An index is like a table of contents for the database, 
#allowing it to quickly locate rows based on column values.


#Example of Creating an Index:

CREATE INDEX idx_employee_name ON Employee(Name);

#With this index, queries involving `Name` will execute faster:

SELECT * FROM Employee WHERE Name = 'John';

# Subquery Optimization in SQL

# 1. Definition:
#A Subquery is a query nested inside another query. While subqueries can simplify complex queries, 
they can also lead to performance issues if not written carefully. 
Subquery Optimization focuses on improving the performance of queries that contain subqueries by transforming or restructuring them.


# 3. General Tips for Subquery Optimization:
#1. Replace Subqueries with JOINS: In many cases, using a JOIN is more efficient than a subquery.
#2. Use EXISTS instead of IN: EXISTS often performs better than IN, especially when dealing 
#with large datasets.
#3. Avoid Nested Subqueries: Try to limit the nesting of subqueries to reduce complexity and 
#improve performance.

# 4. Example of Subquery Optimization:

#Subquery Example (Less Efficient):

SELECT Employee_Name
FROM Employee
WHERE Employee_ID IN (SELECT Employee_ID FROM Works_On WHERE Project_ID = 3);

#- This query uses a subquery, which can be slow with large tables.

#Optimized Query (Using JOIN):

SELECT e.Employee_Name
FROM Employee e
JOIN Works_On w ON e.Employee_ID = w.Employee_ID
WHERE w.Project_ID = 3;

#- Using a JOIN instead of a subquery often leads to better performance.

# 5. EXISTS vs IN:

#Using IN (Less Efficient for Large Datasets):

SELECT Employee_Name
FROM Employee
WHERE Employee_ID IN (SELECT Employee_ID FROM Works_On);


#Using EXISTS (More Efficient for Large Datasets):

SELECT Employee_Name
FROM Employee e
WHERE EXISTS (SELECT 1 FROM Works_On w WHERE w.Employee_ID = e.Employee_ID);

#- EXISTS will stop scanning once a match is found, leading to better performance than `IN`.


# Example Scenarios for Query Optimization:

# Table Creation Commands:

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Works_On (
    Employee_ID INT,
    Project_ID INT,
    Hours_Worked INT
);


# Insertion Commands:

INSERT INTO Employee (Employee_ID, Employee_Name, Department_ID, Salary) VALUES
(1, 'Alice', 1, 55000),
(2, 'Bob', 2, 65000),
(3, 'Charlie', 1, 48000),
(4, 'David', 3, 72000);

INSERT INTO Works_On (Employee_ID, Project_ID, Hours_Worked) VALUES
(1, 101, 20),
(2, 102, 35),
(3, 103, 40),
(4, 101, 25);


# Optimized Queries:

#Query 1: Using Indexes

CREATE INDEX idx_employee_department ON Employee(Department_ID);
SELECT * FROM Employee WHERE Department_ID = 1;


#Query 2: Using JOIN instead of Subquery

SELECT e.Employee_Name
FROM Employee e
JOIN Works_On w ON e.Employee_ID = w.Employee_ID
WHERE w.Project_ID = 101;


# Query Optimization helps in reducing the execution time and resource consumption of SQL queries.
# Indexes are a key element in speeding up searches and lookups.
# Subquery Optimization involves restructuring queries for better performance, 
often by replacing subqueries with JOINs or using EXISTS instead of IN.
