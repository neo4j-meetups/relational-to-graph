// customers
LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
MERGE (c:Customer {CustomerID: row.CustomerID})
SET c.CompanyName = row.CompanyName, c.Fax = row.Fax, c.Phone = row.Phone;

// products
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
MERGE (p:Product {ProductID: row.ProductID})
SET p.ProductName = row.ProductName, p.UnitPrice = row.UnitPrice;

// suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/suppliers.csv" AS row
MERGE (s:Supplier {SupplierID: row.SupplierID})
SET s.CompanyName = row.CompanyName;

// employees
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MERGE (e:Employee {EmployeeID:row.EmployeeID})
SET e.FirstName = row.FirstName, e.LastName = row.LastName, e.Title = row.Title;

// categories
LOAD CSV WITH HEADERS FROM "file:/tmp/categories.csv" AS row
MERGE (c:Category {CategoryID: row.CategoryID})
SET c.CategoryName = row.CategoryName, c.Description = row.Description;

// regions
LOAD CSV WITH HEADERS FROM "file:/tmp/regions.csv" AS row
MERGE (r:Region {RegionID: row.RegionID})
SET r.RegionDescription = row.RegionDescription;

// orders
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MERGE (o:Order {OrderID: row.OrderID})
SET o.ShipName = row.ShipName;

// territories
LOAD CSV WITH HEADERS FROM "file:/tmp/territories.csv" AS row
MERGE (t:Territory {TerritoryID: row.TerritoryID})
SET t.TerritoryDescription = row.TerritoryDescription;
