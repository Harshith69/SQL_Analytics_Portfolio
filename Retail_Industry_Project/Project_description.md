Project Overview :
This project demonstrates advanced SQL skills applied to retail industry data analysis. It includes complex queries that solve real world business problems like customer segmentation, product performance analysis, inventory optimization, and market basket analysis
-----------------------------------------------------------------------------------------------------------------------------------------
Dataset Description :
The project uses three primary tables representing a typical retail operation

1. Customers: Contains customer demographics and registration information
   - customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    registration_date DATE,
    loyalty_member BOOLEAN)

2. Products: Contains product catalog information
   - products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2),
    weight_kg DECIMAL(10,2),
    supplier_id INT,
    date_added DATE,
    active BOOLEAN)

3. Sales: Contains transaction records
   - sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    store_id INT,
    sale_date TIMESTAMP,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)))

------------------------------------------------------------------------------------------------------------------------------------------
Business Questions Addressed

1. Customer Segmentation Analysis :
Identified top-spending customers (top 10% by revenue) to focus retention efforts and understand high-value customer purchasing patterns.

  Key SQL Techniques:
- Window functions (NTILE)
- Common Table Expressions (CTEs)
- Advanced joins and aggregations

2. Product Performance Analysis :
Calculated month-over-month growth rates for each product category to identify trending and declining products.

  Key SQL Techniques:
- DATE_TRUNC for time period aggregation
- LAG() for comparative analysis
- Percentage growth calculations

3. RFM Analysis (Recency, Frequency, Monetary) :
Segmented customers based on purchasing behavior to enable targeted marketing campaigns.

  Key SQL Techniques:
- Multi-dimensional scoring (R, F, M)
- CASE statements for segment classification
- Complex window functions

4. Basket Analysis :
Identified products frequently purchased together to optimize product placement and bundling strategies.

  Key SQL Techniques:
- Self-joins
- Conditional counting
- HAVING clauses for threshold filtering

5. Inventory Turnover Analysis :
Calculated inventory turnover rates by category to optimize stock levels and purchasing.

  Key SQL Techniques:
- Multi-level aggregations
- Derived metrics (avg_units_sold_per_product)
- Revenue per unit calculations
-----------------------------------------------------------------------------------------------------------------------------------------
Technical Skills Demonstrated

- Advanced SQL Querying: Complex joins, subqueries, CTEs
- Window Functions: Ranking, partitioning, and analytic functions
- Data Aggregation: Multi-dimensional summarization
- Business Intelligence: Translating data insights into business value
- Performance Optimization: Efficient query design for large datasets
