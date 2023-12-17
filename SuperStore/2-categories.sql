--2-Categorize customers: 
--0-5,000 Silver, 5,000-15,000 Gold, >15,000 Diamond
--Using CTE to create column of Total amount spent by customer
CREATE OR ALTER VIEW vwCustCategories AS
WITH CTE_Spent(Cust, Spent)
AS(
	SELECT c.Customer_Name, SUM(o.Sales*o.Quantity)
	FROM tblOrders AS o
	LEFT JOIN tblCustomers AS c
	ON o.Customer_ID=c.Customer_ID
	GROUP BY c.Customer_Name
) --in CASE statement implemented business logic for customer categorization
SELECT 
	Cust, 
	Spent,
	CASE
		WHEN Spent > 15000 THEN 'Diamond' 
		WHEN Spent < 5000  THEN 'Silver' 
		ELSE 'Gold'
	END AS CustCategory
FROM CTE_Spent

SELECT * FROM vwCustCategories --all 793 customer has assigned category

--Get count, average and total spent by category
CREATE OR ALTER VIEW vwCategoryDetails AS
SELECT 
	CustCategory, 
	SUM(Spent) AS TotalSpent, 
	AVG(Spent) AS AvgSpent, 
	COUNT(Spent) AS CustCount
FROM vwCustCategories
GROUP BY CustCategory

SELECT 
	CustCategory AS Category,
	FORMAT(TotalSpent, '#,0') AS SpentTotal,
	FORMAT(AvgSpent, '#,0') AS SpentAvg,
	CustCount AS Customers
FROM vwCategoryDetails
