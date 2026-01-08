-- dim_date: First 31 days of January 2024 + February 1 (total >30)
INSERT INTO dim_date VALUES
(20240101, '2024-01-01', 'Monday',    1,  1, 'January',   'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday',   2,  1, 'January',   'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3,  1, 'January',   'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday',  4,  1, 'January',   'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday',    5,  1, 'January',   'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday',  6,  1, 'January',   'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday',    7,  1, 'January',   'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday',    8,  1, 'January',   'Q1', 2024, FALSE),
(20240109, '2024-01-09', 'Tuesday',   9,  1, 'January',   'Q1', 2024, FALSE),
(20240110, '2024-01-10', 'Wednesday',10,  1, 'January',   'Q1', 2024, FALSE),
(20240111, '2024-01-11', 'Thursday', 11,  1, 'January',   'Q1', 2024, FALSE),
(20240112, '2024-01-12', 'Friday',   12,  1, 'January',   'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13,  1, 'January',   'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday',   14,  1, 'January',   'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday',   15,  1, 'January',   'Q1', 2024, FALSE),
(20240116, '2024-01-16', 'Tuesday',  16,  1, 'January',   'Q1', 2024, FALSE),
(20240117, '2024-01-17', 'Wednesday',17,  1, 'January',   'Q1', 2024, FALSE),
(20240118, '2024-01-18', 'Thursday', 18,  1, 'January',   'Q1', 2024, FALSE),
(20240119, '2024-01-19', 'Friday',   19,  1, 'January',   'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20,  1, 'January',   'Q1', 2024, TRUE),
(20240121, '2024-01-21', 'Sunday',   21,  1, 'January',   'Q1', 2024, TRUE),
(20240122, '2024-01-22', 'Monday',   22,  1, 'January',   'Q1', 2024, FALSE),
(20240123, '2024-01-23', 'Tuesday',  23,  1, 'January',   'Q1', 2024, FALSE),
(20240124, '2024-01-24', 'Wednesday',24,  1, 'January',   'Q1', 2024, FALSE),
(20240125, '2024-01-25', 'Thursday', 25,  1, 'January',   'Q1', 2024, FALSE),
(20240126, '2024-01-26', 'Friday',   26,  1, 'January',   'Q1', 2024, FALSE),
(20240127, '2024-01-27', 'Saturday', 27,  1, 'January',   'Q1', 2024, TRUE),
(20240128, '2024-01-28', 'Sunday',   28,  1, 'January',   'Q1', 2024, TRUE),
(20240129, '2024-01-29', 'Monday',   29,  1, 'January',   'Q1', 2024, FALSE),
(20240130, '2024-01-30', 'Tuesday',  30,  1, 'January',   'Q1', 2024, FALSE),
(20240131, '2024-01-31', 'Wednesday',31,  1, 'January',   'Q1', 2024, FALSE),
(20240201, '2024-02-01', 'Thursday',  1,  2, 'February',  'Q1', 2024, FALSE);

-- dim_product: 15 products across 3 categories
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001', 'Samsung Galaxy S21', 'Electronics', 'Smartphones', 45999.00),
('P002', 'Nike Running Shoes', 'Fashion', 'Footwear', 3499.00),
('P003', 'Apple MacBook Pro', 'Electronics', 'Laptops', 189999.00),
('P004', 'Levi''s Jeans', 'Fashion', 'Clothing', 2999.00),
('P005', 'Sony Headphones', 'Electronics', 'Audio', 1999.00),
('P006', 'Organic Almonds', 'Groceries', 'Food', 899.00),
('P007', 'HP Laptop', 'Electronics', 'Laptops', 52999.00),
('P008', 'Adidas T-Shirt', 'Fashion', 'Clothing', 1299.00),
('P009', 'Basmati Rice 5kg', 'Groceries', 'Food', 650.00),
('P010', 'OnePlus Nord', 'Electronics', 'Smartphones', 26999.00),
('P011', 'Puma Sneakers', 'Fashion', 'Footwear', 4599.00),
('P012', 'Dell Monitor 24inch', 'Electronics', 'Monitors', 12999.00),
('P013', 'Woodland Shoes', 'Fashion', 'Footwear', 5499.00),
('P014', 'iPhone 13', 'Electronics', 'Smartphones', 69999.00),
('P015', 'Organic Honey 500g', 'Groceries', 'Food', 450.00);

-- dim_customer: 12 customers across multiple cities/states
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001', 'Rahul Sharma', 'Bangalore', 'Karnataka', 'Premium'),
('C002', 'Priya Patel', 'Mumbai', 'Maharashtra', 'Regular'),
('C003', 'Amit Kumar', 'Delhi', 'Delhi', 'New'),
('C004', 'Sneha Reddy', 'Hyderabad', 'Telangana', 'Premium'),
('C005', 'Vikram Singh', 'Chennai', 'Tamil Nadu', 'Regular'),
('C006', 'Anjali Mehta', 'Bangalore', 'Karnataka', 'Premium'),
('C007', 'Ravi Verma', 'Pune', 'Maharashtra', 'New'),
('C008', 'Pooja Iyer', 'Bangalore', 'Karnataka', 'Regular'),
('C009', 'Karthik Nair', 'Kochi', 'Kerala', 'Premium'),
('C010', 'Deepa Gupta', 'Delhi', 'Delhi', 'Regular'),
('C011', 'Arjun Rao', 'Hyderabad', 'Telangana', 'New'),
('C012', 'Lakshmi Krishnan', 'Chennai', 'Tamil Nadu', 'Premium');

-- fact_sales: 40 realistic transactions (higher quantities on weekends)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240115, 1, 1, 1, 45999.00, 0, 45999.00),
(20240116, 2, 2, 2, 3499.00, 200, 6798.00),
(20240106, 3, 3, 1, 189999.00, 5000, 184999.00), -- Weekend
(20240120, 4, 4, 3, 2999.00, 0, 8997.00),       -- Weekend
(20240113, 5, 5, 4, 1999.00, 400, 7596.00),     -- Weekend
(20240107, 6, 6, 10, 899.00, 0, 8990.00),       -- Weekend high qty
(20240127, 7, 7, 2, 52999.00, 3000, 100998.00),-- Weekend
(20240110, 8, 8, 5, 1299.00, 0, 6495.00),
(20240118, 9, 9, 8, 650.00, 100, 5100.00),
(20240125, 10, 10, 1, 26999.00, 0, 26999.00),
(20240105, 11, 11, 2, 4599.00, 0, 9198.00),
(20240112, 12, 12, 1, 12999.00, 500, 12499.00),
(20240114, 13, 1, 3, 5499.00, 300, 16197.00),  -- Weekend
(20240121, 14, 2, 1, 69999.00, 2000, 67999.00), -- Weekend
(20240108, 15, 3, 6, 450.00, 0, 2700.00),
(20240122, 1, 4, 1, 45999.00, 0, 45999.00),
(20240109, 2, 5, 1, 3499.00, 0, 3499.00),
(20240128, 3, 6, 1, 189999.00, 10000, 179999.00), -- Weekend
(20240117, 4, 7, 4, 2999.00, 0, 11996.00),
(20240126, 5, 8, 3, 1999.00, 0, 5997.00),
(20240119, 6, 9, 7, 899.00, 200, 6093.00),
(20240111, 7, 10, 1, 52999.00, 0, 52999.00),
(20240124, 8, 11, 2, 1299.00, 0, 2598.00),
(20240130, 9, 12, 5, 650.00, 0, 3250.00),
(20240102, 10, 1, 2, 26999.00, 1000, 52998.00),
(20240104, 11, 2, 1, 4599.00, 0, 4599.00),
(20240123, 12, 3, 2, 12999.00, 1000, 24998.00),
(20240129, 13, 4, 2, 5499.00, 0, 10998.00),
(20240131, 14, 5, 1, 69999.00, 3000, 66999.00),
(20240101, 15, 6, 4, 450.00, 0, 1800.00),
(20240103, 1, 7, 1, 45999.00, 0, 45999.00),
(20240107, 2, 8, 5, 3499.00, 500, 16995.00),    -- Weekend high
(20240113, 3, 9, 1, 189999.00, 0, 189999.00),   -- Weekend
(20240120, 4, 10, 2, 2999.00, 0, 5998.00),     -- Weekend
(20240127, 5, 11, 3, 1999.00, 300, 5697.00),    -- Weekend
(20240106, 6, 12, 12, 899.00, 500, 10288.00),   -- Weekend high qty
(20240114, 7, 1, 1, 52999.00, 0, 52999.00),     -- Weekend
(20240121, 8, 2, 4, 1299.00, 0, 5196.00),       -- Weekend
(20240128, 9, 3, 6, 650.00, 0, 3900.00),        -- Weekend
(20240115, 10, 4, 1, 26999.00, 500, 26499.00);