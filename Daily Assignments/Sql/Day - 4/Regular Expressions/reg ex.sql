use mydb;
CREATE TABLE student_tbl (
    name NVARCHAR(50)
);

INSERT INTO student_tbl (name) VALUES 
('Sam'),
('Samarth'),
('Norton'),
('Merton'),
('Abel'),
('Baer'),
('Lorentz'),
('Rajs'),
('Tobias'),
('Sewall'),
('Nerton');

CREATE TABLE movies_tbl (
    title NVARCHAR(100)
);

INSERT INTO movies_tbl (title) VALUES 
('Comedy'),
('Romantic Comedy'),
('Action'),
('Black'),
('Forgetting Sarah Marshal'),
('Stranger Things'),
('Avengers');

SELECT name FROM student_tbl WHERE name LIKE 'sa%';

SELECT name FROM student_tbl WHERE name LIKE '%on';

SELECT title FROM movies_tbl WHERE title LIKE '%com%';

SELECT name FROM student_tbl WHERE name LIKE '%be%' OR name LIKE '%ae%';

SELECT name FROM student_tbl WHERE name LIKE '%j%' OR name LIKE '%z%';

SELECT name FROM student_tbl WHERE name LIKE '[b-g]%a';

SELECT name FROM student_tbl WHERE name NOT LIKE '%j%' AND name NOT LIKE '%z%';

SELECT title FROM movies_tbl WHERE title LIKE '%ack';

SELECT title FROM movies_tbl WHERE title LIKE 'for%';

SELECT title FROM movies_tbl WHERE title NOT LIKE '%[^A-Za-z ]%';



SELECT name FROM student_tbl WHERE name LIKE 'n%' OR name LIKE 's%';
