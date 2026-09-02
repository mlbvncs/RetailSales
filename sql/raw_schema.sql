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

-- date_dimension.csv (COLUNAS COM ESPAÇOS!)
CREATE TABLE raw.date_dimension (
    "date key" VARCHAR(10) NOT NULL,
    "full date" VARCHAR(15) NOT NULL,
    "day of week" VARCHAR(5),
    "day num in month" VARCHAR(5),
    "day num overall" VARCHAR(10),
    "day name" VARCHAR(15),
    "day abbrev" VARCHAR(5),
    "weekday flag" VARCHAR(15),
    "week num in year" VARCHAR(5),
    "week num overall" VARCHAR(10),
    "week begin date" VARCHAR(15),
    "week begin date key" VARCHAR(10),
    month VARCHAR(5),
    "month num overall" VARCHAR(5),
    "month name" VARCHAR(15),
    "month abbrev" VARCHAR(5),
    quarter VARCHAR(5),
    year VARCHAR(10),
    yearmo VARCHAR(10),
    "fiscal month" VARCHAR(5),
    "fiscal quarter" VARCHAR(5),
    "fiscal year" VARCHAR(10),
    "month end flag" VARCHAR(20),
    "same day year ago" VARCHAR(15),
    CONSTRAINT pk_date_dimension PRIMARY KEY ("date key")
);

-- departments.csv
CREATE TABLE raw.departments (
    department_id VARCHAR(10) NOT NULL,
    department_number VARCHAR(10) NOT NULL,
    department_description VARCHAR(50) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (department_id)
);

-- districts.csv
CREATE TABLE raw.districts (
    district_id VARCHAR(10) NOT NULL,
    district_name VARCHAR(50),
    region_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_districts PRIMARY KEY (district_id)
);

-- employees.csv
CREATE TABLE raw.employees (
    employee_id VARCHAR(10) NOT NULL,
    employee_code VARCHAR(20),
    employee_name VARCHAR(50),
    title VARCHAR(50),
    hire_date VARCHAR(15),
    employment_status VARCHAR(30),
    employment_type VARCHAR(20),
    supervisor_id VARCHAR(10),
    home_store_id VARCHAR(10),
    authorization_level VARCHAR(50),
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
    subcategory_id VARCHAR(10),
    package_type_description VARCHAR(30),
    package_size VARCHAR(30),
    fat_content VARCHAR(30),
    diet_type VARCHAR(30),
    weight VARCHAR(20),
    weight_unit_of_measure VARCHAR(20),
    storage_type VARCHAR(30),
    shelf_life_type VARCHAR(30),
    shelf_width VARCHAR(10),
    shelf_height VARCHAR(10),
    shelf_depth VARCHAR(10),
    unit_cost VARCHAR(15),
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);

-- promotions.csv
CREATE TABLE raw.promotions (
    promotion_id VARCHAR(10) NOT NULL,
    promotion_code VARCHAR(20),
    promotion_name VARCHAR(50),
    price_reduction_type VARCHAR(30),
    promotion_media_type VARCHAR(30),
    ad_type VARCHAR(30),
    display_type VARCHAR(30),
    coupon_type VARCHAR(30),
    ad_media_name VARCHAR(30),
    display_provider VARCHAR(30),
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
    street_address VARCHAR(50),
    city VARCHAR(30),
    county VARCHAR(30),
    state VARCHAR(10),
    zip_code VARCHAR(20),
    manager_name VARCHAR(50),
    district_id VARCHAR(10),
    floor_plan_type VARCHAR(30),
    photo_processing_type VARCHAR(10),
    financial_service_type VARCHAR(30),
    selling_square_footage VARCHAR(15),
    total_square_footage VARCHAR(15),
    first_open_date VARCHAR(15),
    last_remodel_date VARCHAR(15),
    CONSTRAINT pk_stores PRIMARY KEY (store_id)
);

-- subcategories.csv
CREATE TABLE raw.subcategories (
    subcategory_id VARCHAR(10) NOT NULL,
    subcategory_description VARCHAR(50),
    category_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_subcategories PRIMARY KEY (subcategory_id)
);