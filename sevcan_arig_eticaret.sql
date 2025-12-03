-- E-TİCARET TABOLARI--

CREATE TABLE "categories"(
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL
);
ALTER TABLE
    "categories" ADD PRIMARY KEY("id");

CREATE TABLE "products"(
    "id" SERIAL NOT NULL,
    "category_id" INTEGER NOT NULL, 
    "name" TEXT NOT NULL,
    "product_code" TEXT NOT NULL,
    "price" DECIMAL(10, 2) NOT NULL,
    "stock" INTEGER NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "products" ADD PRIMARY KEY("id");

CREATE TABLE "customers"(
    "id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "customers" ADD PRIMARY KEY("id");

CREATE TABLE "shipping_addresses"(
    "id" SERIAL NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "address_line" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "postal_code" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "is_default" BOOLEAN NOT NULL
);
ALTER TABLE
    "shipping_addresses" ADD PRIMARY KEY("id");

CREATE TABLE "orders"(
    "id" SERIAL NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "order_date" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,

    "status" VARCHAR(255) CHECK
        ("status" IN('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')) NOT NULL,
        "total" DECIMAL(12, 2) NOT NULL,
        "shipping_address_id" INTEGER NOT NULL
);
ALTER TABLE
    "orders" ADD PRIMARY KEY("id");

CREATE TABLE "order_items"(
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit_price" DECIMAL(10, 2) NOT NULL
);
ALTER TABLE
    "order_items" ADD PRIMARY KEY("id");

CREATE TABLE "reviews"(
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "reviews" ADD PRIMARY KEY("id");

CREATE TABLE "product_price_log"(
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "old_price" DECIMAL(10, 2) NOT NULL,
    "new_price" DECIMAL(10, 2) NOT NULL,
    "changed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "product_price_log" ADD PRIMARY KEY("id");


ALTER TABLE
    "products" ADD CONSTRAINT "products_category_id_foreign" FOREIGN KEY("category_id") REFERENCES "categories"("id");
    
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");

ALTER TABLE
    "orders" ADD CONSTRAINT "orders_shipping_address_id_foreign" FOREIGN KEY("shipping_address_id") REFERENCES "shipping_addresses"("id");

ALTER TABLE
    "shipping_addresses" ADD CONSTRAINT "shipping_addresses_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");

ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");

ALTER TABLE
    "reviews" ADD CONSTRAINT "reviews_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");

ALTER TABLE
    "product_price_log" ADD CONSTRAINT "product_price_log_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");

ALTER TABLE
    "orders" ADD CONSTRAINT "orders_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customers"("id");

ALTER TABLE
    "reviews" ADD CONSTRAINT "reviews_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id");



----------------Kategoriler------------------------

INSERT INTO categories (name, description) VALUES
('Elektronik', 'Bilgisayar, telefon ve aksesuarlar'),
('Kitap', 'Her türden kitap ve dergiler'),
('Giyim', 'Erkek, kadın ve çocuk giyim ürünleri'),
('Ev ve Yaşam', 'Mobilya, dekorasyon ve ev eşyaları'),
('Spor', 'Spor malzemeleri ve giyim'),
('Kozmetik', 'Cilt bakım ve makyaj ürünleri'),
('Oyuncak', 'Çocuklar için oyuncaklar'),
('Müzik ve Film', 'CD, plak, film ve aksesuarlar'),
('Mutfak', 'Mutfak gereçleri ve aletleri'),
('Bahçe', 'Bahçe mobilyaları ve malzemeleri');


------------------Ürünler--------------------------

INSERT INTO products (category_id, name, product_code, price, stock, created_at) VALUES
(1, 'Laptop Model X', 'LP1001', 12000.00, 10, NOW()),
(1, 'Akıllı Telefon Y', 'PH2001', 8500.00, 25, NOW()),
(1, 'Tablet Z', 'TB3001', 4500.00, 15, NOW()),
(2, 'Roman A', 'BK1001', 150.00, 100, NOW()),
(2, 'Roman B', 'BK1002', 175.00, 80, NOW()),
(2, 'Bilim Kitabı C', 'BK1003', 200.00, 60, NOW()),
(3, 'T-Shirt Mavi', 'CL1001', 200.00, 50, NOW()),
(3, 'Mont Siyah', 'CL1002', 600.00, 20, NOW()),
(4, 'Dekoratif Vazo', 'EV1001', 120.00, 40, NOW()),
(5, 'Koşu Ayakkabısı', 'SP1001', 500.00, 35, NOW()),
(6, 'Ruj Kırmızı', 'KO1001', 150.00, 80, NOW()),
(7, 'Lego Seti', 'OY1001', 300.00, 50, NOW()),
(8, 'Film DVD', 'MF1001', 100.00, 60, NOW()),
(9, 'Tencere Seti', 'MT1001', 750.00, 30, NOW()),
(10, 'Bahçe Sandalyesi', 'BH1001', 400.00, 15, NOW());

INSERT INTO products (category_id, name, product_code, price, stock, created_at) VALUES
(1, 'Bluetooth Kulaklık', 'AU9001', 350.00, 0, NOW());


---------------------Müşteriler----------------------------

INSERT INTO customers (first_name, last_name, phone, email, created_at) VALUES
('Sevcan', 'Arığ', '05551234567', 'sevcan@example.com', NOW()),
('Asel', 'Çaku', '05557654321', 'asel@example.com', NOW()),
('Mehmet', 'Demir', '05559876543', 'mehmet@example.com', NOW()),
('Fatma', 'Kaya', '05553456789', 'fatma@example.com', NOW()),
('Emre', 'Çelik', '05552345678', 'emre@example.com', NOW()),
('Zeynep', 'Öztürk', '05551122334', 'zeynep@example.com', NOW()),
('Ahmet', 'Koç', '05552233445', 'ahmet@example.com', NOW()),
('Elif', 'Aydın', '05553344556', 'elif@example.com', NOW()),
('Hakan', 'Yıldız', '05554455667', 'hakan@example.com', NOW()),
('Selin', 'Taş', '05555566778', 'selin@example.com', NOW()),
('Can', 'Kara', '05556677889', 'can@example.com', NOW()),
('Buse', 'Çetin', '05557788990', 'buse@example.com', NOW()),
('Deniz', 'Arslan', '05558899001', 'deniz@example.com', NOW()),
('Murat', 'Koçak', '05559900112', 'murat@example.com', NOW()),
('Seda', 'Polat', '05550011223', 'seda@example.com', NOW());


--------------------Teslimat Adresleri--------------------------------

INSERT INTO shipping_addresses (customer_id, address_line, city, postal_code, country, is_default) VALUES
(1, 'Atatürk Caddesi 10', 'İstanbul', '34000', 'Türkiye', TRUE),
(2, 'Cumhuriyet Mah. 5', 'Ankara', '06000', 'Türkiye', TRUE),
(3, 'İsmet Paşa Sokak 12', 'İzmir', '35000', 'Türkiye', TRUE),
(4, 'Fatih Mah. 7', 'Bursa', '16000', 'Türkiye', TRUE),
(5, 'Çankaya Cad. 22', 'Antalya', '07000', 'Türkiye', TRUE),
(6, 'Bahçelievler Sokak 3', 'İstanbul', '34100', 'Türkiye', TRUE),
(7, 'Kurtuluş Mah. 15', 'Ankara', '06100', 'Türkiye', TRUE),
(8, 'Alsancak Cad. 8', 'İzmir', '35200', 'Türkiye', TRUE),
(9, 'Nilüfer Mah. 18', 'Bursa', '16100', 'Türkiye', TRUE),
(10, 'Kepez Sokak 7', 'Antalya', '07100', 'Türkiye', TRUE),
(11, 'Levent Mah. 11', 'İstanbul', '34300', 'Türkiye', TRUE),
(12, 'Sincan Cad. 19', 'Ankara', '06900', 'Türkiye', TRUE),
(13, 'Karşıyaka Sokak 5', 'İzmir', '35300', 'Türkiye', TRUE),
(14, 'Osmangazi Mah. 2', 'Bursa', '16200', 'Türkiye', TRUE),
(15, 'Muratpaşa Cad. 9', 'Antalya', '07200', 'Türkiye', TRUE);


----------------------------Siparişler-----------------------------------

INSERT INTO orders (customer_id, order_date, status, total, shipping_address_id) VALUES
(1, NOW(), 'Pending', 12000.00, 1),
(2, NOW(), 'Processing', 950.00, 2),
(3, NOW(), 'Shipped', 200.00, 3),
(4, NOW(), 'Delivered', 175.00, 4),
(5, NOW(), 'Pending', 4500.00, 5),
(6, NOW(), 'Processing', 300.00, 6),
(7, NOW(), 'Delivered', 600.00, 7),
(8, NOW(), 'Cancelled', 130.00, 8),
(9, NOW(), 'Shipped', 500.00, 9),
(10, NOW(), 'Delivered', 200.00, 10),
(11, NOW(), 'Pending', 1200.00, 11),
(12, NOW(), 'Processing', 350.00, 12),
(13, NOW(), 'Shipped', 750.00, 13),
(14, NOW(), 'Delivered', 1800.00, 14),
(15, NOW(), 'Pending', 850.00, 15);


-----------------------------Sipariş Detayları--------------------------------

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(2, 1, 1, 12000.00),
(3, 4, 1, 200.00),
(4, 6, 1, 200.00),
(5, 7, 1, 600.00),
(6, 3, 1, 4500.00),
(7, 10, 1, 300.00),
(8, 12, 1, 100.00),
(9, 9, 1, 130.00),
(10, 15, 1, 500.00),
(11, 11, 1, 200.00),
(12, 2, 1, 8500.00),
(13, 5, 1, 150.00),
(14, 8, 1, 500.00),
(15, 14, 1, 1800.00),
(16, 13, 1, 750.00);


------------------------------Ürün Yorumları-------------------------------------

INSERT INTO reviews (product_id, customer_id, rating, comment, created_at) VALUES
(1, 1, 5, 'Laptop çok hızlı ve kaliteli.', NOW()),
(2, 2, 4, 'Telefon güzel ama batarya biraz çabuk bitiyor.', NOW()),
(3, 3, 5, 'Tablet kullanışlı ve ekranı güzel.', NOW()),
(4, 4, 3, 'Roman güzeldi ama biraz kısa.', NOW()),
(5, 5, 4, 'Bilim kitabı anlaşılır ve faydalı.', NOW()),
(6, 6, 5, 'T-shirt çok rahat ve güzel renk.', NOW()),
(7, 7, 4, 'Mont kaliteli ama biraz büyük geldi.', NOW()),
(8, 8, 5, 'Vazo dekoratif ve şık.', NOW()),
(9, 9, 5, 'Koşu ayakkabısı çok rahat.', NOW()),
(10, 10, 3, 'Ruj rengi güzel ama çabuk akıyor.', NOW()),
(11, 11, 4, 'Lego seti çocuklar için ideal.', NOW()),
(12, 12, 5, 'Film DVD harika, kaliteli baskı.', NOW()),
(13, 13, 4, 'Tencere seti çok kullanışlı.', NOW()),
(14, 14, 5, 'Bahçe sandalyesi çok konforlu.', NOW()),
(15, 15, 3, 'Araba telefon tutucu biraz ucuz malzemeden yapılmış.', NOW());


SELECT id, customer_id, total FROM orders ORDER BY id;

--fazlalıklar silindi
DELETE FROM order_items WHERE order_id > 15;   
DELETE FROM reviews WHERE id > 15;
DELETE FROM orders WHERE id > 15;


-- Kategorileri listele
SELECT * FROM categories;

-- Ürünleri listele
SELECT * FROM products;

-- Müşteri kayıtlarını listele
SELECT * FROM customers;

-- Siparişleri listele
SELECT * FROM orders;

-- Sipariş detaylarını listele
SELECT * FROM order_items;

-- Ürün yorumlarını listele
SELECT * FROM reviews;

-- Teslimat adreslerini listele
SELECT * FROM shipping_addresses;


--FONKSİYONLAR--

-- 1) calculate_order_total(order_id) - Sipariş toplam tutarını hesaplayan fonksiyon

create or replace function calculate_order_total(p_order_id INT)
returns numeric
language sql
as $$
    select sum(quantity * unit_price)
    from order_items
    where order_id = p_order_id;
$$;
--test sorgusu 
select calculate_order_total(2);

update order_items set quantity = 4 where order_id = 2; --miktarı güncelledim 

-- 2) customer_lifetime_value(customer_id) - Müşterinin toplam alışveriş tutarını hesaplayan fonksiyon

create or replace function customer_lifetime_value(p_customer_id INT)
returns numeric
language sql
as $$
    select coalesce(sum(oi.quantity * oi.unit_price), 0)
    from orders o
    join order_items oi on o.id = oi.order_id
    where o.customer_id = p_customer_id;
$$;

--test sorgusu
select customer_lifetime_value(4);

-- 3) stock_status(product_id) - Stok durumunu kontrol eden (Bol/Orta/Az/Tükendi) fonksiyon

create or replace function stock_status(p_product_id INT)
returns varchar
language plpgsql
as $$
DECLARE
    current_stock INT;
    status_text VARCHAR;
BEGIN
    -- Ürünün mevcut stok miktarını al
    select stock into current_stock
    from products
    where id = p_product_id;

    -- Eğer ürün yoksa
    if current_stock is null then
        raise exception 'Geçersiz ürün ID: %', p_product_id;
    end if;

    -- Stok durumunu belirle
    if current_stock >= 50 then
        status_text := 'Bol';
    elsif current_stock >= 20 then
        status_text := 'Orta';
    elsif current_stock >= 1 then
        status_text := 'Az';
    else
        status_text := 'Tükendi';
    end if;

    return status_text;
END;
$$;


-- Test sorgusu 

select stock_status(1);  
select stock_status(2);  
select stock_status(4);  
select stock_status(15);
SELECT stock_status(id) FROM products WHERE product_code = 'AU9001';


------------------------- TRIGGERLAR ----------------------

-- 1) Sipariş oluşturulduğunda stok miktarını düşüren trigger

CREATE OR REPLACE FUNCTION trg_decrease_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Yeni eklenen sipariş kalemindeki miktarı ürün stokundan düş
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;

    RETURN NEW;
END;
$$;


CREATE TRIGGER decrease_stock_after_insert
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION trg_decrease_stock();


--  Yeni bir sipariş oluştur
INSERT INTO orders (customer_id, order_date, status, total, shipping_address_id)
VALUES (1, NOW(), 'Pending', 0, 1)
RETURNING id;


-- Siparişe ürün ekleyerek stok düşüşünü tetikleyelim
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (55, 1, 2, 12000);


-- Test Sorgusu
SELECT stock FROM products WHERE id = 1;

---------------------------------------------------------------------

--2)Ürün fiyatı güncellendiğinde log tutan trigger

CREATE OR REPLACE FUNCTION trg_log_price_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.price <> OLD.price THEN
        INSERT INTO product_price_log (product_id, old_price, new_price, changed_at)
        VALUES (NEW.id, OLD.price, NEW.price, NOW());
    END IF;

    RETURN NEW;
END;
$$;


CREATE TRIGGER log_price_change
AFTER UPDATE OF price ON products
FOR EACH ROW
EXECUTE FUNCTION trg_log_price_change();

-- Test sorgusu
UPDATE products SET price = 26500 WHERE id = 3; -- Log oluşmalı
SELECT * FROM product_price_log WHERE product_id = 3;
---------------------------------------------------------------------------

-- 3) Sipariş iptal edildiğinde stokları geri yükleyen trigger

CREATE OR REPLACE FUNCTION trg_restore_stock_on_cancel()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Eğer sipariş durumu "Cancelled" olduysa ve eski durum "Cancelled" değilse
    IF NEW.status = 'Cancelled' AND OLD.status <> 'Cancelled' THEN
        -- Siparişe ait tüm ürünlerin stoklarını geri yükle
        UPDATE products p
        SET stock = stock + oi.quantity
        FROM order_items oi
        WHERE oi.product_id = p.id
          AND oi.order_id = NEW.id;
    END IF;

    RETURN NEW;
END;
$$;


CREATE TRIGGER restore_stock_on_cancel
AFTER UPDATE OF status ON orders
FOR EACH ROW
EXECUTE FUNCTION trg_restore_stock_on_cancel();

-- Test sorgusu
UPDATE orders SET status = 'Cancelled' WHERE id = 3;

-- Güncel stok durumunu kontrol et
SELECT p.id AS product_id, p.name, p.stock
FROM products p
JOIN order_items oi ON oi.product_id = p.id
WHERE oi.order_id = 3;

-----------------------------------------------------------------------------------------------------------------------


-- STORED PROCEDURE'LER--

--	1) sp_place_order() - Sipariş verme işlemi (stok kontrolü dahil)

DROP PROCEDURE IF EXISTS sp_place_order(INT, INT, INT, INT);

CREATE OR REPLACE PROCEDURE sp_place_order(
    p_customer_id INT,
    p_shipping_address_id INT,
    p_product_id INT,
    p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock INT;
    v_unit_price NUMERIC(10,2);
    v_order_id INT;
BEGIN
    -- Ürünün mevcut stok ve fiyatını al
    SELECT stock, price INTO v_stock, v_unit_price
    FROM products
    WHERE id = p_product_id;

    -- Stok kontrolü
    IF v_stock IS NULL THEN
        RAISE EXCEPTION 'Geçersiz ürün ID: %', p_product_id;
    ELSIF v_stock < p_quantity THEN
        RAISE EXCEPTION 'Yeterli stok yok. Mevcut stok: %', v_stock;
    END IF;

    -- Siparişi ekle
    INSERT INTO orders (customer_id, order_date, status, total, shipping_address_id)
    VALUES (p_customer_id, NOW(), 'Pending', 0, p_shipping_address_id)
    RETURNING id INTO v_order_id;

    -- Sipariş detayı ekle
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id, p_product_id, p_quantity, v_unit_price);

    -- Sipariş toplamını güncelle
    UPDATE orders
    SET total = calculate_order_total(v_order_id)
    WHERE id = v_order_id;

    
END;
$$;

-- Test sorgusu
CALL sp_place_order(1, 1, 1, 2);  -- Customer 1, Address 1, Product 1, 2 adet
--  Eklenen siparişi kontrol et
SELECT * FROM orders
WHERE customer_id = 1
ORDER BY id DESC
LIMIT 1;

SELECT * FROM order_items
WHERE order_id = (SELECT id FROM orders WHERE customer_id = 1 ORDER BY id DESC LIMIT 1);


SELECT stock FROM products WHERE id = 1;
SELECT stock_status(1);


-- 2) sp_cancel_order() - Sipariş iptal etme işlemi

CREATE OR REPLACE PROCEDURE sp_cancel_order(
    p_order_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status TEXT;
BEGIN
    -- Sipariş var mı kontrol et
    SELECT status INTO v_status
    FROM orders
    WHERE id = p_order_id;

    IF v_status IS NULL THEN
        RAISE EXCEPTION 'Geçersiz order_id: %', p_order_id;
    END IF;

    -- Zaten iptal edilmişse
    IF v_status = 'Cancelled' THEN
        RAISE EXCEPTION 'Bu sipariş zaten iptal edilmiş: %', p_order_id;
    END IF;

    -- Siparişi iptal et (stok geri yüklemeyi trigger yapıyor burada)
    UPDATE orders
    SET status = 'Cancelled'
    WHERE id = p_order_id;

    
    RAISE NOTICE 'Sipariş başarıyla iptal edildi. Order ID: %', p_order_id;

END;
$$;


-- Test Sorgusu

SELECT id, customer_id, status 
FROM orders 
ORDER BY id;

--  siparişin mevcut durumu
SELECT id, status FROM orders WHERE id = 47;

-- Siparişi iptal edelim
CALL sp_cancel_order(47);


--  sipariş durumunu tekrar kontrol edelim
SELECT id, status FROM orders WHERE id = 47;

SELECT order_id, product_id, quantity 
FROM order_items 
WHERE order_id = 47;

-- Stok geri yüklendi mi diye bakıyoruz
SELECT stock FROM products WHERE id = 1;
SELECT stock_status(1);


--- 4) VİEW SORGULARI -------------------------

-- 1) 	Kategorilere göre ürün satış istatistikleri

CREATE OR REPLACE VIEW category_sales_stats AS
SELECT 
    c.id AS category_id,
    c.name AS category_name,
    COUNT(oi.id) AS total_items_sold,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM categories c
LEFT JOIN products p ON p.category_id = c.id
LEFT JOIN order_items oi ON oi.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_sales DESC;

-- Test sorgusu
SELECT * FROM category_sales_stats;

-- 2)   Müşteri sipariş özeti (toplam sipariş, toplam tutar, ortalama sepet)

CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    cu.id AS customer_id,
    cu.first_name || ' ' || cu.last_name AS customer_name,
    COUNT(DISTINCT o.id) AS total_orders,
    COALESCE(SUM(o.total), 0) AS total_spent,
    CASE WHEN COUNT(DISTINCT o.id) = 0 THEN 0
         ELSE ROUND(SUM(o.total) / COUNT(DISTINCT o.id), 2)
    END AS average_order_value
FROM customers cu
LEFT JOIN orders o ON o.customer_id = cu.id
GROUP BY cu.id, cu.first_name, cu.last_name
ORDER BY total_spent DESC;

-- Test sorgusu
SELECT * FROM customer_order_summary;

--------------------------------------------------------------------------------------

-- 5. KOMPLEKS SORGULAR

-- 1)  En çok satan ürünler (TOP 10)

SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.name
ORDER BY total_quantity_sold DESC
LIMIT 10;

--2️ Kategorilere göre ortalama ürün fiyatları ve stok durumları

SELECT
    c.id AS category_id,
    c.name AS category_name,
    ROUND(AVG(p.price), 2) AS avg_price,
    SUM(p.stock) AS total_stock,
    CASE 
        WHEN SUM(p.stock) >= 50 THEN 'Bol'
        WHEN SUM(p.stock) >= 20 THEN 'Orta'
        WHEN SUM(p.stock) >= 1 THEN 'Az'
        ELSE 'Tükendi'
    END AS stock_status
FROM categories c
JOIN products p ON c.id = p.category_id
GROUP BY c.id, c.name
ORDER BY avg_price DESC;

-- 3️) Subquery ile: Ortalama sipariş tutarından yüksek siparişler

SELECT
    o.id AS order_id,
    o.customer_id,
    o.total AS order_total
FROM orders o
WHERE o.total > (
    SELECT AVG(total) FROM orders
);