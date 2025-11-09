-- Create users
CREATE USER userA IDENTIFIED BY userA123;
CREATE USER userB IDENTIFIED BY userB123;

-- Grant basic roles
GRANT CONNECT, RESOURCE TO userA;

-- Login as userA and create table
CREATE TABLE emp (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);

-- Insert data
INSERT INTO emp VALUES (101, 'Alice', 50000);
INSERT INTO emp VALUES (102, 'Bob', 60000);
COMMIT;

-- Grant SELECT to userB
GRANT SELECT ON emp TO userB;

-- Grant more privileges
GRANT SELECT, INSERT, UPDATE ON emp TO userB;

-- Revoke privileges
REVOKE SELECT, INSERT, UPDATE ON emp FROM userB;

-- Drop users
DROP USER userB;
DROP USER userA CASCADE;