LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
CREATE (order:Order {OrderID: row.OrderID, ShipName: row.ShipName})

WITH *
MATCH (product:Product {ProductID: row.ProductID})
MATCH (employee:Employee {EmployeeID: row.EmployeeID})

MERGE (employee)-[:SOLD]->(order)
MERGE (order)-[:PRODUCT]->(product);


LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
MATCH (product:Product {ProductID: row.ProductID})
MATCH (supplier:Supplier {SupplierID: row.SupplierID})
MATCH (category:Category {CategoryID: row.CategoryID})

MERGE (supplier)-[:SUPPLIES]->(product)
MERGE (product)-[:PART_OF]->(category);

LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MATCH (employee:Employee {EmployeeID: row.EmployeeID})
MATCH (manager:Employee {EmployeeID: row.ReportsTo})
MERGE (employee)-[:REPORTS_TO]->(manager);
