create database sql_02
use sql_02


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);



INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');


INSERT INTO Employees (EmployeeID, Name, DepartmentID, HireDate, Salary) VALUES
(101, 'Alice', 1, '2022-01-15', 60000.00),
(102, 'Bob', 2, '2021-06-20', 75000.00),
(103, 'Charlie', 3, '2020-03-01', 50000.00),
(104, 'Diana', 2, '2019-07-10', 80000.00),
(105, 'Eve', 1, '2023-02-25', 55000.00);


INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES
(201, 'Project Alpha', '2023-01-01', '2023-12-31'),
(202, 'Project Beta', '2022-05-15', NULL),
(203, 'Project Gamma', '2021-09-01', '2022-12-31');


INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(101, 201, 120),
(102, 202, 200),
(103, 203, 150),
(104, 201, 100),
(105, 202, 180);


select * from Employees
select * from Departments
select * from Projects
select * from EmployeeProjects

----puzzle 1
create table #tempemployee (department_name varchar(30), HireDate date)
insert into #tempemployee
select D.DepartmentName, E.HireDate from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where HireDate > DATEADD(year, -2, getdate())

select * from #tempemployee

 
 -------puzzle 2
create procedure AssignEmployeeToProject 
@employeeID int,
@projectID int

as 
Begin
insert into Employees (EmployeeID)  values (@employeeID)
insert into EmployeeProjects values (@employeeID,@projectID,0)
if exists(select EmployeeID from Employees where EmployeeID = @employeeID) and
  exists(select projectID from projects as P where P.ProjectID = @projectID )
  
  print concat('Success',' ', @employeeID, ' ','Employee',' ', 'is successfullefy inserted to', ' ', @projectID,' ', 'Project')
  
else
print  'Fail'

end


exec AssignEmployeeToProject @employeeID = 116, @projectID = 203


-------puzzle 3

declare @number int = 32; 


with Numbers as (
    select 1 as Number
    union all
    select Number + 1
    from Numbers
    where Number + 1 < @number
)

select 
    case 
        when sum(divisor) = @number then 'The number is perfect'
        else 'The number is not perfect'
    end as Result
from (
    select Number as divisor
    from Numbers
    where @number % Number = 0
) as Divisors;