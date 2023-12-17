--0.4-Table alteration
--Adding primary keys 
ALTER TABLE tblCustomers
ALTER COLUMN Customer_ID char(8) NOT NULL
ALTER TABLE tblCustomers
ADD CONSTRAINT PK_CustID PRIMARY KEY (Customer_ID) 

ALTER TABLE tblLocation
ALTER COLUMN Location_ID varchar(35) NOT NULL
ALTER TABLE tblLocation
ADD CONSTRAINT PK_LocID PRIMARY KEY (Location_ID)

ALTER TABLE tblProduct
ALTER COLUMN Product_ID char(15) NOT NULL
ALTER TABLE tblProduct
ADD CONSTRAINT PK_ProdID PRIMARY KEY (Product_ID)

ALTER TABLE tblSalesTeam
ALTER COLUMN Sales_Rep varchar(30) NOT NULL
ALTER TABLE tblSalesTeam
ADD CONSTRAINT PK_SalesRep PRIMARY KEY (Sales_Rep)

--Adding PK to Orders table and setting Foreign keys
ALTER TABLE tblOrders
ADD OrderSerialID int IDENTITY PRIMARY KEY

ALTER TABLE tblOrders
ADD CONSTRAINT FK_Customer_ID
FOREIGN KEY (Customer_ID)
REFERENCES tblCustomers (Customer_ID)

ALTER TABLE tblOrders
ADD CONSTRAINT FK_Product_ID
FOREIGN KEY (Product_ID)
REFERENCES tblProduct (Product_ID)

ALTER TABLE tblOrders
ADD CONSTRAINT FK_Location_ID
FOREIGN KEY (Location_ID)
REFERENCES tblLocation (Location_ID)

ALTER TABLE tblOrders
ADD CONSTRAINT FK_Sales_Rep
FOREIGN KEY (Sales_Rep)
REFERENCES tblSalesTeam (Sales_Rep)
