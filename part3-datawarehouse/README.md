# Part 3: Data Warehouse and Analytics Overview

This directory contains the implementation for Part 3 of the assignment: designing and building a data warehouse using a star schema, populating it with data, and writing OLAP analytical queries.

Key Files:
- star_schema_design.md: Detailed documentation of the star schema design, decisions, and data flow example.
- warehouse_schema.sql: SQL script to create the data warehouse schema (tables with proper keys and constraints).
- warehouse_data.sql: INSERT statements to populate dimension and fact tables with realistic data.
- analytics_queries.sql: Three advanced analytical SQL queries demonstrating drill-down, top-N analysis, and customer segmentation.

To run:
1. Create the database fleximart_dw in MySQL.
2. Execute warehouse_schema.sql to create tables.
3. Execute warehouse_data.sql to load data (meets minimum requirements: 30 dates, 15 products, 12 customers, 40 fact rows).
4. Run analytics_queries.sql to view the analytical results.
