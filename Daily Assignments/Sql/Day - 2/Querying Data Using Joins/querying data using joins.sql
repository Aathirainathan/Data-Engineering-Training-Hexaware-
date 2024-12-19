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

-- INNER JOIN Example: List all students with their course names
SELECT s.first_name AS StudentName, c.course_name AS CourseName
FROM Students s INNER JOIN Enrollments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;

-- LEFT JOIN Example: Show all students and the courses they are enrolled in (if any)
SELECT s.first_name AS StudentName, c.course_name AS CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_id = c.course_id;

-- RIGHT JOIN Example: List all courses and their enrolled students (if any)
SELECT c.course_name AS CourseName, s.first_name AS StudentName
FROM Courses c
RIGHT JOIN Enrollments e ON c.course_id = e.course_id
RIGHT JOIN Students s ON e.student_id = s.student_id;

-- FULL OUTER JOIN Example: List all students and all courses, showing nulls where there is no match
SELECT s.first_name AS StudentName, c.course_name AS CourseName
FROM Students s
FULL OUTER JOIN Enrollments e ON s.student_id = e.student_id
FULL OUTER JOIN Courses c ON e.course_id = c.course_id;

-- CROSS JOIN Example: Get a cartesian product of students and courses
SELECT s.first_name AS StudentName, c.course_name AS CourseName
FROM Students s
CROSS JOIN Courses c;

-- Using GROUP BY with Aggregation: Number of students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS EnrolledStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY EnrolledStudents DESC;

-- Aggregation: Total payments by each student
SELECT s.first_name AS StudentName, SUM(p.amount) AS TotalPayment
FROM Students s
INNER JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.first_name
ORDER BY TotalPayment DESC;

-- Using HAVING to filter groups: Get courses with more than 1 student enrolled
SELECT c.course_name, COUNT(e.student_id) AS EnrolledStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 1
ORDER BY EnrolledStudents DESC;

-- Using INNER JOIN with Aggregation: Total payments for each course (aggregating by course)
SELECT c.course_name, SUM(p.amount) AS TotalPayments
FROM Courses c
INNER JOIN Enrollments e ON c.course_id = e.course_id
INNER JOIN Payments p ON e.student_id = p.student_id
GROUP BY c.course_name
ORDER BY TotalPayments DESC;

