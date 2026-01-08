# FlexiMart Data Architecture Project

**Student Name:** Agnik Banerjee  
**Student ID:** bitsom_ba_25071681 
**Email:** agnik631@gmail.com  
**Date:** January 08, 2026

## Project Overview
This project implements a complete data pipeline for FlexiMart, an e-commerce platform. It includes an ETL process to clean raw CSV data and load it into a relational MySQL database, theoretical and practical analysis of using MongoDB for a flexible product catalog, and the design and implementation of a star-schema data warehouse with advanced OLAP analytics queries. The solution demonstrates data quality handling, normalization, NoSQL flexibility, and dimensional modeling for business intelligence.

## Repository Structure

```text
studentID-fleximart-data-architecture/
├── data/                               # Input data files
│   ├── customers_raw.csv
│   ├── products_raw.csv
│   └── sales_raw.csv
│
├── part1-database-etl/                 # Part 1: Database ETL
│   ├── README.md
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   ├── data_quality_report.txt
│   └── requirements.txt
│
├── part2-nosql/                        # Part 2: NoSQL
│   ├── README.md
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
│
├── part3-datawarehouse/                # Part 3: Data Warehouse
│   ├── README.md
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
│
├── .gitignore
└── README.md




## Technologies Used
- Python 3.x, pandas, mysql-connector-python
- MySQL 8.0
- MongoDB 6.0+

## Setup Instructions

### Database Setup (MySQL)
bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline (generates data_quality_report.txt)
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

MongoDB Setup:

# Import product catalog
mongoimport --db fleximart_nosql --collection products --file part2-nosql/products_catalog.json --jsonArray

# Run MongoDB operations
mongosh fleximart_nosql part2-nosql/mongodb_operations.js


Key Learnings

I gained hands-on experience in building end-to-end data pipelines, including data cleaning, transformation, and loading into relational databases. I understood the trade-offs between RDBMS and NoSQL databases, particularly how MongoDB's flexible schema is ideal for semi-structured product catalogs. I also learned dimensional modeling with star schemas and how they enable efficient analytical queries using window functions, aggregations, and segmentation. Finally, I appreciated the importance of documentation, code quality, and realistic data generation for production-like systems.

Challenges Faced

Handling inconsistent data formats (dates, phones, categories) in raw CSVs → Solved by implementing robust parsing functions with multiple format attempts and regex standardization in the ETL script.
Mapping original business keys to surrogate keys while loading data → Addressed by inserting records sequentially and using MySQL's lastrowid to create accurate mapping dictionaries during the load phase.
