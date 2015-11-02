// customers
LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
WITH row WHERE not row.Fax is null
MERGE (c:Customer {CustomerID: row.CustomerID})
ON CREATE SET c.CompanyName =  row.CompanyName,
              c.Fax =  row.Fax,
              c.Phone = row.Phone;

LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
WITH row WHERE row.Fax  is null
MERGE (c:Customer {CustomerID: row.CustomerID})
ON CREATE SET c.CompanyName =  row.CompanyName,
              c.Phone = row.Phone;

// products
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
MERGE (p:Product {ProductID: row.ProductID})
ON CREATE SET p.ProductName = row.ProductName, p.UnitPrice = row.UnitPrice;

// suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/suppliers.csv" AS row
MERGE (s:Supplier {SupplierID: row.SupplierID})
ON CREATE SET s.CompanyName = row.CompanyName;

// employees
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MERGE (e:Employee {EmployeeID:row.EmployeeID})
ON CREATE SET e.FirstName = row.FirstName, e.LastName = row.LastName, e.Title = row.Title;

// categories
LOAD CSV WITH HEADERS FROM "file:/tmp/categories.csv" AS row
MERGE (c:Category {CategoryID: row.CategoryID})
ON CREATE SET c.CategoryName = row.CategoryName, c.Description = row.Description;

// regions
LOAD CSV WITH HEADERS FROM "file:/tmp/regions.csv" AS row
MERGE (r:Region {RegionID: row.RegionID})
ON CREATE SET r.RegionDescription = row.RegionDescription;

// orders
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MERGE (o:Order {OrderID: row.OrderID})
ON CREATE SET o.ShipName = row.ShipName,
              o.OrderDate = row.OrderDate;

// territories
LOAD CSV WITH HEADERS FROM "file:/tmp/territories.csv" AS row
MERGE (t:Territory {TerritoryID: row.TerritoryID})
ON CREATE SET t.TerritoryDescription = row.TerritoryDescription;

// customers
LOAD CSV WITH HEADERS FROM "file:/tmp/shippers.csv" AS row
MERGE (s:Shipper {ShipperID: row.ShipperID})
ON CREATE SET s.CompanyName = row.CompanyName, s.Phone = row.Phone;
