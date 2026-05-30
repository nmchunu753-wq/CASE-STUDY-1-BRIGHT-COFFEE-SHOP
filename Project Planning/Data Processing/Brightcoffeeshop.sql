
==========================================================================================================================================
---Understanding the dataset
==========================================================================================================================================

-------------------------------------------------------------------------------------------------------------------------------------------
---Checking if the table was uploaded successsfully.
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM `workspace`.`default`.`BrightCoffeeShops`; 

-------------------------------------------------------------------------------------------------------------------------------------------
---The number of sales
---149116 
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(*) AS sales
FROM `workspace`.`default`.`BrightCoffeeShops`;

-------------------------------------------------------------------------------------------------------------------------------------------
--First and last date for data collection.
---Start: 1 January 2023
--- 30 June 2023
--- Makes it 6 months.
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT MIN(transaction_date) AS startdate,
       MAX(transaction_date) AS enddate
FROM `workspace`.`default`.`BrightCoffeeShops`;

-------------------------------------------------------------------------------------------------------------------------------------------
--- Checking the names of available stores
--- Lower Manhattan, Hell's Kitchen and Astoria.
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT store_location
FROM `workspace`.`default`.`BrightCoffeeShops`;


-------------------------------------------------------------------------------------------------------------------------------------------
---Number of different products sold in the coffee shop:
--- 9 categories
--- 29 types
--- 80 product details.
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(DISTINCT product_category) AS product_category,
    COUNT(DISTINCT product_type) AS product_type,
     COUNT (DISTINCT product_detail) AS product_detail
FROM `workspace`.`default`.`BrightCoffeeShops`;

---------------------------------------------------------------------------------------------------------------------------------------------
--- Total Revenue From January to June.
---R698812.3299999288
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    SUM(transaction_qty * unit_price) AS total_revenue_Jan_to_June
FROM `workspace`.`default`.`BrightCoffeeShops`
WHERE transaction_date BETWEEN '2023-01-01' AND '2023-06-30';

---------------------------------------------------------------------------------------------------------------------------------------------
--Total sales and revenue per month for January to June.
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
      CASE
      WHEN  transaction_date  BETWEEN '2023-01-01' AND '2023-01-31' THEN 'JAN'
      WHEN transaction_date BETWEEN '2023-02-01' AND '2023-02-28' THEN 'FEB'
      WHEN transaction_date BETWEEN '2023-03-01' AND '2023-03-31' THEN 'MAR'
      WHEN transaction_date BETWEEN '2023-04-01' AND '2023-04-30' THEN 'APR'
      WHEN transaction_date BETWEEN '2023-05-01' AND '2023-05-31' THEN 'MAY'
      WHEN transaction_date BETWEEN '2023-06-01' AND '2023-06-30' THEN 'JUNE'
      END AS sale_month,
      COUNT(*) AS total_sales, 
      SUM(transaction_qty * unit_price) AS total_revenue_per_month
FROM `workspace`.`default`.`BrightCoffeeShops`
GROUP BY sale_month
ORDER BY sale_month DESC ;

---------------------------------------------------------------------------------------------------------------------------------------------
---Total sales and revenue for each store location.
--- Hells kitchen is leading with 50735 sales  
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    store_location,
    COUNT(*) AS total_sales, 
    SUM(transaction_qty * unit_price) AS total_revenue_per_coffee_shop
FROM `workspace`.`default`.`BrightCoffeeShops`
GROUP BY store_location;

-------------------------------------------------------------------------------------------------------------------------------------------
---Checking the 3 most cheap product categories with their prices.
---Flavours, Coffee, tea
------------------------------------------------------------------------------------------------------------------------------------------
SELECT product_category,
        MIN(unit_price) AS cheapest
FROM `workspace`.`default`.`BrightCoffeeShops`  -- pick ONE table and stick with it
GROUP BY product_category
ORDER BY cheapest ASC  --  to actually get cheapest first
LIMIT 3;

-------------------------------------------------------------------------------------------------------------------------------------------
---Checking the 3 most expensive product categories with their prices.
---Coffee beans, Branded, packaged chocolate.
------------------------------------------------------------------------------------------------------------------------------------------
SELECT product_category,
        MAX(unit_price) AS expensive
FROM `workspace`.`default`.`BrightCoffeeShops`  
GROUP BY product_category
ORDER BY expensive DESC  --  to get most expensive first
LIMIT 3;

==========================================================================================================================================
---The final query
---Has all the necessary calculations and information to be able to gather insigts and recommendations.
==========================================================================================================================================

     SELECT 

-- ============================================================
-- DATE DIMENSIONS
-- ============================================================
  transaction_date,
  DAYOFMONTH(transaction_date)                             AS day_of_month,
  DATE_FORMAT(transaction_date, 'EEEE')                   AS day_name,

  CASE
    WHEN DATE_FORMAT(transaction_date, 'EEEE') 
         IN ('Saturday', 'Sunday')                        THEN 'Weekend'
    ELSE 'Weekday'
  END                                                     AS day_classification,

  MONTHNAME(transaction_date)                             AS month_name,
  MONTH(transaction_date)                                 AS month_number,
  QUARTER(transaction_date)                               AS quarter,

-- ============================================================
-- TIME DIMENSIONS
-- ============================================================
  DATE_FORMAT(transaction_time, 'HH:mm:ss')               AS purchase_time,

  CASE
    WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') 
         BETWEEN '05:00:00' AND '08:59:59'                THEN 'Morning Rush Hour'
    WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') 
         BETWEEN '09:00:00' AND '11:59:59'                THEN 'Mid Morning'
    WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') 
         BETWEEN '12:00:00' AND '15:59:59'                THEN 'Afternoon'
    WHEN DATE_FORMAT(transaction_time, 'HH:mm:ss') 
         BETWEEN '16:00:00' AND '18:00:00'                THEN 'Evening Rush Hour'
    ELSE 'Night'
  END                                                     AS time_classification,

-- ============================================================
-- STORE
-- ============================================================
  store_location,

-- ============================================================
-- PRODUCT DIMENSIONS
-- ============================================================
  product_category,
  product_detail,

-- ============================================================
-- COUNT METRICS
-- ============================================================
  COUNT(DISTINCT transaction_id)                          AS total_transactions,
  COUNT(DISTINCT store_id)                                AS total_stores,
  COUNT(DISTINCT product_id)                              AS total_products,
  SUM(transaction_qty)                                    AS total_units_sold,

-- ============================================================
-- REVENUE METRICS
-- ============================================================
  SUM(transaction_qty * unit_price)                       AS total_revenue,
  MIN(unit_price)                                         AS min_unit_price,
  MAX(unit_price)                                         AS max_unit_price,
  AVG(unit_price)                                         AS avg_unit_price,

-- ============================================================
-- AVERAGE METRICS
-- ============================================================
  AVG(transaction_qty * unit_price)                       AS avg_revenue_per_transaction,
  SUM(transaction_qty * unit_price) 
    / NULLIF(COUNT(DISTINCT transaction_id), 0)           AS avg_spend_per_transaction,
  SUM(transaction_qty * unit_price) 
    / NULLIF(SUM(transaction_qty), 0)                     AS avg_revenue_per_unit,
  AVG(transaction_qty)                                    AS avg_qty_per_transaction,

-- ============================================================
-- SPEND BUCKET
-- ============================================================
  CASE
    WHEN SUM(transaction_qty * unit_price) 
         / NULLIF(COUNT(DISTINCT transaction_id), 0) <= 5  THEN 'Minimal'
    WHEN SUM(transaction_qty * unit_price) 
         / NULLIF(COUNT(DISTINCT transaction_id), 0) <= 15 THEN 'Moderate'
    WHEN SUM(transaction_qty * unit_price) 
         / NULLIF(COUNT(DISTINCT transaction_id), 0) <= 30 THEN 'Substantial'
    ELSE 'Premium'
  END                                                     AS spend_bucket

FROM `workspace`.`default`.`BrightCoffeeShops`

GROUP BY
  transaction_date,
  DAYOFMONTH(transaction_date),
  DATE_FORMAT(transaction_date, 'EEEE'),
  day_classification,
  MONTHNAME(transaction_date),
  MONTH(transaction_date),
  QUARTER(transaction_date),
  DATE_FORMAT(transaction_time, 'HH:mm:ss'),
  time_classification,
  store_location,
  product_category,
  product_detail

ORDER BY
  transaction_date,
  MONTH(transaction_date),
  store_location,
  total_revenue DESC;
