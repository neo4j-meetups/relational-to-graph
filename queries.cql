// How are employees organised? Who reports to whom?

MATCH (e:Employee)<-[:REPORTS_TO]-(sub)
RETURN e.EmployeeID AS manager,
sub.EmployeeID AS employee

MATCH (e:Employee)
WHERE NOT (e)-[:REPORTS_TO]->()
RETURN e.EmployeeID AS bigBoss

MATCH (e:Employee)
OPTIONAL MATCH (e)<-[:REPORTS_TO*]-(report)
WITH e.EmployeeID AS employee, COLLECT(report) AS reports
RETURN employee, SIZE(reports) AS numberOfReports

// Find all the sales made by someone directly or indirectly

MATCH (e:Employee)
OPTIONAL MATCH (e)<-[:REPORTS_TO*0..]-(sub)-[:SOLD]->()
RETURN e.EmployeeID, [x IN COLLECT(DISTINCT sub.EmployeeID) WHERE x <> e.EmployeeID] AS reports, COUNT(*) AS totalOrders
ORDER BY totalOrders DESC

// Which regions does a supplier supply to?

MATCH (supplier:Supplier {SupplierID: "19"})-[:SUPPLIES]->
(product)<-[:INCLUDES]-(order)<-[:SOLD]-
(employee)-[:REPRESENTS]->(territory)-[:IS_IN]->
(region)
RETURN region.RegionDescription, COUNT(*) AS orders
