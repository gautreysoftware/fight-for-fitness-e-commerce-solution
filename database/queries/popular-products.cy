MATCH (c:Customer)-[:PURCHASED]->(o:Order)-[:PRODUCT]->(p:Product)
RETURN c.companyName, p.productName, count(o) as orders
ORDER BY orders DESC
LIMIT 5