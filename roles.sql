-- 9. Роли
CREATE ROLE Владелец_магазина;
CREATE ROLE Менеджер_магазина;
CREATE ROLE Сотрудники;
CREATE ROLE Администратор_БД;


-- 10. Права для Владельца магазина
GRANT SELECT, INSERT, UPDATE, DELETE ON
    Categories, Goods, Suppliers, Orders, Order_Items, Staff, Posts, Supply_Items
TO Владелец_магазина;

-- 11. Права для Менеджера магазина
GRANT SELECT, INSERT, UPDATE ON
    Goods, Suppliers, Orders, Order_Items, Categories, Supply_Items
TO Менеджер_магазина;

-- 12. Права для Сотрудников
GRANT SELECT ON Goods, Categories TO Сотрудники;
GRANT INSERT, SELECT ON Orders, Order_Items TO Сотрудники;

-- 13. Права для Администратора БД
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Администратор_БД;
