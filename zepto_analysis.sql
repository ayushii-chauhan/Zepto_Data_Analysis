-- Zepto Inventory Analysis

USE zepto_project;

-- 1. CREATE TABLE
CREATE TABLE IF NOT EXISTS zepto_data (
    sku_id INT IDENTITY(1,1) PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INT,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INT,
    outOfStock VARCHAR(10),
    quantity INT
);

-- LOAD CSV DATA

-- ADD STOCK FLAG COLUMN 

ALTER TABLE zepto_data ADD outOfStock_bit BIT;
UPDATE zepto_data
SET outOfStock_bit =
    CASE
        WHEN LOWER(outOfStock) = 'true' THEN 1
        WHEN LOWER(outOfStock) = 'false' THEN 0
        ELSE NULL
    END;

-- =====================================================
-- DATA QUALITY CHECKS
-- =====================================================

-- Total rows
SELECT COUNT(*) as total_skus FROM zepto_data;

-- Null checks
SELECT * FROM zepto_data
    WHERE Category IS NULL
    OR name IS NULL
    OR mrp IS NULL
    OR discountPercent IS NULL
    OR availableQuantity IS NULL
    OR discountedSellingPrice IS NULL
    OR weightInGms IS NULL
    OR outOfStock IS NULL
    OR quantity IS NULL;

-- Duplicate products
SELECT name, 
    COUNT(*) AS duplicate_count
    FROM zepto_data 
    GROUP BY name 
    HAVING COUNT(*) > 1;

-- Categories overview
SELECT DISTINCT Category
FROM zepto_data
ORDER BY Category;
    
-- Count of products in stock and out of stock

SELECT outOfStock_bit, COUNT(*) as count
    FROM zepto_data
    GROUP BY outOfStock_bit;

-- ========================================================
-- DATA CLEANING
-- ========================================================

-- Remove invalid prices
DELETE FROM zepto_data
    WHERE mrp <= 0 or discountedSellingPrice <= 0;

-- Remove invalid discounts (>100% or negative)
SELECT * FROM zepto_data
    WHERE discountPercent < 0 OR discountPercent > 100;

-- Convert paise into INR
UPDATE zepto_data
    SET mrp = mrp/100.0,
    discountedSellingPrice = discountedSellingPrice/100.0;

-- Stock status summary (post-cleaning)
SELECT 
    outOfStock_bit,
    COUNT(*) AS count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM zepto_data 
GROUP BY outOfStock_bit;

-- ========================================================
-- BUSINESS INSIGHTS
-- ========================================================

-- Q1 Find the top best-value products based on the discount percentage.
SELECT DISTINCT TOP(10)
    name, 
    mrp, 
    discountPercent
    FROM zepto_data
    ORDER BY discountPercent DESC;

--Q2 High-MRP products that are out of stock

SELECT DISTINCT name,
    mrp
    FROM zepto_data
    WHERE outOfStock_bit = 1 and mrp > 300
    ORDER BY mrp DESC;

--Q3 Calculate Estimated revenue for each category

SELECT DISTINCT Category FROM zepto_data;

SELECT Category,
    SUM(discountedSellingPrice * AvailableQuantity) AS total_revenue
    FROM zepto_data
    GROUP BY Category
    ORDER BY total_revenue DESC;

--Q4 Premium products with low discounts

SELECT DISTINCT name,
    mrp, 
    discountPercent
    FROM zepto_data
    WHERE mrp > 500 AND discountPercent < 10
    ORDER BY mrp DESC,discountPErcent DESC ;

--Q5 Identify the top 5 categories offering the highest average discount percentage.

SELECT TOP 5 Category,
    ROUND(AVG(CAST(discountPercent AS FLOAT)),2) as Average_Discount
    FROM zepto_data
    GROUP BY Category
    ORDER BY Average_Discount DESC;

--Q6 Best value products(price per gram)

SELECT DISTINCT name,
    weightInGms,
    ROUND(CAST((discountedSellingPrice/weightInGms) AS FLOAT),3) as price_per_gram
    FROM zepto_data
    WHERE weightInGms >= 100
    ORDER BY price_per_gram ;

--Q7 Group the products into categories like low, medium, Bulk.

SELECT DISTINCT name, weightInGms,
    CASE WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'BULK'
        END AS weight_category
    FROM zepto_data;

--Q8 Total Inventory Weight Per Category
SELECT Category,
    SUM(weightInGms * availableQuantity) AS total_weight
    FRom zepto_data
    GROUP BY Category
    ORDER BY total_weight;

