--1-Overall data insights
SELECT COUNT(*) AS Orders FROM tblOrders 
SELECT DISTINCT(YEAR(Order_Date)) AS OrderYear FROM tblOrders 

SELECT COUNT(*) AS Teams FROM tblSalesTeam
SELECT DISTINCT(Sales_Team_Manager) AS Managers
FROM tblSalesTeam 

SELECT COUNT(*) As Locations FROM tblLocation 
SELECT COUNT(DISTINCT City) As Cities FROM tblLocation 

SELECT COUNT(*) As Customers FROM tblCustomers 
SELECT DISTINCT Segment FROM tblCustomers

SELECT COUNT(*) AS Products FROM tblProduct 
SELECT DISTINCT Category FROM tblProduct
SELECT COUNT(DISTINCT Sub_Category) AS SubCategories FROM tblProduct 
