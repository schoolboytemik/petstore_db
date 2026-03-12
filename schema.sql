-- 1. ТОВАРЫ (Goods)
CREATE TABLE Goods (
    G_id               NUMERIC(4)     PRIMARY KEY,
    G_name             VARCHAR(100)   NOT NULL,
    G_desc             VARCHAR(255),
    G_purchase_price   NUMERIC(10,2)  NOT NULL,
    G_retail_price     NUMERIC(10,2)  NOT NULL,
    G_stock            NUMERIC(6)     NOT NULL,
    G_volume           VARCHAR(20),
    G_weight           VARCHAR(20),
    G_expiry_date      DATE,
    G_manufacturer     VARCHAR(50),
    G_category_id      NUMERIC(4)     NOT NULL,
    G_species          VARCHAR(50)    NOT NULL,
    FOREIGN KEY (G_category_id) REFERENCES Categories(C_id)
);

-- 2. КАТЕГОРИИ (Categories)
CREATE TABLE Categories (
    C_id    NUMERIC(4)    PRIMARY KEY,
    C_name  VARCHAR(50)   NOT NULL UNIQUE,
    C_desc  VARCHAR(255)
);

-- 3. ПОСТАВЩИКИ (Suppliers)
CREATE TABLE Suppliers (
    S_id      NUMERIC(4)    PRIMARY KEY,
    S_name    VARCHAR(100)  NOT NULL,
    S_phone   VARCHAR(20),
    S_address VARCHAR(255),
    S_email   VARCHAR(100)
);

-- 4. ЗАКАЗЫ (Orders)
CREATE TABLE Orders (
    O_id      NUMERIC(6)    PRIMARY KEY,
    O_date    DATE          NOT NULL,
    O_total   NUMERIC(10,2) NOT NULL,
    O_staffid NUMERIC(6)    NOT NULL,
    FOREIGN KEY (O_staffid) REFERENCES Staff(ST_id)
);

-- 5. СОТРУДНИКИ (Staff)
CREATE TABLE Staff (
    ST_id        NUMERIC(6)    PRIMARY KEY,
    ST_fname     VARCHAR(50)   NOT NULL,
    ST_lname     VARCHAR(50)   NOT NULL,
    ST_passport  CHAR(10)      NOT NULL UNIQUE,
    ST_birthdate DATE          NOT NULL,
    ST_gender    CHAR(1)       NOT NULL CHECK (ST_gender IN ('M','F')),
    ST_inn       CHAR(12)      UNIQUE,
    ST_snils     CHAR(11)      UNIQUE,
    ST_login     VARCHAR(50)   NOT NULL UNIQUE,
    ST_hire_date DATE          NOT NULL,
    ST_post_id   NUMERIC(4)    NOT NULL,
    FOREIGN KEY (ST_post_id) REFERENCES Posts(P_id)
);

-- 6. ДОЛЖНОСТИ (Posts)
CREATE TABLE Posts (
    P_id     NUMERIC(4)    PRIMARY KEY,
    P_name   VARCHAR(50)   NOT NULL UNIQUE,
    P_salary NUMERIC(10,2) NOT NULL,
    P_desc   VARCHAR(255)
);

-- 7. СОСТАВ ЗАКАЗА (Order_Items)
CREATE TABLE Order_Items (
    OI_order_id     NUMERIC(6)    NOT NULL,
    OI_good_id      NUMERIC(4)    NOT NULL,
    OI_quantity     NUMERIC(6)    NOT NULL,
    OI_price_at_sale NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (OI_order_id, OI_good_id),
    FOREIGN KEY (OI_order_id) REFERENCES Orders(O_id),
    FOREIGN KEY (OI_good_id)  REFERENCES Goods(G_id)
);

-- 8. СОСТАВ ПОСТАВКИ (Supply_Items)
CREATE TABLE Supply_Items (
    SI_id          NUMERIC(6)    NOT NULL,
    SI_s_id        NUMERIC(4)    NOT NULL,
    SI_g_id        NUMERIC(4)    NOT NULL,
    SI_quantity    NUMERIC(6)    NOT NULL,
    SI_price_at_sale NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (SI_id, SI_g_id),
    FOREIGN KEY (SI_s_id) REFERENCES Suppliers(S_id),
    FOREIGN KEY (SI_g_id) REFERENCES Goods(G_id)
);
