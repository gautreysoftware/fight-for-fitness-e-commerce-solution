CREATE INDEX IF NOT EXISTS FOR (p:Product) ON (p.productID);
CREATE INDEX IF NOT EXISTS FOR (p:Product) ON (p.productName);
CREATE INDEX IF NOT EXISTS FOR (c:Category) ON (c.categoryID);
CREATE INDEX IF NOT EXISTS FOR (e:Employee) ON (e.employeeID);
CREATE INDEX IF NOT EXISTS FOR (s:Supplier) ON (s.supplierID);
CREATE INDEX IF NOT EXISTS FOR (c:Customer) ON (c.customerID);
CREATE INDEX IF NOT EXISTS FOR (c:Customer) ON (c.customerName);
CREATE CONSTRAINT IF NOT EXISTS FOR (o:Order) REQUIRE o.orderID IS UNIQUE;

// Create customers
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/customers.csv" AS row
CREATE (:Customer {companyName: row.companyName, customerID: row.customerID, fax: row.fax, phone: row.phone});

// Create products
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/products.csv" AS row
CREATE (:Product {productName: row.productName, productID: row.productID, unitPrice: toFloat(row.UnitPrice)});

// Create suppliers
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/suppliers.csv" AS row
CREATE (:Supplier {companyName: row.companyName, supplierID: row.supplierID});

// Create employees
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/employees.csv" AS row
CREATE (:Employee {employeeID:row.employeeID,  firstName: row.firstName, lastName: row.lastName, title: row.title});

// Create categories
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/categories.csv" AS row
CREATE (:Category {categoryID: row.categoryID, categoryName: row.categoryName, description: row.description});

// Create Orders
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/orders.csv" AS row
MERGE (o:Order {orderID: row.orderID}) ON CREATE SET o.shipName =  row.shipName;

// Relate orders to products
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/order-details.csv" AS row
MATCH (o:Order {orderID: row.orderID})
MATCH (product:Product {productID: row.productID})
MERGE (o)-[pu:PRODUCT]->(product)
ON CREATE SET pu.unitPrice = toFloat(row.unitPrice), pu.quantity = toFloat(row.quantity);

// Relate Orders to Employees
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/orders.csv" AS row
MATCH (o:Order {orderID: row.orderID})
MATCH (employee:Employee {employeeID: row.employeeID})
MERGE (employee)-[:SOLD]->(o);

// Relate customers to orders
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/orders.csv" AS row
MATCH (o:Order {orderID: row.orderID})
MATCH (customer:Customer {customerID: row.customerID})
MERGE (customer)-[:PURCHASED]->(o);

// Relate Products to suppliers
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/products.csv" AS row
MATCH (product:Product {productID: row.productID})
MATCH (supplier:Supplier {supplierID: row.supplierID})
MERGE (supplier)-[:SUPPLIES]->(product);

// Relate Products to Categories
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/products.csv" AS row
MATCH (product:Product {productID: row.productID})
MATCH (category:Category {categoryID: row.categoryID})
MERGE (product)-[:PART_OF]->(category);

// Relate employees to managers
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/employees.csv" AS row
MATCH (employee:Employee {employeeID: row.employeeID})
MATCH (manager:Employee {employeeID: row.reportsTo})
MERGE (employee)-[:REPORTS_TO]->(manager);

// Add unit price
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/adam-cowley/northwind-neo4j/master/data/order-details.csv" AS row
MATCH (o:Order {orderID: row.orderID})
MATCH (product:Product {productID: row.productID})
MERGE (o)-[pu:PRODUCT]->(product)
ON CREATE SET pu.unitPrice = toFloat(row.unitPrice), pu.quantity = toFloat(row.quantity);