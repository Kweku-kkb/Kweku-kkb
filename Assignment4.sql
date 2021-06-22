/*
1.	What is View? What are the benefits of using views?
	A view is a virtual table created in the database having both columns and rows and cannot be stored in the database
	A view can let a user display specific rows and columns from a database
	A view can also be used as a security mechanism by letting users access data from the database

2.	Can data be modified through views?
	Data cannot directly be modified through views because it allows the user to virtually access specific columns or rows from the table
	
3.	What is stored procedure and what are the benefits of using it?
	A stored procedure is a saved batch of statements of code(query) as a logical unit that can be reused for fetching data from a database
	A stored procedure is helps in code reusability instead of rewriting the same statement at a different time. 
	It is time efficient because the user does not need to write multiple queries and they are also easy to maintain
	
4.	What is the difference between view and stored procedure?
	Views are virtual tables and cannot perform any form of data modification on the database whereas stored procedures can contain view statements and modify data in the database
	A View does not exist as as a set stored of data values in the database unless indexed whereas stored procedures caan exists a a stored set of statements


5.	What is the difference between stored procedure and functions?
	A funtion must return a value whereas a stored procedure optionally returns a value - thus returning no values or returning multiple sets of values
	Stored procedures can call functions and have input or output parameters whereas stored prodecures cannot be called from functions and can have only input parameters

6.	Can stored procedure return multiple result sets?
	A stored procedure can return multiple result sets because they can contain multiple select statements

7.	Can stored procedure be executed as part of SELECT Statement? Why?
	Yes, this is can only be done implicitly if the stored procedure is returning a result otherwise it cannot be used with a select statement. 


8.	What is Trigger? What types of Triggers are there?
	A trigger is a special type of stored procedure that is automatically invoked whenever an event occurs in the database.
	i) DML triggers 
	ii) Logon triggers
	iii) DDL triggers




9.	What are the scenarios to use Triggers?
	A trigger can be used in the following instances:
	i) DML triggers - is invoked when a user tries to modify the data
	ii) Logon triggers - is invoked when a user logs on to start a session
	iii) DDL triggers - is invoked during a data defnition event

10.	What is the difference between Trigger and Stored Procedure?
	 A triger is a special kind of stored procedure which is invoked automically when an event occus and does not return any results 
	 whereas a stored procedure is a piece of user defined code that can include other instances and can return result sets
*/

--1.	Lock tables Region, Territories, EmployeeTerritories and Employees. Insert following information into the database. In case of an error, no changes should be made to DB.
--a.	A new region called “Middle Earth”;


--b.	A new territory called “Gondor”, belongs to region “Middle Earth”;


--c.	A new employee “Aragorn King” who's territory is “Gondor”.


--4.	Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
	create view view_product_order_[ofori] as
	select p.ProductID, sum(od.Quantity)
	from Products p join [Order Details] od
	on p.ProductID = od.ProductID
	group by p.ProductID

--6.	Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities that ordered most that product combined with the total quantity of that product ordered from that city as output.
	create procedure sp_product_order_city_[ofori]
	@PName nvarchar(40)
	@VCity output
	@Total output
	as
	select top 5 c.City, sum(od.Quantity)
	from [Order Details] od inner join Products p
	on p.ProductName = @Pname and p.ProductID = od.ProductID
	inner join Orders o
	on o.OrderID = od.OrderID
	inner join Customers c
	on c.CustomerID = o.CustomerID
	group by c.City
	order by sum(od.Quantity) desc


--7.	Lock tables Region, Territories, EmployeeTerritories and Employees. Create a stored procedure “sp_move_employees_[your_last_name]” that automatically find all employees in territory “Tory”; if more than 0 found, insert a new territory “Stevens Point” of region “North” to the database, and then move those employees to “Stevens Point”.
	create procedure sp_move_employees_[ofori]
	as
	select *
	from EmployeeTerritories et inner join Territories t
	on t.TerritoryID = et.TerritoryID
	inner join Employees e
	on et.EmployeeID = e.EmployeeID
	where t.TerritoryDescription = 'Troy'

	-- let table 1 be t1
--14. 
	create table t2(varchar(20))
	insert t2 values('FullName')
	insert t2 values(select (t.FirstName+' 't.LastName) as FullName from t1 t)

--15. 
	select top 1 t.Student
	from t1 t
	where t. Sex = 'F'
	order by t.Marks


--5.	Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
	create procedure sp_product_order_quantity_[Ofori] 
	@Pid int 
	@TotalOrder int output
	as
	select 
	@TotalOrder = sum(od.Quantity)
	from [Order Details] od, Products p
	on od.ProductID = p.ProductID
	group by  p.ProductID