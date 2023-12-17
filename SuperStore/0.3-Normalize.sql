--0.3-Data normalization 

--Creating Customers table
DROP TABLE IF EXISTS tblCustomers

SELECT DISTINCT 
	Customer_ID, 
	Customer_Name, 
	Segment
INTO tblCustomers 
FROM tblOrders 

--Creating Product table
DROP TABLE IF EXISTS tblProduct

SELECT DISTINCT 
	Product_ID,
	Product_Name,
	Category,
	Sub_Category
INTO tblProduct
FROM tblOrders

--Creating SalesTeam table
DROP TABLE IF EXISTS tblSalesTeam

SELECT DISTINCT 
	Sales_Rep,
	Sales_Team,
	Sales_Team_Manager
INTO tblSalesTeam
FROM tblOrders

--Creating Location table
DROP TABLE IF EXISTS tblLocation

SELECT DISTINCT 
	Location_ID,
	City,
	[State],
	Postal_Code,
	Region
INTO tblLocation
FROM tblOrders

--Drop columns that became redundant from main table
ALTER TABLE tblOrders DROP COLUMN 
		Customer_Name, 
		Segment, 
		Sales_Team, 
		Sales_Team_Manager,
        City, 
		[State],
        Postal_Code,
        Region,
        Category,
        Sub_Category,
        Product_Name
