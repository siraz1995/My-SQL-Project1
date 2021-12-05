USE SalaryDB;
IF OBJECT_ID('SalaryDB') IS NOT NULL
DROP DATABASE SalaryDB;
GO
Create database SalaryDB
ON Primary 
(Name=N'SalaryDB_Data_1',Filename=N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SalaryDB_Data_1.mdf',SIZE=25 MB, maxsize=100 MB,filegrowth=5%)
LOG ON
(Name=N'SalaryDB_Log_1', FILENAME =N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\SalaryDB_Log_1.ldf', Size=2MB, Maxsize=25MB,Filegrowth=1%)
GO
----------------Table Create-------------------
Create Table Designation
(
  Designation_Id int identity(1,1) primary key not null,
  Designation_Name varchar(20)
);
Create table Employee
(
  Employee_Id int identity(1,1) primary key not null,
  FirstName varchar(20),
  LastName varchar(20),
  Email varchar(30),
  Phone varchar(11),
  Designation_Id int references Designation(Designation_Id),
  Basic_Salary varchar(30),
  Medical varchar(20),
  Home_Rent varchar(20),
  Provident_fund varchar(20),
  Net_Salary varchar(20)
);
Create Table Bonus
(
  Bonus_Id int identity(1,1) primary key not null,
  Bonus varchar(30),
  Skim varchar(10),
  Skim_on varchar(10)
);
Create Table SalaryDisburse
(
   ID int identity(1,1) primary key not null,
   Employee_Id int references Employee(Employee_Id),
   Net_Salary varchar(20),
   Bonus varchar(10),
   Net_Payable_salary varchar(20),
   Payment_Status varchar(10),
   BankAccountNO int unique ,
   BankName varchar(10),
   PaymentType varchar(10),
   Bonus_Id int references Bonus(Bonus_Id)
);
GO
------------------Chapter 11-------------------
---------Alter Table----------------
Alter table Employee alter column  Net_Salary money;
Alter table Employee alter column  Basic_Salary money;
Alter table Employee alter column  Medical money;
Alter table Employee alter column  Home_Rent money;
Alter table Employee alter column Provident_fund money;
Alter table Employee add  [Address] varchar(30);
Alter table Employee Drop column  [Address];
GO
----------Value insert within Designation table------------------
Insert into Designation values('Manager'),('Office Stuff'),('Marketing'); 

----------Value insert within Employee table------------------
Insert into Employee values
				           ('Sirazul','Islam','sirazulislam.bd.2014@gmail.com',01839721444,1,25000,2000,4000,500,30500),
                           ('Ibrahim','Hossain','ibra.21@gmail.com',01639721444,3,22000,2000,4000,400,27600),
                           ('Imran','Hossain','imran@gmail.com',01839721422,3,20000,2000,4000,500,25500),
                           ('Jui','Akter','jui@gmail.com',01812721444,2,21000,2000,4000,500,26500),
                           ('Lima','Akter','lima@gmail.com',01839341444,2,12000,2000,4000,500,17500),
                           ('Tarek','Jamil','tarek@gmail.com',01839721345,3,25000,2000,4000,500,30500),
                           ('Shajahan','Hossain','shajahan@gmail.com',01739721444,2,16000,2000,4000,500,21500),
                           ('Mizanur','Rahman','mizan@gmail.com',01649721444,3,15000,2000,4000,500,20500),
                           ('Mustafa','Kamal','mustafa@gmail.com',01679721444,3,16000,2000,4000,500,21500),
                           ('Aysha','Akter','aysha@gmail.com',01739721444,2,19000,2000,4000,500,24500);
			
--------------------Value insert within Bonus table------------------
Insert into Bonus values('EID ul Fiter','50%','Gross'),
                        ('EID ul Azha','50%','Gross'),
					    ('Boishakh','10%','Gross'),
                        ('Best performar','10%','Gross');

--------------------Value insert within SalaryDiburse table------------------
Insert into SalaryDisburse values 
                                 (1,30500,15250,45750,'Paid',1278786,'DBBL','Bank',1),
                                 (2,27600,13800,41400,'Paid',3456783,'Null','Hand Cash',2),
                                 (3,25500,2550,28050,'Paid',4354676,'Null','Hand Cash',3),
                                 (4,26500,2650,29150,'Paid',6643678,'Null','Hand Cash',4),
                                 (5,17500,8750,26250,'Paid',1238786,'DBBL','Bank',1),
                                 (6,30500,3050,33550,'Paid',4647854,'Null','Hand Cash',3),
                                 (7,21500,10750,32250,'Paid',1238986,'DBBL','Bank',2),
                                 (8,20500,10250,30750,'Paid',4579999,'Null','Hand Cash',1),
                                 (9,21500,2150,23650,'Paid',1238783,'DBBL','Bank',4),
                                 (10,24500,2450,26950,'Paid',7757578,'Null','Hand Cash',3);

--------------------Value insert within Advanced_Payment table------------------
Insert into Advanced_Payment values(1,15000,'2020.10.09')
Insert into Advanced_Payment values(2,12000,'2020.11.08')
Insert into Advanced_Payment values(3,11000,'2020.09.09')
Insert into Advanced_Payment values(4,10000,'2020.12.09')
Insert into Advanced_Payment values(5,13000,'2020.05.09')
Select*from Advanced_Payment
----------Chapter 3------------
-----Distinct----
select distinct PaymentType from SalaryDisburse;
-------Top----------
select top 3*from SalaryDisburse
order by Employee_Id desc;
----------Top 10%--------
select top 50 percent Employee_Id,Net_Salary from SalaryDisburse
order by Employee_Id desc;
-------Where-----
select*from [dbo].[Employee] where Employee_Id=10 and Net_Salary=24500;
select*from [dbo].[Employee] where Employee_Id=5 or Net_Salary=22000;
-------Not---------
select*from [dbo].[Employee] where not Employee_Id=5 ;
-------In & Not in----------
select*from [dbo].[Employee]Where Net_Salary in (20500,24500,21500);
select*from [dbo].[Employee]Where Net_Salary not in (20500,24500,21500);
---------between---------
select*from [dbo].[Employee]
where Net_Salary between 20500 and 24500;
----------Like---------
select*from [dbo].[Employee]
Where FirstName like 'Sir%'
-------ISNULL----
select *from[dbo].[SalaryDisburse]
where BankName is null;
-------Order by----------
select*from [dbo].[Employee]
order by Employee_Id desc;

-----------Chapter 4(ALL JOINING )--------------------
----INNERJOIN--------
select 
ID,FirstName,LastName,Net_Payable_salary
from SalaryDisburse s
 join Employee e
on e.Employee_Id=s.Employee_Id;
-----full outer join-----
select 
ID,FirstName,LastName,Net_Payable_salary
from SalaryDisburse s
 full outer join Employee e
on e.Employee_Id=s.Employee_Id;

---------Left join---------
select 
ID,FirstName,LastName,Net_Payable_salary
from SalaryDisburse s
 left join Employee e
on e.Employee_Id=s.Employee_Id;
----------RIGHT JOIN----------
select 
ID,FirstName,LastName,Net_Payable_salary
from SalaryDisburse s
 Right join Employee e
on e.Employee_Id=s.Employee_Id;
-----------Cross join------------
select 
ID,FirstName,LastName,Net_Payable_salary
from SalaryDisburse s
 Cross join Employee e

----------Union join------------
select Employee_Id from Employee
union 
 select Employee_Id from SalaryDisburse;
 ---------Self join----------
 select
 e.Employee_Id,e.FirstName,e.LastName,m.Email,m.Net_Salary
from Employee e
left join Employee m
on e.Employee_Id=m.Employee_Id;

			-----------Chapter 5(Aggregate Function)-----------
----CountRow------
Select COUNT(*) as "number of rows"
from [dbo].[Employee];
----count---
select COUNT(Net_Salary) as "empsalary"
from [dbo].[Employee];
---Avg----
select AVG(Net_Salary) as "Avgsalary"
from  [dbo].[Employee]  ;
----Sum----
select SUM(Net_salary) as [Totalsalary]
from [dbo].[Employee];
----Max----
select MAX(Net_salary) as [Maxsalary]
from [dbo].[Employee];
----Min---
select MIN(Net_salary) as [minsalary]
from [dbo].[Employee];
----group by---
select COUNT(Employee_Id) as [Number], FirstName from [dbo].[Employee]
group by FirstName;
------Having----------
select count(Employee_Id) as [Number],FirstName
from [dbo].[Employee]
group by FirstName
Having COUNT(Employee_Id) <5
order by count(Employee_Id) desc;
---Rollup----
select Employee_Id , sum(Net_salary) as [Rollup] from [dbo].[Employee]
group by rollup (Employee_Id);
----Rollup1---
select count(Employee_Id) as ID,Net_Salary 
from [dbo].[Employee]
group by rollup(Net_Salary);
----grouping sets----
select Employee_Id,FirstName,Net_Salary 
from [dbo].[Employee]
group by grouping sets (Employee_Id,FirstName,Net_Salary);
-----Cube----------
select Employee_Id,sum(Net_Salary) As Cuberesult from [dbo].[Employee]
 group by cube(Employee_Id) 
 order by Employee_Id;
 ----Over----
 select Employee_Id,FirstName,Net_Salary,COUNT(*) over() as OverColumn from [dbo].[Employee];		  

  -------------Chapter 6------------------
 ------Subquery----------
 select e.Employee_Id,e.FirstName,e.LastName,s.Net_Payable_salary from Employee e,SalaryDisburse s
 where e.Employee_Id=s.Employee_Id and e.Net_Salary >
 (select Avg(Net_Salary) from Employee);
 --------------CTE-------------
 with CTE_Emp_Salary(Employee_Id,FirstName,LastName,Basic_Salary,Net_Salary) as (select e.Employee_Id,e.FirstName,e.LastName,e.Basic_Salary,e.Net_Salary from Employee e)
 select Employee_Id,FirstName,LastName,Basic_Salary,Net_Salary
 from CTE_Emp_Salary
 where Net_Salary>=20500;

 -------------Chapter 7--------------
 ---------Merge Query----------
merge into dbo.Employee as e
using dbo.SalaryDisburse as s
on e.Employee_Id=s.Employee_Id
when matched then 
update set e.Net_Salary=s.Net_Salary
when not matched then
insert(Net_Salary) 
values(s.Net_Salary);

------------Chapter 8---------------
 select CAST(Net_Salary as numeric(18,0)) as castasdecimal from[dbo].[Employee];
 select CONVERT(varchar(50),Net_Salary)as ConvertColumn from  [dbo].[Employee];
 ----------Chapter 9------------
 ---Len function----
select  FirstName, LEN(FirstName) as Lenofaddress from [dbo].[Employee];
----Ltrim function------------
select LTRIM('   Sirazul Islam') as LtrimColumn;
------Rtrim Function---------
select RTRIM('Sirazul Islam     ') as RtrimColumn;
---------Subtring function------------
select SUBSTRING(FirstName,1,5) as substringColumn from [dbo].[Employee];
----------Replace function----------
select REPLACE('Sirajul Islam','j','z') as ReplaceColumn;
---------Reverse function------------
select REVERSE('Sirazul Islam') as ReverseColumn;
----------Charindex function------------
select CHARINDEX('l','Sirazul Islam') As CharindexColumn;
-----------Patindex--------------
select PATINDEX('%Islam%','Sirazul Islam') as patindexColumn;
------------Lower function----------
select LOWER('SIRAZUL') as lowerColumn;
----------Upper function------------
select UPPER('sirazul') as UpperColumn;
--------------Case function-----------------
select Employee_Id,FirstName,LastName,Net_Salary,
Case 
    when Net_Salary >30000
	   then 'Best'
	   when Net_Salary >25000
	   then 'Better'
	        Else 'Good'
	End as SalaryEvaluation
from [dbo].[Employee];

 ----------------Create Clustered and Nonclustered index-------------------
 Create Clustered INDEX IX_Advanced_Payment_Id on Advanced_Payment(AdvancedPaymentId);

 Create NonClustered INDEX IX_Employee_Id on Employee(Employee_Id);
 GO
 ----------------Chapter 13(ALL TYPE VIEW CREATE)-----------------------------
  -----------create view with schemabinding--------
Create view vw_NetSalary1
 with Schemabinding
 as
 select ID,FirstName + ' ' + LastName as FullName,Basic_Salary,Bonus,PaymentType,
 Basic_Salary+Medical+Home_Rent-Provident_fund as Net_Salary
 from Employee join SalaryDisburse  on Employee.Employee_Id=SalaryDisburse.Employee_Id
 Where  Basic_Salary+Medical+Home_Rent-Provident_fund > 0;
 GO
 
 -------------------Create view with Encryption--------------
 Create view vw_NetSalary
 with ENCRYPTION
 as
 select ID,FirstName + ' ' + LastName as FullName,Basic_Salary,Bonus,PaymentType,
 Basic_Salary+Medical+Home_Rent-Provident_fund as Net_Salary
 from Employee join SalaryDisburse  on Employee.Employee_Id=SalaryDisburse.Employee_Id
 Where  Basic_Salary+Medical+Home_Rent-Provident_fund > 0;
 GO
 -----------------------create view with schemabinding And Encryption--------
 Alter view vw_NetSalary2
 with SCHEMABINDING,ENCRYPTION
 as
 select ID,FirstName + ' ' + LastName as FullName,Basic_Salary,Bonus,PaymentType,
 Basic_Salary+Medical+Home_Rent-Provident_fund as Net_Salary
 from Employee join SalaryDisburse  on Employee.Employee_Id=SalaryDisburse.Employee_Id
 Where  Basic_Salary+Medical+Home_Rent-Provident_fund > 0;
 GO

 ---------------------create view with check option--------
Create view vw_NetSalary3
 as
 select ID,FirstName + ' ' + LastName as FullName,Basic_Salary,Bonus,PaymentType,
 Basic_Salary+Medical+Home_Rent-Provident_fund as Net_Salary
 from Employee join SalaryDisburse  on Employee.Employee_Id=SalaryDisburse.Employee_Id
 Where  Basic_Salary+Medical+Home_Rent-Provident_fund > 0
 with check option;
  GO

  ----------------------------Chapter 15(CREATE STORE PROCEDURE,FUNCTION,TRIGGER)---------------------------
  -------------------Create  Store Procedure-------------
 ---------Store Procedure withOut variables or parameter-------
Create proc spsalary
as
select Employee_Id,FirstName,Net_Salary from Employee
GO
----------------------Store Procedure with variables or parameter-------
create proc spGetSalary
@FirstName varchar(20),
@Basic_Salary Money ,
@Medical money,
@Home_Rent money
AS
select @FirstName,@Basic_Salary,@Medical,@Home_Rent from Employee
GO
----------Store Procedure with Insert statement-------
Create proc spInsertEmployee
@FirstName varchar(20),
@Basic_Salary money,
@Medical money,
@Home_Rent money
AS
Insert into Employee(FirstName,Basic_Salary,Medical,Home_Rent)
values (@FirstName,@Basic_Salary,@Medical,@Home_Rent);
GO
---------Store Procedure with update statement-------
create proc spUpdateEmployee
@Employee_Id int,
@FirstName varchar(20),
@Net_Salary money,
@Medical money,
@Home_Rent money
AS
update Employee
set FirstName=@FirstName,Net_Salary=@Net_Salary,Medical=@Medical,Home_Rent=@Home_Rent
where Employee_Id=@Employee_Id
GO
---------Store Procedure with delete statement-------
create proc spDeleteEmployee
@Employee_Id int,
@FirstName varchar(20),
@Net_Salary money,
@Medical money,
@Home_Rent money
AS
delete Employee where Employee_Id=@Employee_Id
GO
--------------------Create function --------------
-----------Table value Function-----------
create function FnSalary()
Returns table
Return(select*from Employee);
GO
---------------Scaler value Function--------------
Create function Fnsalary1()
Returns Int
Begin
  Declare @a Int;
  select @a=COUNT(*) from Employee;
  return @a;
End;
GO
----------TABLE CREATE FOR TRIGGER---------------
Create Table Advanced_Payment
(
  AdvancedPaymentId int  primary key not null,
  AdvancedPaymentAmount Money,
  AdvancedPaymentDate datetime
);
Create Table Advanced_Payment_Audit
(
  AdvancedPaymentId int  primary key not null,
  AdvancedPaymentAmount money,
  AdvancedPaymentDate datetime,
  DoneBy varchar(50),
  ActivityTime datetime
);
GO
---------------Create Trigger----------------------
---------------Instead of Trigger-------------------
create TRIGGER TRAdvanced
ON Advanced_Payment  
INSTEAD OF DELETE
AS
BEGIN
       DECLARE @AdvancedPaymentId INT
       SELECT @AdvancedPaymentId= Deleted.AdvancedPaymentId    
       FROM DELETED 
       IF @AdvancedPaymentId = 2
       BEGIN
              RAISERROR('ID 2 record cannot be deleted',16 ,1)
              ROLLBACK
              INSERT INTO Advanced_Payment_Audit
              VALUES(@AdvancedPaymentId, 'Record cannot be deleted.')
       END
       ELSE
       BEGIN
              DELETE FROM Advanced_Payment
             WHERE AdvancedPaymentId = @AdvancedPaymentId
              INSERT INTO Advanced_Payment_Audit
              VALUES(@AdvancedPaymentId, 'Instead Of Delete')
       END
END
Go
---------------After Trigger--------------------
create trigger TRAdvanced_Payment on Advanced_Payment
after update, insert
as
begin
  insert into Advanced_Payment_Audit
  (AdvancedPaymentId, AdvancedPaymentAmount, AdvancedPaymentDate, DoneBy,ActivityTime )
  select i.AdvancedPaymentId, i.AdvancedPaymentAmount, i.AdvancedPaymentDate, SUSER_SNAME(), getdate() 
  from Advanced_Payment a
  inner join inserted i on a.AdvancedPaymentId=i.AdvancedPaymentId
end
Go
--------------Test after TRIGGER---------------------
update Advanced_Payment 
set AdvancedPaymentAmount =16000, 
AdvancedPaymentDate=getdate()  
where AdvancedPaymentAmount=15000
go
update Advanced_Payment 
set AdvancedPaymentAmount =16000, 
AdvancedPaymentDate=getdate()  
where AdvancedPaymentAmount=10000
go
select * from Advanced_Payment 
select * from Advanced_Payment_Audit



