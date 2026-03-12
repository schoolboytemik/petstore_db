-- 15. Триггеры

-- Функция проверки остатка при добавлении в заказ
CREATE OR REPLACE FUNCTION check_stock() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT G_stock FROM Goods WHERE G_id = NEW.OI_good_id) < NEW.OI_quantity THEN
        RAISE EXCEPTION
            'Недостаточно товара с кодом % на складе. Остаток: %',
            NEW.OI_good_id,
            (SELECT G_stock FROM Goods WHERE G_id = NEW.OI_good_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_check_stock
BEFORE INSERT OR UPDATE ON Order_Items
FOR EACH ROW EXECUTE PROCEDURE check_stock();

-- Функция проверки прав сотрудника на оформление заказа
CREATE OR REPLACE FUNCTION check_staff_role() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Staff
        JOIN Posts ON Staff.ST_post_id = Posts.P_id
        WHERE ST_id = NEW.O_staffid
          AND P_name = 'Продавец'
    ) THEN
        RAISE EXCEPTION
            'Сотрудник с ID % не имеет прав оформлять заказы',
            NEW.O_staffid;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_check_staff_role
BEFORE INSERT OR UPDATE ON Orders
FOR EACH ROW EXECUTE PROCEDURE check_staff_role();

-- Функция автоматического обновления остатка после заказа
CREATE OR REPLACE FUNCTION update_stock() RETURNS TRIGGER AS $$
BEGIN
    UPDATE Goods
    SET G_stock = G_stock - NEW.OI_quantity
    WHERE G_id = NEW.OI_good_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_update_stock
AFTER INSERT ON Order_Items
FOR EACH ROW EXECUTE PROCEDURE update_stock();
