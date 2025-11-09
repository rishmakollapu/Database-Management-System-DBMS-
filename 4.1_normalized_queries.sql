-- Create Students table
CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY,
    StudentName VARCHAR(30),
    Major VARCHAR(30)
);

-- Create Courses table
CREATE TABLE Courses (
    CourseID INTEGER PRIMARY KEY,
    CourseName VARCHAR(30),
    Credits INTEGER
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    StudentID INTEGER,
    CourseID INTEGER,
    EnrollmentDate DATE,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Instructors table
CREATE TABLE Instructors (
    InstructorID INTEGER PRIMARY KEY,
    InstructorName VARCHAR(30),
    Phone BIGINT
);

-- Create Course_Instructors table
CREATE TABLE Course_Instructors (
    CourseID INTEGER,
    InstructorID INTEGER,
    PRIMARY KEY (CourseID, InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- Insert sample data
INSERT INTO Students VALUES (1, 'Alice Smith', 'Computer Science');
INSERT INTO Students VALUES (2, 'Bob Johnson', 'Mathematics');
INSERT INTO Students VALUES (3, 'Charlie Brown', 'Physics');

INSERT INTO Courses VALUES (101, 'Introduction to Programming', 3);
INSERT INTO Courses VALUES (102, 'Calculus I', 4);
INSERT INTO Courses VALUES (103, 'Classical Mechanics', 3);

INSERT INTO Enrollments VALUES (1, 101, DATE '2024-09-01');
INSERT INTO Enrollments VALUES (1, 102, DATE '2024-09-01');
INSERT INTO Enrollments VALUES (2, 102, DATE '2024-09-01');
INSERT INTO Enrollments VALUES (3, 103, DATE '2024-09-01');

INSERT INTO Instructors VALUES (1001, 'Dr. Emily White', 7225148456);
INSERT INTO Instructors VALUES (1002, 'Prof. David Green', 9822663346);

INSERT INTO Course_Instructors VALUES (101, 1001);
INSERT INTO Course_Instructors VALUES (102, 1002);
INSERT INTO Course_Instructors VALUES (103, 1002);

-- Queries
SELECT StudentName, Major FROM Students;

SELECT CourseName, Credits FROM Courses;

SELECT s.* FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Introduction to Programming';

SELECT i.* FROM Instructors i
JOIN Course_Instructors ci ON i.InstructorID = ci.InstructorID
JOIN Courses c ON ci.CourseID = c.CourseID
WHERE c.CourseName = 'Introduction to Programming';

SELECT c.CourseName, COUNT(e.StudentID)
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

SELECT c.CourseName, i.InstructorName
FROM Courses c
JOIN Course_Instructors ci ON c.CourseID = ci.CourseID
JOIN Instructors i ON ci.InstructorID = i.InstructorID;

SELECT i.InstructorName, COUNT(ci.CourseID) AS NumberOfCourses
FROM Instructors i
JOIN Course_Instructors ci ON i.InstructorID = ci.InstructorID
GROUP BY i.InstructorName;

SELECT s.StudentName, e.EnrollmentDate
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentDate > DATE '2024-01-01';

SELECT s.StudentName, SUM(c.Credits) AS TotalCredits
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY s.StudentName;

SELECT CourseName, Credits FROM Courses WHERE Credits > 3;