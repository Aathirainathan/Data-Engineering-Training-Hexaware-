-- Create the SISDB Database
CREATE DATABASE SISDB;

-- Use the SISDB database
USE SISDB;

-- Create the Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email NVARCHAR(100) UNIQUE,
    phone_number NVARCHAR(15)
);

-- Create the Teacher Table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE
);

-- Create the Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name NVARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0),
    teacher_id INT FOREIGN KEY REFERENCES Teacher(teacher_id)
);

-- Create the Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
    enrollment_date DATE
);

-- Create the Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    amount DECIMAL(10,2),
    payment_date DATE
);

-- Insert sample data into Students
INSERT INTO Students VALUES 
('Aadhithya', 'Srinivasan', '2001-04-10', 'aadhithya.srinivasan@example.com', '9876543210'),
('Aarushi', 'Narayan', '2000-08-22', 'aarushi.narayan@example.com', '9123456789'),
('Karthik', 'Venugopal', '1999-11-30', 'karthik.venugopal@example.com', '9988776655'),
('Priya', 'Balasubramaniam', '2002-02-14', 'priya.balasubramaniam@example.com', '9876541234'),
('Anirudh', 'Ramasamy', '1998-07-05', 'anirudh.ramasamy@example.com', '9123450987'),
('Divya', 'Rajendran', '2000-10-25', 'divya.rajendran@example.com', '9876098765'),
('Vignesh', 'Iyer', '2001-12-17', 'vignesh.iyer@example.com', '9988771234'),
('Lakshmi', 'Sankaran', '2002-01-09', 'lakshmi.sankaran@example.com', '9876545678'),
('Shyam', 'Kumar', '1999-03-15', 'shyam.kumar@example.com', '9123009876'),
('Sowmya', 'Narayanan', '2003-05-21', 'sowmya.narayanan@example.com', '9988775432');

-- Insert sample data into Teacher
INSERT INTO Teacher (first_name, last_name, email) VALUES
('Ram', 'Narayan', 'ram.narayan@example.com'),
('Janani', 'Sivakumar', 'janani.sivakumar@example.com'),
('Saravanan', 'Raja', 'saravanan.raja@example.com'),
('Muthu', 'Palanisamy', 'muthu.palanisamy@example.com'),
('Vijaya', 'Lakshmi', 'vijaya.lakshmi@example.com'),
('Kamal', 'Mani', 'kamal.mani@example.com'),
('Radhika', 'Sankar', 'radhika.sankar@example.com'),
('Ganesh', 'Perumal', 'ganesh.perumal@example.com'),
('Thiru', 'Arasan', 'thiru.arasan@example.com'),
('Madhavi', 'Natesan', 'madhavi.natesan@example.com');

-- Insert sample data into Courses
INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Tamil Literature', 3, 1),
('Mathematics', 4, 2),
('Physics', 4, 3),
('Chemistry', 3, 4),
('Computer Science', 5, 5),
('Biology', 4, 6),
('History', 2, 7),
('Geography', 2, 8),
('Political Science', 3, 9),
('Economics', 4, 10);

-- Insert sample data into Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(8, 4, '2024-01-15'),
(2, 3, '2024-02-12'),   
(3, 4, '2024-03-10'),   
(4, 5, '2024-04-08'),   
(5, 6, '2024-05-05'),   
(6, 7, '2024-06-20'),   
(7, 8, '2024-07-15'),   
(8, 9, '2024-08-22'),   
(9, 10, '2024-09-17'),  
(10, 11, '2024-10-05'); 

-- Insert sample data into Payments
INSERT INTO Payments VALUES
(1, 500.00, '2024-01-20'),
(2, 600.00, '2024-02-15'),
(3, 550.00, '2024-03-10'),
(4, 700.00, '2024-04-05'),
(5, 450.00, '2024-05-15'),
(6, 500.00, '2024-06-20'),
(7, 650.00, '2024-07-18'),
(8, 600.00, '2024-08-22'),
(9, 700.00, '2024-09-10'),
(10, 550.00, '2024-10-01');


-- Using an Equi Join 
SELECT s.first_name AS StudentName, c.course_name AS CourseName
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id=2 AND c.course_name = 'Chemistry';

-- Using a Self Join 
SELECT s1.first_name AS Student1, s2.first_name AS Student2
FROM Students s1
JOIN Enrollments e1 ON s1.student_id = e1.student_id
JOIN Enrollments e2 ON e1.course_id = e2.course_id
JOIN Students s2 ON e2.student_id = s2.student_id
WHERE s1.student_id < s2.student_id;

-- Joins with GROUP BY, HAVING, and GROUPING SETS
SELECT c.course_name, COUNT(e.student_id) AS EnrolledStudents, AVG(p.amount) AS AvgPayment
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 2
ORDER BY AVG(p.amount) DESC;

-- Querying Data by Using Subqueries - Get students who paid more than the average payment
SELECT s.first_name, s.last_name
FROM Students s
WHERE s.student_id IN (
    SELECT p.student_id
    FROM Payments p
    GROUP BY p.student_id
    HAVING SUM(p.amount) > (SELECT AVG(amount) FROM Payments)
);

-- Using the EXISTS keyword - Check if a student is enrolled in any course
SELECT s.first_name, s.last_name
FROM Students s
WHERE EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.student_id = s.student_id
);

-- Using the ANY keyword - Find students who paid more than any other student
SELECT s.first_name, s.last_name
FROM Students s
WHERE (SELECT SUM(p.amount) FROM Payments p WHERE p.student_id = s.student_id) > ANY (
    SELECT SUM(p.amount) FROM Payments p GROUP BY p.student_id
);

-- Using the ALL keyword - Get students who have paid more than all other students
SELECT s.first_name, s.last_name
FROM Students s
WHERE (SELECT SUM(p.amount) FROM Payments p WHERE p.student_id = s.student_id) > ALL (
    SELECT SUM(p.amount) FROM Payments p GROUP BY p.student_id
);

-- Using Nested Subqueries - Find courses with no students enrolled
SELECT c.course_name
FROM Courses c
WHERE c.course_id NOT IN (
    SELECT e.course_id
    FROM Enrollments e
    WHERE e.course_id = c.course_id
);

-- Using Correlated Subqueries - Find students who are enrolled in the same course as 'Aadhithya'
SELECT s.first_name, s.last_name
FROM Students s
WHERE EXISTS (
    SELECT 1
    FROM Enrollments e1
    WHERE e1.student_id = s.student_id
    AND e1.course_id IN (
        SELECT e2.course_id
        FROM Enrollments e2
        WHERE e2.student_id = (SELECT student_id FROM Students WHERE first_name = 'Aarushi')
    )
);

-- Using UNION - Get all unique student names and course names 
SELECT first_name AS Name FROM Students
UNION
SELECT course_name AS Name FROM Courses;

-- Using INTERSECT - Get students who are enrolled in both 'Physics' and 'Chemistry'
SELECT s.first_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Physics'
INTERSECT
SELECT s.first_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Chemistry';
s
-- Using EXCEPT - Get students who are enrolled in 'Physics' but not in 'Chemistry'
SELECT s.first_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Physics'
EXCEPT
SELECT s.first_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Chemistry';

-- Using MERGE 
MERGE INTO Payments p
USING Students s ON p.student_id = s.student_id
WHEN MATCHED AND p.amount > 500 THEN
    UPDATE SET p.payment_date = '2024-09-10';
