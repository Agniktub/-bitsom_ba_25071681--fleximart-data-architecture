# Part 2: NoSQL Database Analysis Overview

This directory contains the theory and practical implementation for Part 2 of the assignment, analyzing the suitability of MongoDB for FlexiMart's diverse product catalog.

Key Files:
- nosql_analysis.md: Theoretical report justifying NoSQL usage, RDBMS limitations, MongoDB benefits, and trade-offs.
- mongodb_operations.js: MongoDB operations script (data import note + 5 required operations with comments).
- products_catalog.json: Sample product data with nested specifications and reviews (12 products across Electronics and Fashion).

To run:
1. Ensure MongoDB is running and create database `fleximart_nosql` (or use default).
2. Import data:
   ``bash
   mongoimport --db fleximart_nosql --collection products --file part2-nosql/products_catalog.json --jsonArray
