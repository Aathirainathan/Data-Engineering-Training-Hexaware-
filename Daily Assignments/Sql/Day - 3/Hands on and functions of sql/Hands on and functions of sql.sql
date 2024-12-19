
create database mydb;
use mydb;
create table employee(
id int primary key,
name varchar(20),
age int,
email varchar(20)
);/*creatig table*/
select * from employee;
sp_help employee;/*displaying the structure of the table*/
insert into employee(id,name,age,email) values(101,'alex',30,'alex@gmail.com');
insert into employee(id,name,age,email) values(102,'bob',20,'bob@gmail.com');
insert into employee(id,name,age,email) values(103,'sunny',40,'sunny@gmail.com');
insert into employee(id,name,age,email) values(104,'stella',35,'stella@gmail.com');
insert into employee(id,name,age,email) values(105,'nani',40,'nani@gmail.com');/*inserting values into it*/
select *from employee;/*displaying values into it*/
insert into employee(id,name,age,email) values(106,'stella',35,'stella@gmail.com');
insert into employee(id,name,age,email) values(107,'nani',35,'nani@gmail.com');
select distinct name from employee;/*using distinct constraint*/
alter table employee add  salary int;/*add one more column into table*/
select *from employee;
update employee set salary=20000 where name='alex';
update employee set salary=30000 where name='bob';
update employee set salary=35000 where name='sunny';
update employee set salary=35000 where name='stella';
update employee set salary=50000 where name='nani';/*adding values into it*/
alter table employee add  department varchar(20);
update employee set department='sales' where name='stella';
update employee set department='HR' where name='nani';
update employee set department='IT' where name='alex';
update employee set department='salesforce' where name='bob';
update employee set department='HR' where name='sunny';/*adding values into table*/
select avg(salary) from employee 
where department='HR';/*using avg function */
select count(id) from employee 
where name='stella';/*using count function*/
select max(salary),department from employee
group by department
having department='HR';/*using group by,having with aggregate function*/
select count(name) as count_employee,salary from employee
group by salary
having salary=50000;/*using having and group by clause*/
select *from employee;
select max(salary) as min_salary,department
from employee
group by department
having department='IT';
select *from employee;
begin tran;
delete from employee where age=20;
commit;/*commit the transaction*/
begin tran;
delete from employee where age=40;
rollback;/*rollback the transaction*/
insert into employee(id,name,age,email,salary,department) values(101,'aparna',20,'aparna@gmail.com',30000,'sales');
insert into employee(id,name,age,email,salary,department) values(102,'stella',20,'stella@gmail.com',40000,'HR');
select *from employee;
begin tran;
delete from employee where age=20;
rollback;
begin tran;
delete from employee where age=40;
rollback;
insert into employee(id,name,age,email,salary,department) values(104,'aparna',20,'aparna@gmail.com',30000,'sales');
insert into employee(id,name,age,email,salary,department) values(105,'stella',20,'stella@gmail.com',40000,'HR');
insert into employee(id,name,age,email,salary,department) values(106,'kishore',35,'kishore@gmail.com',35000,'IT');
insert into employee(id,name,age,email,salary,department) values(107,'lucky',28,'lucky@gmail.com',60000,'salesforce');
insert into employee(id,name,age,email,salary,department) values(108,'nimmi',30,'nimmi@gmail.com',30000,'IT');
insert into employee(id,name,age,email,salary,department) values(109,'krish',30,'krish@gmail.com',45000,'sales');
begin tran;
delete from employee where id=102;
save transaction s1;/*create a savepoint s1*/
rollback transaction s1;
select *from employee;
begin tran;
insert into employee(id,name,age,email,salary,department) values(103,'bob',45,'bob@gmail.com',30000,'IT');
save transaction s2;/*creating the savepoint s2*/
rollback transaction s2;
begin transaction;
delete from employee where id=103;
save transaction s3;
rollback transaction s3;/*rollbacking to the savepoint s3*/
select *from employee;
create table emp(
id int ,
name varchar(10),
age int,
email varchar(20),
salary int,
department varchar(10)
);/*creating one more table*/
select *from emp;
insert into emp(id,name,age,email,salary,department) values(201,'bob',45,'bob@gmail.com',30000,	'IT');
insert into emp(id,name,age,email,salary,department) values(107,'lucky',28,'lucky@gmail.com',60000,'salesforce');
insert into emp(id,name,age,email,salary,department) values(108,'nimmi',30,'nimmi@gmail.com',30000,'IT');
insert into emp(id,name,age,email,salary,department) values(202,'heshi',45,'heshi@gmail.com',30000,	'HR');
insert into emp(id,name,age,email,salary,department) values(203,'minnu',45,'minnu@gmail.com',30000,	'HR');
select *from employee
union
select *from emp;/*performing union with two tables*/

select *from employee
union all
select *from emp;/*performing union all with two tables*/

select *from employee
intersect 
select *from emp;/*performing intersection between the tables*/

select *from emp
except
select* from employee;/*performing except  operation between two tables*/

select name,salary,age from employee
except
select name,salary,age from emp;/*perfrom except operation by shifting the two tables*/
create table customer(
id int unique,
name varchar(10) not null,
state varchar(10)
);/*unique,not null constraints have been used*/
insert into customer(id,name,state) values(1,'lucky','AP');
insert into customer(id,name,state) values(2,'kishore','AP');
insert into customer(id,name,state) values(3,'charan','UP');
insert into customer(id,name,state) values(4,'ani','Jammu');
insert into customer(id,name,state) values(5,'Heshi','Tamilnadu');
insert into customer(id,name,state) values(6,'Varsha','Kerala');
insert into customer(id,name,state) values(7,'honey','Jammu');
insert into customer(id,name,state) values(8,'fani','Tamilnadu');
insert into customer(id,name,state) values(9,'priya','UP');
insert into customer(id,name,state) values(10,'mani','Karnataka');
select * from customer;
alter table customer 
add  age int check(age>=18);/*check constraint is used*/

update customer set age=22 where id=2;
update customer set age=25 where id=3;
update customer set age=22 where id=4;
update customer set age=23 where id=5;
update customer set age=23 where id=6;
update customer set age=20 where id=7;
update customer set age=25 where id=8;
update customer set age=25 where id=9;
update customer set age=22 where id=10;
select *from customer;
create table student(
id int primary key,
name varchar(10),
schoolname varchar(20)
);
insert into student(id,name,schoolname) values(1,'aaa','school1');
insert into student(id,name,schoolname) values(2,'bbb','school2');
insert into student(id,name,schoolname) values(3,'ccc','school3');
insert into student(id,name,schoolname) values(4,'ddd','school4');
create table school(
branchname varchar(20),
id int primary key foreign key references student(id),
);/*created the primary key and foreign key */
insert into school(branchname,id) values('chennai',1);
insert into school(branchname,id) values('banglore',2);
insert into school(branchname,id) values('manglore',3);
insert into school(branchname,id) values('mumbai',4);
select *from school;

select *from student;



create table course
(
cid int,
id int,
coursename varchar(20)
);/*create course table*/
select *from course;

select name,department,cid,coursename from employee
inner join 
course on  employee.id=course.id;/*perfroming inner join*/

select name,department,cid,coursename from employee
left outer join 
course on employee.id=course.id;/*performing left outer join*/

select name,cid,coursename from employee
right outer join
course on employee.id=course.id;/*performing right outer join*/

select * from employee
full outer join
course on employee.id=course.id;/*Performing full outer join*/

select name,cid,department from employee
join
course on  employee.id=course.id;/*performing the natural join*/

select * from employee
cross join
course ;/*performing the cross join*/

/*Performing equi join*/
select *from employee,course
where employee.id=course.id;

/*Perfoming non-equi join*/
select *from employee,course
where employee.id>=course.id;

/*Perfoming self join*/
select e1.name,e1.id,e1.salary from employee e1,employee e2
where e1.salary=e2.salary and e2.name='krish';

select *from employee;
select e1.name,e1.id,e1.salary from employee e1, employee e2
where e1.salary=e2.salary and e2.name='nimmi';



/* String functions*/
select ascii('CB'); /*return leftmost ascii value*/
select char(66); /*return ascii value to character*/
select len('Microsift sql');/*return length*/
select lower('JHON');/*convert to lowercase*/
select replace('Microsoft sql','sql','server');/*replace*/
select reverse('python');/*reverse the string */
select upper('aparna');/*converts to upper*/
select str(136.564,8,4);/*STR(number, length, decimals)*/

/* Date Functions*/
select  getdate ();/*get current date and time*/
select dateadd (mm, 2, '2023-12-07');/*add months to existed date */
select datediff ( year, convert (datetime, '2006-05-06'), convert ( datetime, '2009-01-01'));/*it will return the difference of date,months,years also*/
select datepart (mm, '2008-5-22');/*return months value*/
select day ( '2023-05-30');/*return value of date of that particular day*/
select month ('2023-05-31');/*return month value*/
select year ( '2023-05-3');/*return year value*/

/*Mathematical Functions*/
select abs(-101);/*returns absolute value*/
select sin(1.5);/*returns angle in radians*/
select ceiling(14.01);/*returns the smallest or greater to the specified value*/
select exp(4.5);/*returns the exponencial value*/
select floor(14.75);
select log(5.4);/*return logarithmic value*/

/*Rankig Functions*/
/* row()_number-giving consecutive numbers to rank*/
select * from employee;
select id,name,salary,ROW_NUMBER() over(order by salary desc) as rownumber
from employee;
select * from employee;
/*rank()-used to give rank if duplicates allowed ranking will be changed based on duplicates  */
select id,name,salary,rank() over(order by salary) as rank
from employee;

/*dense_rank()-used to give ranks consecutively even if duplicates are allowed*/
select id,name,salary,dense_rank() over(order by salary desc) as rank
from employee;

/*ntile() function- it will divide give the rank in groups*/
select id,name,salary,ntile(2) over(order by salary) as rank
from employee;/*without condition*/

select name,salary,ntile(4) over(order by salary) as rank
from employee where salary>10000;/*with condition*/

/*System functions*/
select host_name() as Host_name;/*return system hostname*/
select Host_ID();/*return host id*/
select SUSER_ID();
select USER_ID();
select DB_NAME();/*return database name*/

/*Aggregate funtions*/
select count(*) as total_records from employee;

select count(*) from employee where salary>30000;

select department,min(salary) min_salary from employee
group by department;

select department,max(salary) max_salary from employee
group by department;

select department,sum(salary) from employee
group by department;

select department,avg(salary) from employee
group by department;




























