CREATE DATABASE ROLE1;
USE ROLE1;

CREATE ROLE ROLE_SELECT;
GRANT SELECT ON ROLE1.* to ROLE_SELECT;
GRANT SHOW DATABASES ON *.* TO ROLE_SELECT;
CREATE USER 'tb'@'localhost' IDENTIFIED by 'Mypassword';
SHOW GRANTS FOR 'tb'@'localhost';
GRANT ROLE_SELECT TO 'tb'@'localhost';

SHOW GRANTS FOR 'tb'@'localhost';