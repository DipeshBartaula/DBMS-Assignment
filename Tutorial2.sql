--Tutorial no.2

/*
1. Create a university database that consists of tables such as the schema diagram above
(SQL data definition and tuples of some tables as shown above)
2. Please complete SQL data definition and tuples of some tables others
*/

CREATE DATABASE db_University;

CREATE TABLE Tbl_Department (
    Dept_Name VARCHAR(255) PRIMARY KEY,
    Building VARCHAR(255) NOT NULL,
    Budget DECIMAL(10,2) NOT NULL
);

CREATE TABLE Tbl_Course (
    Course_ID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    Credits INT NOT NULL,
    FOREIGN KEY (Dept_Name) REFERENCES Tbl_Department(Dept_Name)
);

CREATE TABLE Tbl_Instructor (
    ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Dept_Name) REFERENCES Tbl_Department(Dept_Name)
);

CREATE TABLE Tbl_Section (
    Course_ID INT NOT NULL,
    Sec_ID INT NOT NULL,
    Semester VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    Building VARCHAR(255) NOT NULL,
    Room_Number VARCHAR(255) NOT NULL,
    Time_Slot_ID INT NOT NULL,
    PRIMARY KEY (Course_ID, Sec_ID, Semester, Year),
    FOREIGN KEY (Course_ID) REFERENCES Tbl_Instructor(ID)
);

select * from Tbl_section;

CREATE TABLE Tbl_Teaches (
    ID INT PRIMARY KEY,
    Course_ID INT NOT NULL,
    Sec_ID INT NOT NULL,
    Semester VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    FOREIGN KEY (Course_ID) REFERENCES Tbl_Instructor(ID),
	FOREIGN KEY (Course_ID,Sec_ID,Semester,Year) REFERENCES Tbl_Section(Course_ID,Sec_ID,Semester,Year)
);

CREATE TABLE Tbl_Student (
    ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    Tot_Credit INT NOT NULL,
    FOREIGN KEY (Dept_Name) REFERENCES Tbl_Department(Dept_Name)
);

/*
3. Fill the tuple of each table at least 10 tuples.
*/

INSERT INTO Tbl_Department (Dept_Name, Building, Budget)
VALUES ('Biology','Watson',90000),
        ('Comp. Sci.','Taylor',10000),
        ('Elec. Eng.','Taylor',85000),
        ('Finance','Painter',120000),
        ('History','Painter',50000),
        ('Music','Packard',80000),
        ('Physics','Watson',70000);

INSERT INTO Tbl_Course (Course_ID, Title, Dept_Name, Credits)
VALUES ('BIO-101','Intro to Biology','Biology',4),
        ('BIO-301','Genetics','Biology',4),
        ('BIO-399','Computation Biology','Biology',3),
        ('CS-101','Intro to Computer Science','Comp. Sci.',4),
        ('CS-190','Game Design','Comp. Sci.',4),
        ('CS-315','Robotics','Comp. Sci.',3),
        ('CS-319','Image Processing','Comp. Sci.',3),
        ('CS-347','Database system concepts','Comp. Sci.',3),
        ('EE-181','Intro to Digital Systems','Elec. Eng.',3),
        ('FIN-201','Investment Banking','Finance',3),
        ('HIS-351','World History','History',3),
		('MU-199','Music Video Production','Music',3),
		('PHY-101','Physical Principles','Physics',4);

INSERT INTO Tbl_Section (Course_ID, Sec_ID, Semester, Year, Building, Room_Number, Time_Slot_ID)
VALUES ('BIO-101',1,'Summer',2009,'Painter',514,'B'),
        ('BIO-301',1,'Summer',2010,'Painter',514,'A'),
        ('CS-101',1,'Fall',2009,'Packard',101,'H'),
        ('CS-190',1,'Spring',2010,'Packard',101,'F'),
        ('CS-315',2,'Spring',2009,'Taylor',3128,'E'),
        ('CS-319',1,'Spring',2010,'Taylor',3128,'A'),
        ('CS-319',1,'Spring',2010,'Watson',120,'D'),
        ('CS-347',2,'Spring',2010,'Watson',100,'B'),
		('EE-181',1,'Spring',2009,'Taylor',3128,'C'),
		('FIN-201',1,'Spring',2010,'Pakard',101,'B'),
		('HIS-351',1,'Spring',2010,'Painter',514,'C');

INSERT INTO Tbl_Instructor (ID, Name, Dept_Name, Salary)
VALUES (10101,'Srinivasan','Comp. Sci.',65000),
        (12121,'Wu','Finance',90000),
        (15151,'Mozart','Music',40000),
        (22222,'Einstein','Physics',95000),
        (32343,'El Said','History',60000),
        (33456,'Gold','Physics',87000),
        (45565,'Katz','Comp. Sci.',75000),
        (58583,'Califeri','History',62000),
		(76543,'Singh','Finance',80000),
		(76766,'Crick','Biology',72000),
		(83821,'Brandt','Comp. Sci.',92000),
		(98345,'Kim','Elec. Eng.',80000);

INSERT INTO Tbl_Teaches (ID, Course_ID, Sec_ID, Semester, Year)
VALUES (10101,'CS-101',1,'Fall',2009),
        (10101,'CS-315',1,'Spring',2010),
        (10101,'CS-347',1,'Fall',2009),
        (12121,'FIN-201',1,'Spring',2010),
		(15151,'MU-199',1,'Spring',2010),
		(22222,'PHY-101',1,'Fall',2009),
        (32343,'HIS-351',1,'Spring',2010),
        (45565,'CS-101',1,'Spring',2010),
		(76766,'BIO-101',1,'Summer',2010),
		(98345,'EE-181',1,'Spring',2009);

INSERT INTO Tbl_Student (ID, Name, Dept_Name, Tot_Credit)
VALUES (00128,'Zhang','Comp. Sci.',102),
        (12345,'Mu','Comp. Sci.',30),
        (15637,'Jafar','Comp. Sci.',26),
        (21478,'Feud','History',94),
        (35416,'Rangf','Comp. Sci.',62),
        (44215,'John','History',80),
        (98214,'Ali','Comp. Sci.',74),
        (98564,'Zill','Finance',84),
		(44553,'Peltier','Physics',56),
		(55739,'Sanchez','Music',38);

/* 4. Write the following queries in Relational Algebra and SQL : */

--1. Find the names of all instructors in the History department

--In SQL
SELECT Name FROM Tbl_Instructor 
WHERE Dept_Name='History';


/*2. Findsthe instructor ID and department name of all instructors associated with a
department with budget of greater than $95,000*/

--In SQL
SELECT Tbl_Instructor.ID,Tbl_Instructor.Dept_Name  FROM Tbl_Instructor 
INNER JOIN 
Tbl_Department ON Tbl_Instructor.Dept_Name=Tbl_Department.Dept_Name 
WHERE Budget>95000;


/*3. Findsthe names of all instructors in the Comp. Sci. department together with the
course titles of all the courses that the instructors teach*/

--In SQL
SELECT Tbl_Instructor.Name, Tbl_Course.Title
FROM Tbl_Instructor
JOIN Tbl_Teaches ON Tbl_Instructor.ID = Tbl_Teaches.ID
JOIN Tbl_Section ON Tbl_Teaches.Sec_ID = Tbl_Section.Sec_ID
JOIN Tbl_Course ON Tbl_Section.Course_ID = Tbl_Course.Course_ID
WHERE Tbl_Instructor.Dept_Name = 'Computer Science';


/*4. Find the names of all students who have taken the course title of “Game Design”.*/

--In SQL
SELECT Tbl_Student.Name
FROM Tbl_Student
JOIN Tbl_Enrolls ON Tbl_Student.ID = Tbl_Enrolls.ID
JOIN Tbl_Section ON Tbl_Enrolls.Sec_ID = Tbl_Section.Sec_ID
JOIN Tbl_Course ON Tbl_Section.Course_ID = Tbl_Course.Course_ID
WHERE Tbl_Course.Title = 'Game Design';


/*5. For each department, find the maximum salary of instructors in that department. You
may assume that every department has at least one instructor.*/

--In SQL
SELECT Dept_Name, MAX(Salary)
FROM Tbl_Instructor
GROUP BY Dept_Name;

/* 6. Find the lowest, across all departments, of the per-department maximum salary
computed by the preceding query.*/

--In SQL
WITH per_dept_max_salary AS (
  SELECT Dept_Name, MAX(Salary) as max_salary FROM Tbl_Instructor
  GROUP BY Dept_Name
)
SELECT MIN(max_salary)
FROM per_dept_max_salary;


--7. Find the ID and names of all students who do not have an advisor.

--In SQL
SELECT ID, Name FROM Tbl_Student
WHERE Advisor_ID IS NULL;
