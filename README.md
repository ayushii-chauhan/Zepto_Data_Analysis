Zepto Inventory Data Analysis (SQL)
Overview

This project analyzes a grocery inventory dataset from Zepto to explore pricing, discounts, stock availability, and product value using SQL. The goal is to answer practical business questions that are relevant to retail and quick-commerce operations.

Dataset

Source: Kaggle – Zepto Inventory Dataset

~3,700 product SKUs across multiple grocery categories

Includes pricing, discount percentage, product weight, and stock status

Data provided in CSV / XLSX format

Each row represents a single product SKU.

Data Cleaning & Preparation

Converted prices from paise to INR

Standardized stock status into a boolean flag

Removed invalid pricing records

Identified and flagged unrealistic product weights

Validated discount percentages against selling prices

Note: The availableQuantity column was excluded as it did not reflect actual inventory levels.

Analysis Highlights

Compared discount levels across products and categories

Identified high-priced products with low discounts

Estimated category-level revenue (assuming one unit per SKU)

Calculated price-per-gram to identify best-value products

Grouped products by pack size (Small / Medium / Bulk)

Reviewed stock availability patterns

Assumptions & Limitations

No sales or transaction data was available

Revenue estimates assume one unit sold per product

quantity represents pack size, not sales volume

Tools Used

SQL

GitHub

Purpose

This project was built for Data Analyst portfolio practice, focusing on data cleaning, exploratory analysis, and clearly communicating assumptions and insights.