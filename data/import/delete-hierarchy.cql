// An example of how you might go about deleting the hierarchy if
// an employee leaves

LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
MERGE (e:Employee {EmployeeID:row.EmployeeID})
SET e.FirstName = row.FirstName,
e.LastName = row.LastName,
e.Title = row.Title

WITH e, row

MATCH (e)-[r:REPORTS_TO]-()
WHERE row.IsExistingEmployee = "False"
DELETE r
