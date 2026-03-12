-- 14. Представления

-- Текущие заказы (активные на сегодня)
CREATE OR REPLACE VIEW current_orders AS
SELECT
    O_id,
    O_date,
    O_total,
    ST_fname || ' ' || ST_lname AS Сотрудник
FROM Orders
JOIN Staff ON Orders.O_staffid = Staff.ST_id
WHERE O_date = CURRENT_DATE;

-- Товары с низким остатком (< 10)
CREATE OR REPLACE VIEW low_stock_goods AS
SELECT
    G_id,
    G_name,
    G_stock
FROM Goods
WHERE G_stock < 10;

-- Продажи по сотрудникам (текущий месяц)
CREATE OR REPLACE VIEW sales_by_staff AS
SELECT
    Staff.ST_id,
    ST_fname || ' ' || ST_lname AS Сотрудник,
    COUNT(O_id)    AS Количество_заказов,
    SUM(O_total)   AS Общая_сумма
FROM Orders
JOIN Staff ON Orders.O_staffid = Staff.ST_id
WHERE EXTRACT(MONTH FROM O_date) = EXTRACT(MONTH FROM CURRENT_DATE)
GROUP BY Staff.ST_id, ST_fname, ST_lname;

-- Поставщики с активными поставками
CREATE OR REPLACE VIEW active_suppliers AS
SELECT
    Suppliers.S_id,
    S_name,
    COUNT(SI_g_id) AS Количество_товаров
FROM Suppliers
JOIN Supply_Items ON Suppliers.S_id = Supply_Items.SI_s_id
GROUP BY Suppliers.S_id, S_name;

-- Конфиденциальные данные сотрудников
CREATE OR REPLACE VIEW staff_confidential AS
SELECT
    ST_id,
    ST_fname,
    ST_lname,
    ST_passport,
    ST_inn,
    ST_snils
FROM Staff
WITH CHECK OPTION;
