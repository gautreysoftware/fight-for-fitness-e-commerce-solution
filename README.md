# FightForFitness E-commerce Solution


## Scenario:

FightForFitness Limited require an e-commerce solution developing which provides detailed analysis of customer trends, buying habits, and other insights to help gain the competitive edge over their rivals.  To accompany their online shop they would like a recommendation engine and customer feedback analysis dashboard so they can keep up with customer needs.

They will only provide clothing for the time being, but look to extend their brand to include:
    - personalised fitness clothing
    - online fitness classes
    - fitness equipment
    - personalised fitness programs
    - personalised meal plans

## Use Cases:

Along with the standard CRUD operations, they have the following requirements:
    1. What orders has a customer placed?
    2. What products has a customer reviewed?
    3. What is the highest rated product this month?
    4. Provide the two similar products a customer hasn't bought which other customers have.  Provide three different products in order of popularity.
    5. Which customers are the highest spending?  For loyalty rewards.

## Entities:

    User: Represents a user of the e-commerce website.
        Properties: UserID, Username, Email, Password, ShippingAddress, BillingAddress, etc.

    Product: Represents a product available for sale on the e-commerce platform.
        Properties: ProductID, Name, Description, Price, Category, Brand, etc.

    Order: Represents an order placed by a user.
        Properties: OrderID, UserID (reference to User), OrderDate, TotalPrice, Status, etc.

    Payment: Represents a payment made for an order.
        Properties: PaymentID, OrderID (reference to Order), PaymentMethod, Amount, TransactionDate, Status, etc.

    Review: Represents a review written by a user for a product.
        Properties: ReviewID, UserID (reference to User), ProductID (reference to Product), Rating, Comment, Date, etc.

## Relationships:

    PURCHASED: Relationship between a user and a product indicating a purchase.
        Properties: Quantity, PurchaseDate, etc.

    CONTAINS: Relationship between an order and the products it contains.
        Properties: Quantity, UnitPrice, TotalPrice, etc.

    USES: Relationship between an order and the payment method used.
        Properties: PaymentID (reference to Payment), PaymentMethod, etc.

    WROTE: Relationship between a user and a review.
        Properties: Rating, Comment, Date, etc.

## Notes

In this graph data model:

Nodes represent entities such as users, products, orders, payments, and reviews.
Relationships represent interactions between entities, such as purchases, order contents, payment methods, and product reviews.
Properties associated with nodes and relationships provide additional metadata or attributes about the entities or interactions.

Using a graph database with this data model, you could efficiently query and analyze relationships between users, products, orders, payments, and reviews within the e-commerce platform, enabling features such as personalized recommendations, order tracking, and customer feedback analysis.