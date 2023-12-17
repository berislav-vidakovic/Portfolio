--0.1- Creating database & Orders table
DROP DATABASE IF EXISTS dbSuperStore
CREATE DATABASE dbSuperStore

USE dbSuperStore

--Creating an empty table as per CSV structure
DROP TABLE IF EXISTS tblOrders 

CREATE TABLE tblOrders(
	Order_ID CHAR(14),
	Order_Date DATE,
	Ship_Date DATE,
	Ship_Mode VARCHAR(20),
	Customer_ID CHAR(8),
	Customer_Name VARCHAR(30),
	Segment VARCHAR(30),
	Sales_Rep VARCHAR(30),
	Sales_Team VARCHAR(30),
	Sales_Team_Manager VARCHAR(30),
	Location_ID VARCHAR(35),
	City VARCHAR(25),
	[State] VARCHAR(25),
	Postal_Code CHAR(16),
	Region VARCHAR(20),
	Product_ID CHAR(15),
	Category VARCHAR(25),
	Sub_Category VARCHAR(25),
	Product_Name VARCHAR(200),
	Sales NUMERIC(10, 2),
	Quantity INT,
	Discount DECIMAL(10,2),
	Profit DECIMAL(10, 2)
)
