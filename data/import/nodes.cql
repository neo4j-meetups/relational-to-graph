// customers
LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
CREATE (:Customer {CompanyName: row.CompanyName, CustomerID: row.CustomerID, Fax: row.Fax, Phone: row.Phone});

// products
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
CREATE (:Product {ProductName: row.ProductName, ProductID: row.ProductID, UnitPrice: row.UnitPrice});

// suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/suppliers.csv" AS row
CREATE (:Supplier {CompanyName: row.CompanyName, SupplierID: row.SupplierID});

// employees
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
CREATE (:Employee {EmployeeID:row.EmployeeID,  FirstName: row.FirstName, LastName: row.LastName, Title: row.Title});

// categories
LOAD CSV WITH HEADERS FROM "file:/tmp/categories.csv" AS row
CREATE (:Category {CategoryID: row.CategoryID, CategoryName: row.CategoryName, Description: row.Description});

// regions
LOAD CSV WITH HEADERS FROM "file:/tmp/regions.csv" AS row
CREATE (:Region {RegionID: row.RegionID, RegionDescription: row.RegionDescription});

// orders
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
CREATE (:Order {OrderID: row.OrderID, ShipName: row.ShipName});

// territories
LOAD CSV WITH HEADERS FROM "file:/tmp/territories.csv" AS row
CREATE (:Territory {TerritoryID: row.TerritoryID, TerritoryDescription: row.TerritoryDescription});
