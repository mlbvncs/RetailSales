CREATE DATABASE IF NOT EXISTS retailsales;

CREATE SCHEMA IF NOT EXISTS raw;

-- brands.csv
CREATE TABLE raw.brands (
    brand_id VARCHAR(10) NOT NULL,
    brand_description VARCHAR(50) NOT NULL,
    CONSTRAINT pk_brands PRIMARY KEY (brand_id)
);

-- categories.csv
CREATE TABLE raw.categories (
    category_id VARCHAR(10) NOT NULL,
    category_description VARCHAR(50),
    department_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (category_id)
);

-- departments.csv
CREATE TABLE raw.departments (
    department_id VARCHAR(10) NOT NULL,
    department_number VARCHAR(10) NOT NULL,
    department_description VARCHAR(50) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (department_id)
);

-- employees.csv
CREATE TABLE raw.employees (
    employee_id VARCHAR(10) NOT NULL,
    employee_code VARCHAR(20),
    employee_name VARCHAR(50),
    hire_date VARCHAR(15),
    employment_status VARCHAR(30),
    home_store_id VARCHAR(10),
    CONSTRAINT pk_employees PRIMARY KEY (employee_id)
);

-- payment_methods.csv
CREATE TABLE raw.payment_methods (
    payment_method_id VARCHAR(10) NOT NULL,
    description VARCHAR(50),
    method_group VARCHAR(20),
    CONSTRAINT pk_payment_methods PRIMARY KEY (payment_method_id)
);

-- pos_transaction_items.csv
CREATE TABLE raw.pos_transaction_items (
    transaction_item_id VARCHAR(10) NOT NULL,
    transaction_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10),
    promotion_id VARCHAR(10),
    sales_quantity VARCHAR(10),
    regular_unit_price VARCHAR(15),
    discount_unit_price VARCHAR(15),
    CONSTRAINT pk_pos_transaction_items PRIMARY KEY (transaction_item_id)
);

-- pos_transactions.csv
CREATE TABLE raw.pos_transactions (
    transaction_id VARCHAR(10) NOT NULL,
    transaction_number VARCHAR(20),
    store_id VARCHAR(10),
    employee_id VARCHAR(10),
    payment_method_id VARCHAR(10),
    transaction_timestamp VARCHAR(30),
    CONSTRAINT pk_pos_transactions PRIMARY KEY (transaction_id)
);

-- products.csv
CREATE TABLE raw.products (
    product_id VARCHAR(10) NOT NULL,
    sku_number VARCHAR(20),
    product_description VARCHAR(100),
    brand_id VARCHAR(10),
    category_id VARCHAR(10),
    package_size VARCHAR(30),
    weight VARCHAR(20),
    weight_unit_of_measure VARCHAR(20),
    unit_cost VARCHAR(15),
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);

-- promotions.csv
CREATE TABLE raw.promotions (
    promotion_id VARCHAR(10) NOT NULL,
    promotion_code VARCHAR(20),
    promotion_name VARCHAR(50),
    price_reduction_type VARCHAR(30),
    display_type VARCHAR(30),
    promotion_cost VARCHAR(20),
    promotion_begin_date VARCHAR(15),
    promotion_end_date VARCHAR(15),
    CONSTRAINT pk_promotions PRIMARY KEY (promotion_id)
);

-- regions.csv
CREATE TABLE raw.regions (
    region_id VARCHAR(10) NOT NULL,
    region_name VARCHAR(30),
    CONSTRAINT pk_regions PRIMARY KEY (region_id)
);

-- stores.csv
CREATE TABLE raw.stores (
    store_id VARCHAR(10) NOT NULL,
    store_number VARCHAR(20),
    store_name VARCHAR(50),
    city VARCHAR(30),
    state VARCHAR(10),
    region_id VARCHAR(10),
    floor_plan_type VARCHAR(30),
    selling_square_footage VARCHAR(15),
    first_open_date VARCHAR(15),
    CONSTRAINT pk_stores PRIMARY KEY (store_id)
);