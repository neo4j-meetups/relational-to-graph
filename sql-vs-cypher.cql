// How are employees organised? Who reports to whom?

// just ids
SELECT e."EmployeeID", e."ReportsTo"
FROM employees AS e
WHERE e."ReportsTo" is not null;

MATCH (e:Employee)<-[:REPORTS_TO]-(sub)
RETURN e.EmployeeID AS manager, sub.EmployeeID AS employee

// big boss
SELECT e."EmployeeID" AS bigBoss
FROM employees AS e
WHERE e."ReportsTo" is null;

MATCH (e:Employee)
WHERE NOT (e)-[:REPORTS_TO]->()
RETURN e.EmployeeID AS bigBoss

// some properties
SELECT e."FirstName", e."LastName", e."Title", manager."FirstName", manager."LastName", manager."Title"
FROM employees AS e
JOIN employees AS manager ON e."ReportsTo" = manager."EmployeeID"
WHERE e."ReportsTo" is not null;

MATCH (e:Employee)<-[:REPORTS_TO]-(sub)
RETURN sub.FirstName, sub.LastName, sub.Title, e.FirstName, e.LastName, e.Title

// all properties
SELECT e.*, manager.*
FROM employees AS e
JOIN employees AS manager ON e."ReportsTo" = manager."EmployeeID"
WHERE e."ReportsTo" is not null;

MATCH (e:Employee)<-[:REPORTS_TO]-(sub)
RETURN e, sub

// number of direct reports
SELECT manager."EmployeeID" AS manager, COUNT(*)
FROM employees AS manager
JOIN employees AS e ON e."ReportsTo" = manager."EmployeeID"
WHERE e."ReportsTo" is not null
GROUP BY manager;

MATCH (e:Employee)<-[:REPORTS_TO]-(report)
WITH e.EmployeeID AS employee, COLLECT(report) AS reports
RETURN employee, LENGTH(reports) AS numberOfReports

// number of direct reports (including none)
SELECT manager."EmployeeID" AS manager, COUNT(e."EmployeeID")
FROM employees AS manager
LEFT JOIN employees AS e ON e."ReportsTo" = manager."EmployeeID"
GROUP BY manager;

MATCH (e:Employee)
OPTIONAL MATCH (e)<-[rel:REPORTS_TO]-(report)
RETURN e.EmployeeID AS employee, COUNT(rel) AS reports

// transitive reports

WITH RECURSIVE recursive_employees("EmployeeID", "ReportsTo") AS (
        SELECT e."EmployeeID", e."ReportsTo"
        FROM employees e
      UNION ALL
        SELECT e."EmployeeID", e."ReportsTo"
        FROM employees e, recursive_employees re
        WHERE e."EmployeeID" = re."ReportsTo"
)
SELECT re."ReportsTo", COUNT(*) AS count
FROM recursive_employees AS re
WHERE re."ReportsTo" IS NOT NULL
GROUP BY re."ReportsTo";

MATCH (e:Employee)
OPTIONAL MATCH (e)<-[rel:REPORTS_TO*]-(report)
RETURN e.EmployeeID AS employee, COUNT(rel) AS reports

// Find all the sales made by someone directly or indirectly

MATCH (e:Employee)
OPTIONAL MATCH (e)<-[:REPORTS_TO*0..]-(sub)-[:SOLD]->()
RETURN e.EmployeeID, [x IN COLLECT(DISTINCT sub.EmployeeID) WHERE x <> e.EmployeeID] AS reports, COUNT(*) AS totalOrders
ORDER BY totalOrders DESC

// Which regions does a supplier supply to?

MATCH (supplier:Supplier {SupplierID: "19"})-[:SUPPLIES]->
(product)<-[:PRODUCT]-(order)<-[:SOLD]-
(employee)-[:IN_TERRITORY]->(territory)-[:IN_REGION]->
(region)
RETURN region.RegionDescription, COUNT(*) AS orders
