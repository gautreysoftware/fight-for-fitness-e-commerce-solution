MATCH (c:Customer)-[:PURCHASED]->(o:Order)-[:PRODUCT]->(p:Product)
WITH c, count(p) AS total
MATCH (c)-[:PURCHASED]->(o:Order)-[:PRODUCT]->(p:Product)
WITH c, total,p, count(o) * 1.0 AS orders
MERGE (c)-[rated:RATED]->(p)
ON CREATE SET rated.rating = orders/total
ON MATCH SET rated.rating = orders/total
WITH c.companyName AS company, p.productName AS product, orders, total, rated.rating AS rating
ORDER BY rating DESC
RETURN company, product, orders, total, rating 
LIMIT 10