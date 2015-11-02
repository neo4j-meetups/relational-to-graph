// employees, orders, products
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MATCH (order:Order {OrderID: row.OrderID})
MATCH (product:Product {ProductID: row.ProductID})
MATCH (employee:Employee {EmployeeID: row.EmployeeID})

MERGE (employee)-[:SOLD]->(order)
MERGE (order)-[:INCLUDES {UnitPrice: tofloat(row.UnitPrice),
                          Discount: tofloat(row.Discount),
                          Quantity: toint(row.Quantity)}]->(product);

// customers -> orders
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MATCH (order:Order {OrderID: row.OrderID})
MATCH (customer:Customer {CustomerID: row.CustomerID})
MERGE (customer)-[:ORDERED]->(order);

// products, categories, suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
MATCH (product:Product {ProductID: row.ProductID})
MATCH (supplier:Supplier {SupplierID: row.SupplierID})
MATCH (category:Category {CategoryID: row.CategoryID})

MERGE (supplier)-[:SUPPLIES]->(product)
MERGE (product)-[:CATEGORY]->(category);

// employees + managers
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MATCH (employee:Employee {EmployeeID: row.EmployeeID})
MATCH (manager:Employee {EmployeeID: row.ReportsTo})
MERGE (employee)-[:REPORTS_TO]->(manager);

// Employees territories
LOAD CSV WITH HEADERS FROM "file:/tmp/employeeterritories.csv" AS row
MATCH (employee:Employee {EmployeeID: row.EmployeeID})
MATCH (territory:Territory {TerritoryID: row.TerritoryID})
MERGE (employee)-[:REPRESENTS]->(territory);

// Territories regions
LOAD CSV WITH HEADERS FROM "file:/tmp/territories.csv" AS row
MATCH (region:Region {RegionID: row.RegionID})
MATCH (territory:Territory {TerritoryID: row.TerritoryID})
MERGE (territory)-[:IS_IN]->(region);

// Shippers -> orders
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MATCH (order:Order {OrderID: row.OrderID})
MATCH (shipper:Shipper {ShipperID: row.ShipVia})

MERGE (shipper)-[:SHIPPED]->(order);
