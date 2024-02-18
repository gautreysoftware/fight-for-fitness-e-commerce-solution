MATCH (me:Customer)-[r:RATED]->(p:Product)
WHERE me.customerID = 'ANTON'
RETURN p.productName, r.rating limit 10

MATCH (c1:Customer {customerID:'ANTON'})-[r1:RATED]->(p:Product)<-[r2:RATED]-(c2:Customer)
RETURN c1.customerID, c2.customerID, p.productName, r1.rating, r2.rating,
CASE WHEN r1.rating-r2.rating < 0 THEN -(r1.rating-r2.rating) ELSE r1.rating-r2.rating END AS difference
ORDER BY difference ASC
LIMIT 15

MATCH (c1:Customer)-[r1:RATED]->(p:Product)<-[r2:RATED]-(c2:Customer)
WITH
    SUM(r1.rating*r2.rating) AS dot_product,
    SQRT( REDUCE(x=0.0, a IN COLLECT(r1.rating) | x + a^2) ) AS r1_length,
    SQRT( REDUCE(y=0.0, b IN COLLECT(r2.rating) | y + b^2) ) AS r2_length,
    c1,c2
MERGE (c1)-[s:SIMILARITY]-(c2)
SET s.similarity = dot_product / (r1_length * r2_length)

MATCH (me:Customer)-[r:SIMILARITY]->(them)
WHERE me.customerID='ANTON'
RETURN me.companyName, them.companyName, r.similarity
ORDER BY r.similarity DESC 
LIMIT 10

WITH 1 AS neighbours
MATCH (me:Customer)-[:SIMILARITY]->(c:Customer)-[r:RATED]->(p:Product)
WHERE me.customerID = 'ANTON' and NOT ( (me)-[:RATED|PRODUCT|ORDER*1..2]->(p:Product) )
WITH p, COLLECT(r.rating)[0..neighbours] AS ratings, collect(c.companyName)[0..neighbours] AS customers
WITH p, customers, REDUCE(s=0,i in ratings | s+i) / LENGTH(ratings) AS recommendation
ORDER BY recommendation DESC
RETURN p.productName, customers, recommendation 
LIMIT 10