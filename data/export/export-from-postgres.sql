COPY (SELECT * FROM customers) TO '/tmp/customers.csv' WITH CSV header;
COPY (SELECT * FROM suppliers) TO '/tmp/suppliers.csv' WITH CSV header;
COPY (SELECT * FROM products)  TO '/tmp/products.csv' WITH CSV header;
COPY (SELECT * FROM employees) TO '/tmp/employees.csv' WITH CSV header;
COPY (SELECT * FROM categories) TO '/tmp/categories.csv' WITH CSV header;
COPY (SELECT * FROM region) TO '/tmp/regions.csv' WITH CSV header;
COPY (SELECT * FROM territories) TO '/tmp/territories.csv' WITH CSV header;
COPY (SELECT * FROM employeeterritories) TO '/tmp/employeeterritories.csv' WITH CSV header;
COPY (SELECT * FROM shippers) TO '/tmp/shippers.csv' WITH CSV header;
COPY (SELECT * FROM orders
      LEFT OUTER JOIN order_details ON order_details."OrderID" = orders."OrderID")
TO '/tmp/orders.csv' WITH CSV header;
