// customers
LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
WITH row WHERE not row.Fax is null
MERGE (:Customer {CompanyName: row.CompanyName, CustomerID: row.CustomerID, Fax: row.Fax, Phone: row.Phone});

LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
WITH row WHERE row.Fax  is null
MERGE (:Customer {CompanyName: row.CompanyName, CustomerID: row.CustomerID, Phone: row.Phone});

LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
MERGE (c:Customer {CompanyName: row.CompanyName, CustomerID: row.CustomerID,  Phone: row.Phone})
SET c.Fax = row.Fax;


// products
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
MERGE (:Product {ProductName: row.ProductName, ProductID: row.ProductID, UnitPrice: row.UnitPrice});

// suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/suppliers.csv" AS row
MERGE (:Supplier {CompanyName: row.CompanyName, SupplierID: row.SupplierID});

// employees
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MERGE (:Employee {EmployeeID:row.EmployeeID,  FirstName: row.FirstName, LastName: row.LastName, Title: row.Title});

// categories
LOAD CSV WITH HEADERS FROM "file:/tmp/categories.csv" AS row
MERGE (:Category {CategoryID: row.CategoryID, CategoryName: row.CategoryName, Description: row.Description});

// regions
LOAD CSV WITH HEADERS FROM "file:/tmp/regions.csv" AS row
MERGE (:Region {RegionID: row.RegionID, RegionDescription: row.RegionDescription});

// orders
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MERGE (:Order {OrderID: row.OrderID, ShipName: row.ShipName});

// territories
LOAD CSV WITH HEADERS FROM "file:/tmp/territories.csv" AS row
MERGE (:Territory {TerritoryID: row.TerritoryID, TerritoryDescription: row.TerritoryDescription});
