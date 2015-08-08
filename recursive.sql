id1 = EmployeeID
id2 =   ReportsTo

with recursive tr(id1, id2, level) as (
      select t.id1, t.id2, 1 as level
      from t union all
      select t.id1, tr.id2, tr.level + 1
      from t join
           tr
           on t.id2 = tr.id1
     )
select *
from (select tr.*,
             max(level) over (partition by id1) as maxlevel
      from tr
     ) tr
where level = maxlevel


with recursive employeesr("EmployeeID", "ReportsTo", level) as (
      select employees."EmployeeID", employees."ReportsTo", 1 as level
      from employees
      union all
      select employees."EmployeeID", employeesr."ReportsTo", employeesr.level + 1
      from employees join
           employeesr
           on employees."ReportsTo" = employeesr."EmployeeID"
     )
select *
from (select employeesr.*,
             max(level) over (partition by "EmployeeID") as maxlevel
      from employeesr
     ) employeesr
where level = maxlevel



// SQL
WITH RECURSIVE chain(from_id, to_id) AS (
  SELECT NULL, 'vc2'
  UNION
  SELECT c.to_id, t."ID2"
  FROM chain c
  LEFT OUTER JOIN Table1 t ON (t."ID1" = to_id)
  WHERE c.to_id IS NOT NULL
)
SELECT from_id FROM chain WHERE to_id IS NULL;

// cypher
MATCH (e:Employee)
OPTIONAL MATCH (e)<-[rel:REPORTS_TO*]-(report)
RETURN e.EmployeeID AS employee, COUNT(rel) AS reports


WITH RECURSIVE chain(from_id, to_id) AS (
  SELECT NULL, 'vc2'
  UNION
  SELECT c.to_id, t."id2"
  FROM chain c
  LEFT OUTER JOIN t ON (t."id1" = to_id)
  WHERE c.to_id IS NOT NULL
)
SELECT from_id FROM chain WHERE to_id IS NULL;

WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t;

WITH RECURSIVE er("ReportedToBy", "EmployeeID") AS (
  SELECT employees."ReportsTo", employees."EmployeeID"
  FROM employees

  UNION

  SELECT er."EmployeeID", er."ReportedToBy"
  FROM er
  LEFT OUTER JOIN employees ON er."ReportedToBy" = employees."EmployeeID"
  WHERE er."EmployeeID" IS NOT NULL
)
SELECT er."EmployeeID", COUNT(er."ReportedToBy") AS count
FROM er
WHERE er."EmployeeID" IS NOT NULL
GROUP BY er."EmployeeID"
ORDER BY count DESC;

//
WITH RECURSIVE er("EmployeeID", "ReportsTo") AS (
  SELECT employees."EmployeeID", employees."ReportsTo"
  FROM employees

  UNION

  SELECT er."ReportsTo", employees."ReportsTo"
  FROM er
  JOIN employees ON er."ReportsTo" = employees."EmployeeID"
  WHERE er."ReportsTo" IS NOT NULL
)
SELECT *
FROM er;


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
