-- 16. Индексы

CREATE INDEX idx_goods_name       ON Goods(G_name);
CREATE INDEX idx_orders_date      ON Orders(O_date);
CREATE INDEX idx_staff_fullname   ON Staff(ST_fname, ST_lname);
