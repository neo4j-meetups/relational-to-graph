// employees, orders, products
LOAD CSV WITH HEADERS FROM "file:/tmp/orders.csv" AS row
MATCH (order:Order {OrderID: row.OrderID})
MATCH (product:Product {ProductID: row.ProductID})
MATCH (employee:Employee {EmployeeID: row.EmployeeID})

MERGE (employee)-[:SOLD]->(order)
MERGE (order)-[:PRODUCT]->(product);


// products, categories, suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
MATCH (product:Product {ProductID: row.ProductID})
MATCH (supplier:Supplier {SupplierID: row.SupplierID})
MATCH (category:Category {CategoryID: row.CategoryID})

MERGE (supplier)-[:SUPPLIES]->(product)
MERGE (product)-[:PART_OF]->(category);

// employees + managers
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MATCH (employee:Employee {EmployeeID: row.EmployeeID})
MATCH (manager:Employee {EmployeeID: row.ReportsTo})
MERGE (employee)-[:REPORTS_TO]->(manager);

// Employees territories
LOAD CSV WITH HEADERS FROM "file:/tmp/employeeterritories.csv" AS row
MATCH (employee:Employee {EmployeeID: row.EmployeeID})
MATCH (territory:Territory {TerritoryID: row.TerritoryID})
MERGE (employee)-[:IN_TERRITORY]->(territory);

// Territories regions
LOAD CSV WITH HEADERS FROM "file:/tmp/territories.csv" AS row
MATCH (region:Region {RegionID: row.RegionID})
MATCH (territory:Territory {TerritoryID: row.TerritoryID})
MERGE (territory)-[:IN_REGION]->(region);
