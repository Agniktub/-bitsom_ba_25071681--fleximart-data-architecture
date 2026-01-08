import pandas as pd
import mysql.connector
from mysql.connector import Error
import logging
import re
from datetime import datetime

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Database connection details
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'agnik1234',
    'database': 'fleximart'
}

# File paths (D drive as specified)
CUSTOMERS_FILE = 'D:/data/customers_raw.csv'
PRODUCTS_FILE = 'D:/data/products_raw.csv'
SALES_FILE = 'D:/data/sales_raw.csv'

# Data quality report file
REPORT_FILE = 'part1-database-etl/data_quality_report.txt'

def connect_db():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        logging.info("Database connection successful")
        return conn
    except Error as e:
        logging.error(f"Error connecting to database: {e}")
        raise

def clean_phone(phone):
    if pd.isna(phone):
        return None
    digits = re.sub(r'\D', '', str(phone))
    if len(digits) == 10:
        return f"+91-{digits}"
    elif len(digits) == 11 and digits.startswith('0'):
        return f"+91-{digits[1:]}"
    elif len(digits) == 12 and digits.startswith('91'):
        return f"+91-{digits[2:]}"
    else:
        logging.warning(f"Invalid phone format: {phone}")
        return None

def process_customers():
    df = pd.read_csv(CUSTOMERS_FILE)
    initial_count = len(df)
    
    df = df.drop_duplicates()
    duplicates_removed = initial_count - len(df)
    
    missing_emails = df['email'].isna().sum()
    df.loc[df['email'].isna(), 'email'] = [f"noemail{i}@fleximart.com" for i in df[df['email'].isna()].index]
    
    df['phone'] = df['phone'].apply(clean_phone)
    
    df['city'] = df['city'].str.strip().str.title()
    
    def parse_date(date_str):
        formats = ['%Y-%m-%d', '%d/%m/%Y', '%m-%d-%Y']
        for fmt in formats:
            try:
                return datetime.strptime(str(date_str).strip(), fmt).strftime('%Y-%m-%d')
            except ValueError:
                pass
        return None
    
    df['registration_date'] = df['registration_date'].apply(parse_date)
    df = df.dropna(subset=['registration_date'])
    
    loaded = len(df)
    
    return df, {
        'processed': initial_count,
        'duplicates_removed': duplicates_removed,
        'missing_handled': missing_emails,
        'loaded': loaded
    }

def process_products():
    df = pd.read_csv(PRODUCTS_FILE)
    initial_count = len(df)
    
    df = df.drop_duplicates()
    duplicates_removed = initial_count - len(df)
    
    df['category'] = df['category'].str.strip().str.title()
    
    missing_stock = df['stock_quantity'].isna().sum()
    df['stock_quantity'] = df['stock_quantity'].fillna(0).astype(int)
    
    missing_prices = df['price'].isna().sum()
    df['price'] = pd.to_numeric(df['price'], errors='coerce')
    df['price'] = df.groupby('category')['price'].transform(lambda x: x.fillna(x.mean()))
    df['price'] = df['price'].fillna(0)
    
    df['product_name'] = df['product_name'].str.strip()
    
    loaded = len(df)
    
    return df, {
        'processed': initial_count,
        'duplicates_removed': duplicates_removed,
        'missing_handled': missing_prices + missing_stock,
        'loaded': loaded
    }

def process_sales():
    df = pd.read_csv(SALES_FILE)
    initial_count = len(df)
    
    df = df.drop_duplicates()
    duplicates_removed = initial_count - len(df)
    
    missing_ids = df['customer_id'].isna().sum() + df['product_id'].isna().sum()
    df = df.dropna(subset=['customer_id', 'product_id'])
    
    def parse_date(date_str):
        formats = ['%Y-%m-%d', '%d/%m/%Y', '%m-%d-%Y']
        for fmt in formats:
            try:
                return datetime.strptime(str(date_str).strip(), fmt).strftime('%Y-%m-%d')
            except ValueError:
                pass
        return None
    
    df['transaction_date'] = df['transaction_date'].apply(parse_date)
    df = df.dropna(subset=['transaction_date'])
    
    loaded = len(df)
    
    return df, {
        'processed': initial_count,
        'duplicates_removed': duplicates_removed,
        'missing_handled': missing_ids,
        'loaded': loaded
    }

def load_data(conn, customers_df, products_df, sales_df):
    cursor = conn.cursor()
    
    customer_map = {}
    for _, row in customers_df.iterrows():
        try:
            cursor.execute("""
                INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (row['first_name'], row['last_name'], row['email'], row['phone'], row['city'], row['registration_date']))
            conn.commit()
            new_id = cursor.lastrowid
            customer_map[row['customer_id']] = new_id
        except Error as e:
            logging.error(f"Error inserting customer: {e}")
            conn.rollback()
    
    product_map = {}
    for _, row in products_df.iterrows():
        try:
            cursor.execute("""
                INSERT INTO products (product_name, category, price, stock_quantity)
                VALUES (%s, %s, %s, %s)
            """, (row['product_name'], row['category'], row['price'], row['stock_quantity']))
            conn.commit()
            new_id = cursor.lastrowid
            product_map[row['product_id']] = new_id
        except Error as e:
            logging.error(f"Error inserting product: {e}")
            conn.rollback()
    
    for _, row in sales_df.iterrows():
        if row['customer_id'] not in customer_map or row['product_id'] not in product_map:
            continue
        try:
            total_amount = row['quantity'] * row['unit_price']
            cursor.execute("""
                INSERT INTO orders (customer_id, order_date, total_amount, status)
                VALUES (%s, %s, %s, %s)
            """, (customer_map[row['customer_id']], row['transaction_date'], total_amount, row['status']))
            conn.commit()
            order_id = cursor.lastrowid
            
            cursor.execute("""
                INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
                VALUES (%s, %s, %s, %s, %s)
            """, (order_id, product_map[row['product_id']], row['quantity'], row['unit_price'], total_amount))
            conn.commit()
        except Error as e:
            logging.error(f"Error inserting sale: {e}")
            conn.rollback()

def generate_report(reports):
    with open(REPORT_FILE, 'w') as f:
        for file_name, rep in reports.items():
            f.write(f"File: {file_name}\n")
            f.write(f"Number of records processed: {rep['processed']}\n")
            f.write(f"Number of duplicates removed: {rep['duplicates_removed']}\n")
            f.write(f"Number of missing values handled: {rep['missing_handled']}\n")
            f.write(f"Number of records loaded successfully: {rep['loaded']}\n\n")

if __name__ == "__main__":
    try:
        conn = connect_db()
        
        customers_df, cust_report = process_customers()
        products_df, prod_report = process_products()
        sales_df, sales_report = process_sales()
        
        load_data(conn, customers_df, products_df, sales_df)
        
        reports = {
            'customers_raw.csv': cust_report,
            'products_raw.csv': prod_report,
            'sales_raw.csv': sales_report
        }
        generate_report(reports)
        
        logging.info("ETL process completed successfully")
        print("ETL completed. Check data_quality_report.txt for details.")
    except Exception as e:
        logging.error(f"ETL process failed: {e}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            conn.close()