create database amazon;
select*from amazon.customers;
-- TASK 1
-- CREATE AN ER DIAGRAM...

-- TASK 2
-- IDENTIFY THE PRIMARYS KEY AND FOREIGN KEYS...

-- TASK 3.
-- WRITE A QUERY TO:
-- 1.Retrieve all customers from a specific city.
select * from amazon.customers
where city="East Tonya";

-- 2.Fetch all products under the "Fruits" category.
select productName from amazon.products
where category="Fruits";


-- TASK 4.
-- Write DDL statements to recreate the Customers table with the following constraints.
-- 1.CustomerID as the primary key.
-- 2.Ensure Age cannot be null and must be greater than 18.
-- 3.Add a unique constraint for Name.
alter table amazon.customers
modify age int not null check (age>=18);

alter table amazon.customers
modify name varchar(100) unique;

 
-- Task 5.
-- Insert 3 new rows into the products table using INSERT statements.
insert into amazon.products (productID,productName,Category,SubCategory,PricePerUnit,StockQuantity,SupplierID)
values
("BI720970","Dairy Milk","Choclate","Dark Choclate",350,100,"SI242690"),
("BI720971","Face wash","Skin Care","Ethil Glow",250,150,"SI242691"),
("BI720972","lotion","Skin Care","Nivea",350,100,"SI242692");


-- Task 6.
-- update the stock quantity of a product where ProductID matches a specific ID.
set sql_safe_updates=1;
update products set stockQuantity=1000
where productID="BI720971";


-- Task 7.
-- Delete a supplier from the Suppliers table where their city matches a specific.
delete from amazon.suppliers
where City="South Ana";


-- Task 8.
-- Use SQL constraints to:
-- Add  a Check constraint to ensure that ratings in the Reviews table are between 1 and 5.
alter table amazon.reviews
add check (Rating between 1 and 5);

-- Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value:"No").
alter table amazon.customers
modify PrimeMember varchar(50) default"No";


-- Task 9.
-- Write queries using:
-- Where clause to find orders placed after 2024_01_01.
select*from amazon.orders
where OrderDate>("2024-01-01");

-- Having clause to list products with average ratings greater than 4.
select p.ProductName,avg(v.Rating) as avg_rating from amazon.reviews as v
right join amazon.products as p
on p.ProductID=v.ProductID
group by p.ProductName
having avg(v.Rating)>4;

-- Group by and Order by clause to rank products by total sales.
select customerID,sum(orderAmount), rank() over (order by sum(orderAmount) desc) as sales_rank from amazon.orders
group by  customerID;


-- Task 10.
-- INDENTIFYING HIGH_VALUE CUSTOMERS
-- Amazon Fresh wants to identify top customers based on their total spending.We will:
-- 1.Calculate each customer's total spending.
select customerID,sum(OrderAmount) as total_spend from amazon.orders
group  by customerID;

-- 2.Rank customers based on their spending.
select customerID,sum(OrderAmount+ DeliveryFee), rank() over (order by sum(OrderAmount+DeliveryFee)  desc) as spending_rank
from amazon.orders
group by CustomerID;

-- 3.Identify customers who have spent more than ₹5000.
select customerID,sum(OrderAmount) as spent_amount from amazon.orders
group by customerID
having sum(OrderAmount)>5000;


-- COMPLEX AGGREGATION AND JOINS
-- Task 11.
-- USE SQL TO:
-- 1.Join the Orders and OrdersDetails tables to calculate total revenue per order.
select o.orderID,sum(u.unitprice*u.Quantity+u.Discount)as reve_per_order from amazon.orders as o
left join amazon.order_details as u
on u.OrderID=o.OrderID 
group by o.orderID;

-- 2.Identify customrs who placed the most orders in a specific time period.
select CustomerID,count(*) as most_orders  from amazon.orders
where OrderDate between "2025-31-25" and "2025-01-01"
group by CustomerID
order by most_orders desc;

-- 3. Find the Supplier with the most products in stock.
select SupplierID,sum(StockQuantity) as total_stock from amazon.products
group by SupplierID order by sum(StockQuantity) desc;


-- Normalization 
-- Task12.Normalize the Products table to 3NK:
-- 1.Separate product categories and subcategories into a new table.alter
select*from amazon.products_1;
create table amazon.products_1(
ProductID varchar(100),
ProductName varchar(100),
Category varchar (100),
SupplierID varchar(100));
Insert into amazon.products_1(ProductID,ProductName,Category,SupplierID)
values
("asdfgh1","Face Wash","Skin Care","vbnmk8"),
("bvkup2","Lotion","Skin Care","mkjhg9"),
("mhgfi3","Choclate","Dairy milk","mbytmn6");
Create table Products_2(
ProductID varchar(100),
Subcategory varchar(100),
SupplierID varchar(100));
insert into amazon.Products_2(ProductID,Subcategory,SupplierID)
values
("asdfgh1","EthilGlow","mnhuooiu"),
("bvkup2","Nivea","jjgutv"),
("mhgfi3","Dark","mnhgyu");
-- 2.Create foreign keys to maintain relationships.
-- used alter table assign foreign key



 -- SUBQUEIRES AND NESTED QUERIES
 -- Task 13. Write a subquery to:
 -- 1.Identify the top 3 products based on sales revenue.
 select ProductID,sum(UnitPrice * Quantity) as sales_reven from amazon.order_details
 group by productID order by sum(UnitPrice*	Quantity) desc limit 3;
 
 -- 2.Find Customers who haven't placed any orders yet.
 select c.CustomerID,c.name as CustomerName,o.OrderID from customers as c
 left join amazon.orders as o
 on c.CustomerID=o.CustomerID 
 where o.OrderID is null;
 
 
 -- REAL-WORLD ANALYSIS
 -- Task 14. Write a subquery to:
 -- 1.Which cities have the highest concentration of Prime members?
 select  distinct city,count(PrimeMember) from amazon.customers
 group by City order by count(PrimeMember) desc;
 
 
 -- 2.What are the top 3 most frequently ordered categories?
 select Category,count(*) as order_count from amazon.products 
 group by Category 
 order by count(*) desc
 limit 3; 
 alter table amazon.products_1
 change column ProductID ProductID varchar(100) Null;
 
 
 
 
 
 
 





 




 














