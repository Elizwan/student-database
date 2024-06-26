CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY,
    PrimaryAddress VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    ZipCode VARCHAR(20)
);
-- Student table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
	Gender varchar(50),
	AddressID INT, -- Foreign key referencing Address table
    FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
    GradeLevel INT
);

Select *from Addresses
Select * from Student
	
-- Teachers table
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
	EnrolmentYear DATE,
	OtherRoles VARCHAR(50)
);

-- Classes table
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(50),
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- Enrollments table -to represent student enrollment in classes
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    ClassID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Grades table
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    ClassID INT,
    Grade DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

--Getting to view the tables
Select * from Teachers
Select * from Classes
Select * from Enrollments
Select * from Grades

--Adding column Classtotal under table Classes
Alter table Classes add ClassTotal INT;

--Removing columns State and Zipcode under table Addresses
Alter table Addresses drop column State;
Alter table Addresses drop column Zipcode;

--Insert values to Addresses data
INSERT INTO Addresses (AddressID, PrimaryAddress, City)
VALUES(1,'145 Raila Way' ,'Nairobi'),
      (2, '457 Waiyaki ' ,'Kisumu'),
	  (3,  '008 Lumumba Drive', 'Mombasa'),
	  (4, '600 Wangari Mathai', 'Eldoret'),
	  (5, '254 Kipchoge Apartments', 'Nakuru');

-- Insert values to  student data
INSERT INTO Student (StudentID, FirstName, LastName, DateOfBirth, Gender, AddressID, GradeLevel)
VALUES (1, 'Jeremy', 'Kipkeino', '2005-05-10', 'Male', 1, 8),
       (2, 'Jane', 'Murunga', '2006-08-15', 'Female',2,10),
	   (3, 'Cleophas',' Wabwile', '2008-10-17','Male',4,5),
	   (4, 'Lavendar', 'Hassan','2007-12-23','Female',5,7),
	   (5, 'George', 'Kimani','2010-05-07','Male',3,6)

-- Insert values to teacher data
INSERT INTO Teachers (TeacherID, FirstName, LastName, Department, EnrolmentYear,OtherRoles)
VALUES (1, 'Jerald', 'Wangeci', 'Math' ,'2020','Football Coach'),
       (2, 'Wycliffe', 'Wawire', 'Science' ,'1999','Counsellor'),
	   (3,'QUinter', 'Wepukhulu','Arts','2015','CU Patron'),
	   (4,'Beatrice','Kageni','Agriculture','2017','Swimming Coach'),
	   (5, 'Vincent','Mamai','Creativity','2019','Choirmaster')

-- Insert values to class data
INSERT INTO Classes (ClassID, ClassName, TeacherID,ClassTotal)
VALUES (101, 'Lions', 1, 200),
       (102, 'Green', 2, 47),
	   (103,'Winners', 3, 24),
	   (104,'Legend', 4, 56),
	   (105,'Purple', 5, 48)

-- Insert sample enrollment data
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID)
VALUES (1, 1, 101),
       (2, 2, 102),
	   (3, 3, 104),
	   (4, 5, 105),
	   (5, 4, 103);

-- Insert sample grades data
INSERT INTO Grades (GradeID, StudentID, ClassID, Grade)
VALUES (1, 1, 101, 85),
       (2, 2, 102, 92),
	   (3, 3, 103, 56),
	   (4, 4, 104, 28),
	   (5, 5, 105, 48);

 -- Retrieving list of students in class 101
SELECT Student.FirstName, Student.LastName
FROM Student
INNER JOIN Enrollments ON Student.StudentID = Enrollments.StudentID
WHERE Enrollments.ClassID = 101; 

--Retrieving students with their average grades
SELECT Student.StudentID, Student.FirstName, Student.LastName, AVG(Grades.Grade) AS AverageGrade
FROM Student
LEFT JOIN Grades ON Student.StudentID = Grades.StudentID
GROUP BY Student.StudentID, Student.FirstName, Student.LastName;

--Retrieving addresses of the students
SELECT Student.FirstName, Student.LastName, Addresses.PrimaryAddress, Addresses.City
FROM Student
JOIN Addresses ON Student.AddressID = Addresses.AddressID;

--Retrieve name of the teacher whose under Column other roles is  A Cu patron.
SELECT FirstName
FROM Teachers
WHERE OtherRoles = 'CU Patron';

--Retrieving name of teache who teaches Class 104
SELECT Teachers.FirstName, Teachers.LastName
FROM Teachers
JOIN Classes ON Teachers.TeacherID = Classes.TeacherID
WHERE Classes.ClassID = 104;

--Getting all the Departments that the school have
SELECT Department from Teachers;

--Calculating Maximum,minimum,average,count and the total grades from the grade table
SELECT MAX(Grade) from	Grades;
SELECT MIN(Grade) from	Grades;
SELECT AVG(Grade) from	Grades;
SELECT COUNT(Grade) from Grades;
SELECT SUM(Grade) from	Grades;
