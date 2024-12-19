

create database newdb;
use newdb;

CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    age INT,
    email VARCHAR(50),
    salary INT,
    department VARCHAR(30)
);

CREATE TABLE course (
    cid INT PRIMARY KEY,
    coursename VARCHAR(30),
    id INT
);

-- Inserting records into the employee table
INSERT INTO employee (id, name, age, email, salary, department) VALUES 
(103, 'radha', 30, 'radha@gmail.com', 45000, 'IT'),
(104, 'bob', 28, 'bob@gmail.com', 40000, 'sales'),
(105, 'jack', 28, 'jack@gmail.com', 40000, 'HR');

INSERT INTO course (cid, coursename, id) VALUES 
(1, 'Computer Science', 103),
(2, 'Sales Management', 104),
(3, 'Human Resources', 105),
(4, 'Data Analysis', 103),
(5, 'Marketing Basics', 104);

-- Performing SELECT queries on employee and course tables
SELECT * FROM employee;
SELECT * FROM course;

-- Performing Equi Join
SELECT * FROM employee e INNER JOIN course c ON e.id = c.id;

-- Performing Non-Equi Join
SELECT e.name, c.coursename, c.cid, e.salary 
FROM employee e, course c 
WHERE c.cid <= e.id;

-- Performing Self Join
SELECT e1.name, e1.department, e1.salary 
FROM employee e1, employee e2 
WHERE e1.salary = e2.salary AND e2.name = 'bob';

-- Performing subqueries with SELECT
SELECT * FROM employee WHERE id IN (SELECT id FROM employee WHERE salary >= 40000);
SELECT * FROM employee WHERE age IN (SELECT age FROM employee WHERE age = 30);


-- Creating temp_data table
CREATE TABLE temp_data (
    id INT PRIMARY KEY,
    name VARCHAR(10),
    age INT,
    email VARCHAR(30),
    salary INT,
    department VARCHAR(30)
);

-- Inserting data into temp_data using subquery
INSERT INTO temp_data 
SELECT * FROM employee WHERE id IN (SELECT id FROM employee);


-- Displaying data from temp_data
SELECT * FROM temp_data;

-- Deleting data with subqueries
DELETE FROM temp_data WHERE name IN (SELECT name FROM employee WHERE name = 'krish');
SELECT * FROM temp_data;

-- Using EXISTS operator
SELECT * FROM employee WHERE EXISTS (SELECT name FROM employee WHERE name = 'kishore');
SELECT * FROM employee;

-- Using EXISTS with course and employee tables
SELECT cid, coursename FROM course 
WHERE EXISTS (SELECT id, age FROM employee WHERE course.id = employee.id AND age >= 30);

-- Using ANY operator
SELECT name, salary FROM employee 
WHERE id = ANY (SELECT id FROM course WHERE course.id = employee.id AND employee.salary >= 40000);

-- Using ALL operator
SELECT name, salary FROM employee 
WHERE id = ALL (SELECT id FROM course WHERE age = 70);

-- Performing correlated subqueries
SELECT id, name, salary, department 
FROM employee e 
WHERE salary = (SELECT AVG(salary) FROM employee WHERE department = e.department);

SELECT id, name, salary, department 
FROM employee e 
WHERE salary < (SELECT AVG(salary) FROM employee WHERE department = e.department);



-- Creating student1 and studentdata2 tables
CREATE TABLE student1 (
    id INT,
    name VARCHAR(10),
    age INT,
    grade CHAR(2)
);

-- Inserting values into student1
INSERT INTO student1 (id, name, age, grade) VALUES 
(1, 'appu', 20, 'A+'),
(2, 'Ram', 21, 'A'),
(3, 'Radha', 21, 'B'),
(4, 'krish', 19, 'B+'),
(5, 'bob', 21, 'C');

-- Renaming student1 to studentdata1
EXEC sp_rename 'student1', 'studentdata1';

-- Creating studentdata2 table
CREATE TABLE studentdata2 (
    id INT,
    name VARCHAR(10),
    age INT,
    grade CHAR(2)
);

-- Inserting values into studentdata2
INSERT INTO studentdata2 (id, name, age, grade) VALUES 
(1, 'bob', 20, 'A+'),
(2, 'Ram', 21, 'A'),
(3, 'kishore', 20, 'A+'),
(4, 'radha', 20, 'A+'),
(5, 'krish', 20, 'A+');

-- Performing updates on studentdata2
UPDATE studentdata2 SET id = 3 WHERE name = 'kishore';
UPDATE studentdata2 SET id = 4 WHERE name = 'krish';
UPDATE studentdata2 SET id = 5 WHERE name = 'bob';

-- Performing UNION, INTERSECT, UNION ALL, and EXCEPT set operations
-- UNION operation
SELECT * FROM studentdata1 UNION SELECT * FROM studentdata2;

-- INTERSECT operation
SELECT * FROM studentdata1 INTERSECT SELECT * FROM studentdata2;

-- UNION ALL operation (Correcting typo)
SELECT * FROM studentdata1 UNION ALL SELECT * FROM studentdata2;

-- EXCEPT operation
SELECT * FROM studentdata1 EXCEPT SELECT * FROM studentdata2;
