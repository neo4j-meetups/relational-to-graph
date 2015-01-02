# Create customers
LOAD CSV WITH HEADERS FROM "file:/tmp/customers.csv" AS row
CREATE (:Customer {CompanyName: row.CompanyName, CustomerID: row.CustomerID, Fax: row.Fax, Phone: row.Phone});

# Create products
LOAD CSV WITH HEADERS FROM "file:/tmp/products.csv" AS row
CREATE (:Product {ProductName: row.ProductName, ProductID: row.ProductID, UnitPrice: row.UnitPrice});

# Create suppliers
LOAD CSV WITH HEADERS FROM "file:/tmp/suppliers.csv" AS row
CREATE (:Supplier {CompanyName: row.CompanyName, SupplierID: row.SupplierID});

# Create employees
LOAD CSV WITH HEADERS FROM "file:/tmp/employees.csv" AS row
CREATE (:Employee {EmployeeID:row.EmployeeID,  FirstName: row.FirstName, LastName: row.LastName, Title: row.Title});

# Create categories
LOAD CSV WITH HEADERS FROM "file:/tmp/categories.csv" AS row
CREATE (:Category {CategoryID: row.CategoryID, CategoryName: row.CategoryName, Description: row.Description});
