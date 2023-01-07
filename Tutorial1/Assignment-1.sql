/*employee(employee-name, street, city)
works(employee-name, company-name, salary)
company(company-name, city)
manages (employee-name, manager-name)*/

--Figure 5: Employee database.


/*1. Give an SQL schema definition for the employee database of Figure 5. Choose an appropriate
primary key for each relation schema, and insert any other integrity constraints (for example,
foreign keys) you find necessary.*/

create database db_EmployeeTask;

create table Tbl_employee 
(
	employee_name varchar(255)  Primary key,
	street varchar(255),
	city varchar(255)
);

create table Tbl_works
(
	employee_name varchar(255)  Primary key,
	company_name varchar(255),
	salary int
);

create table Tbl_company
(
	company_name varchar(255)  Primary key,
	city varchar(255)
);

create table Tbl_manages
(
	employee_name varchar(255)  Primary key,
	manager_name varchar(255)
);

INSERT INTO Tbl_employee(employee_name, street, city)
VALUES 
('Danial','7th Street','Boston'),
('John','104 Elm St.','NY'),
('Sarah','8th Street','LA'),
('Karen','6th Street','San Jose'),
('Anthony','3rd Street','Dallas'),
('Donald','201 Main St.','LA'),
('Mark','Main Street','Boston'),
('Ashley','8th Street','LA'),
('Emily','5th Street','Denver'),
('Jones','7th Street','LA'),
('Rock','104 Elm St.','NY'),
('Groot','8th Street','LA'),
('IronMan','6th Street','San Jose'),
('Hulk','3rd Street','Dallas'),
('Rahul','Main Street','Denver'),
('Bikrant','104 Elm St.','NY'),
('Sophia','8th Street','Texas'),
('Akash','6th Street','San Jose'),
('Neha','6th Street','San Jose'),
('Smriti','9th Street','LA');

--check the table
SELECT * FROM Tbl_employee;

INSERT INTO Tbl_works(employee_name, company_name, salary)
VALUES
('Danial','Walmart',2500),
('John','Amazon',3333),
('Sarah','First Bank Corporation',50000),
('Karen','CVS Health',10000),
('Anthony','First Bank Corporation',6000),
('Donald','Amazon',45000),
('Mark','Google',65000),
('Ashley','First Bank Corporation',15000),
('Emily','First Bank Corporation',40000),
('Jones','Small Bank Corporation',2500),
('Rock','Amazon',3333),
('Groot','Small Bank Corporation',5000),
('IronMan','CVS Health',10000),
('Hulk','Small Bank Corporation',20000),
('Rahul','Walmart',50000),
('Bikrant','Amazon',40000),
('Sophia','First Bank Corporation',60000),
('Akash','CVS Health',35000),
('Neha','Google',90000),
('Smriti','Small Bank Corporation',30000);

--check the table
SELECT * FROM Tbl_works;

INSERT INTO Tbl_company(company_name, city)
VALUES
('Apple', 'LA'),
('Walmart','NY'),
('Google','Boston'),
('First Bank Corporation','Dallas'),
('CVS Health','NY'),
('Amazon','NY'),
('Small Bank Corporation','LA');

--check the table
SELECT * FROM Tbl_company;

INSERT INTO Tbl_manages(employee_name, manager_name)
VALUES
('Danial','Rahul'),
('John','Bikrant'),
('Sarah','Sophia'),
('Karen','Akash'),
('Anthony','Sophia'),
('Donald','Bikrant'),
('Mark','Neha'),
('Ashley','Sophia'),
('Emily','Sophia'),
('Jones','Smriti'),
('Rock','Bikrant'),
('Groot','Smriti'),
('IronMan','Akash'),
('Hulk','Smriti');

--check the table
SELECT * FROM Tbl_manages;

--Add foreign key 
ALTER TABLE Tbl_works
ADD FOREIGN KEY (employee_name) REFERENCES Tbl_employee(employee_name);

ALTER TABLE Tbl_works
Add FOREIGN KEY(company_name) REFERENCES Tbl_company(company_name);

ALTER TABLE Tbl_manages
ADD FOREIGN KEY(employee_name) REFERENCES Tbl_employee(employee_name);


/*2. Consider the employee database of Figure 5, where the primary keys are underlined. Give
an expression in SQL for each of the following queries:*/

/*Q.no.2)a)Find the names of all employees who work for First Bank Corporation.*/

SELECT employee_name FROM Tbl_works WHERE company_name = 'First Bank Corporation';

/*Q.no.2)b)Find the names and cities of residence of all employees who work for First Bank Corporation.*/

/*using subqueries*/
SELECT employee_name, city FROM tbl_employee WHERE employee_name IN
(SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation'); 

/*using join*/
SELECT Tbl_employee.employee_name, Tbl_employee.city FROM Tbl_employee
INNER JOIN Tbl_works ON Tbl_employee.employee_name = Tbl_works.employee_name
WHERE Tbl_works.company_name = 'First Bank Corporation';

/*Q.no.2)c)Find the names, street addresses, and cities of residence of all employees who work for
First Bank Corporation and earn more than $10,000.*/

/*using Subqueries*/
SELECT * FROM Tbl_employee WHERE employee_name IN
(SELECT employee_name FROM Tbl_works WHERE company_name = 'First Bank Corporation' AND salary > 10000); 

/*using join*/
SELECT Tbl_employee.employee_name, Tbl_employee.street, Tbl_employee.city FROM Tbl_employee
INNER JOIN Tbl_works ON Tbl_employee.employee_name = Tbl_works.employee_name
WHERE Tbl_works.company_name = 'First Bank Corporation' AND Tbl_works.salary > 10000;

/*Q.no.2)d) Find all employees in the database who live in the same cities as the companies for
which they work.*/

/*using subqueries*/
SELECT Tbl_employee.employee_name, Tbl_employee.city FROM Tbl_employee  WHERE Tbl_employee.city = 
(SELECT city FROM Tbl_company  WHERE Tbl_company.company_name = 
(SELECT company_name FROM Tbl_works WHERE Tbl_works.employee_name = Tbl_employee.employee_name));

/*using join*/
SELECT Tbl_employee.employee_name, Tbl_employee.city FROM Tbl_employee
INNER JOIN Tbl_works ON Tbl_employee.employee_name = Tbl_works.employee_name
INNER JOIN Tbl_company ON Tbl_works.company_name = Tbl_company.company_name
WHERE Tbl_company.city = Tbl_employee.city;

/*Q.no.2)e)Find all employees in the database who live in the same cities and on the same streets
as do their managers.*/



/*Q.no.2)f)Find all employees in the database who do not work for First Bank Corporation.*/

SELECT employee_name from Tbl_works WHERE company_name != 'First Bank Corporation';

/*Q.no.2)g)Find all employees in the database who earn more than each employee of Small Bank Corporation.*/


/*Q.no.2)h)Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.*/

SELECT * FROM Tbl_company
WHERE Tbl_company.city = (SELECT Tbl_company.city FROM Tbl_company WHERE Tbl_company.company_name = 'Small Bank Corporation');

/*Q.no.2)i)Find all employees who earn more than the average salary of all employees of their company.*/

SELECT tbl_works.employee_name, tbl_works.company_name FROM
(SELECT company_name, AVG(salary) AS average_salary
FROM tbl_works GROUP BY company_name) AS average
JOIN tbl_works ON average.company_name = tbl_works.company_name
WHERE tbl_works.salary > average.average_salary;

/*Q.no.2)j)Find the company that has the most employees.*/
SELECT company_name, employee_count FROM
(SELECT company_name, COUNT(employee_name) AS employee_count
FROM tbl_works GROUP BY company_name) as C1
ORDER BY employee_count DESC;

/*Q.no.2)k)Find the company that has the smallest payroll.*/
SELECT company_name, payroll FROM
(SELECT company_name, SUM(salary) AS payroll
 FROM tbl_works GROUP BY company_name) AS total_payroll
ORDER BY payroll ASC;


/*Q.no.2)l) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.*/

select c.company_name
from tbl_company c join tbl_works w
on c.company_name = w.company_name
group by c.company_name
having avg(w.salary) > (select avg(w2.salary)
                        from tbl_company c2 join
                             tbl_works w2
                             on c2.company_name = w2.company_name
                        where c2.company_name = 'First Bank Corporation'
                       );

/*Q.no.3)a)Modify the database so that Jones now lives in Newtown.*/

--check previous city
select * from tbl_employee; where employee_name='Jones';

--update city
UPDATE Tbl_employee
SET city='Newtown'
Where employee_name='Jones';

--check the table
select * from tbl_employee where employee_name='Jones';


/*Q.no.3)b)Give all employees of First Bank Corporation a 10 percent raise.*/

--check previous salary
select * from tbl_works where company_name='First Bank Corporation';

--update salary
UPDATE Tbl_works
SET salary=salary *1.1
Where company_name='First Bank Corporation';

--check the table
select * from tbl_works where company_name='First Bank Corporation';


/*Q.no.3)c)Give all managers of First Bank Corporation a 10 percent raise.*/
UPDATE tbl_works 
SET salary = salary * 1.1
WHERE employee_name = ANY (SELECT DISTINCT manager_name  FROM tbl_manages) AND company_name = 'First Bank Corporation';


/*Q.no.3)d)Give all managers of First Bank Corporation a 10 percent raise unless the salary becomes greater than $100,000; in such cases, give only a 3 percent raise.*/

UPDATE tbl_works
SET tbl_works.salary += salary * case when salary+salary*0.10 > 1000000 then 0.03 else 0.10 end
WHERE tbl_works.employee_name IN (SELECT manager_name FROM Tbl_manages) AND tbl_works.company_name='First Bank Corporation';


/*Q.no.3)e)Delete all tuples in the works relation for employees of Small Bank Corporation.*/




