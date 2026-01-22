# 🛒 Zepto E-commerce SQL Data Analyst Portfolio Project

This is a professional, real-world SQL Data Analytics project built using an inventory dataset scraped from Zepto, one of India’s fastest-growing quick-commerce startups. The project replicates how data analysts handle raw e-commerce data — from exploration and cleaning to advanced business analysis — to derive actionable insights.

---

## 📌 Project Highlights

	•	✔️ Real-world e-commerce inventory use case
	•	✔️ 8+ SQL queries for revenue, pricing, and inventory analytics
	•	✔️ Industry-grade data cleaning, EDA, and performance optimization
	•	✔️ Actionable metrics: Discounts, revenue, price/gram, weight categories

---

## 🧠 Project Objectives

The aim is to simulate the end-to-end process that data analysts perform in real-world scenarios:
	•	Build schema and load CSV data.
	•	Perform structured EDA (Exploratory Data Analysis)
	•	Derive actionable business insights using advanced SQL queries such as Top value, stock-outs, category revenue.

---

## 📁 Dataset Overview

The dataset used for this project is sourced from [Kaggle: Zepto Inventory Dataset](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv). It closely replicates the structure of a real-world e-commerce inventory system, scraped from Zepto's official product listings.

### 🧾 Columns Description

| Column Name              | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| `sku_id`                 | Unique identifier for each SKU (Synthetic Primary Key)                      |
| `name`                   | Product name as listed on the Zepto app                                     |
| `category`               | Product category (e.g., Fruits, Snacks, Beverages)                          |
| `mrp`                    | Maximum Retail Price (converted to ₹ from paise)                            |
| `discountPercent`        | Percentage of discount applied on MRP                                       |
| `discountedSellingPrice`| Final price after applying the discount (in ₹)                              |
| `availableQuantity`      | Inventory count indicating stock availability                               |
| `weightInGms`            | Net product weight in grams                                                 |
| `outOfStock`             | Boolean flag (TRUE/FALSE) indicating stock status                           |
| `quantity`               | Quantity per unit/package (mixed format — integers or grams for loose items)|


## 🛠️ Tools & Technologies

	•	SQL Server
	•	CSV (UTF-8 Format)
	•	Git & GitHub

## 🔧 Workflow

### 1. Database Schema Creation

```sql
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
```

---

### 2️⃣ Data Import

	--	Load CSV data into SQL Server using Azure Data Studio.


### 🔍 Data Exploration

	-	Counted the total number of rows in the dataset
	-	Displayed a sample of records to understand structure
	-	Checked for null/missing values across all columns
	-	Identified all unique product categories
	-	Analyzed in-stock vs out-of-stock SKU distribution
	-	Found duplicate product names with different SKUs


### 🧹 Data Cleaning

	•	Removed rows where MRP or selling price was zero
	•	Converted prices from paise to rupees for clarity
	•	Rounded values for better readability
	•	Checked for discrepancies in discount calculations
	•	Ensured no NULLs in primary analytical columns



### 📊 Business Insights

	•	Ranked top 10 products with highest discount %
	•	Listed high-MRP products that are currently out of stock
	•	Estimated potential revenue per category
	•	Found expensive products (MRP > ₹500) with low discount
	•	Identified categories with highest average discounts
	•	Calculated price per gram to compare product value
	•	Segmented products into Low, Medium, and Bulk by weight
	•	Measured total inventory weight across categories

