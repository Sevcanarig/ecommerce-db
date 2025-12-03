# 🛒 E-Ticaret Veritabanı Projesi

Bu proje, **PostgreSQL** kullanılarak geliştirilmiş bir **e-ticaret veritabanı çözümüdür**. Veritabanı, ürün yönetimi, sipariş takip ve müşteri işlemleri gibi temel e-ticaret operasyonlarını yönetmeyi hedeflemektedir. Ayrıca **stok kontrolü, sipariş iptali ve fiyat değişikliği takibi** gibi işlemler **otomatikleştirilmiş** trigger ve stored procedure’ler sayesinde yapılmaktadır.

---

## ✨ Özellikler

- **Kategoriler ve Ürünler:**  
  Ürünler kategorilere göre sınıflandırılmış, fiyat ve stok bilgileri tutulmaktadır.

- **Müşteriler ve Teslimat Adresleri:**  
  Müşteri bilgileri ve teslimat adresleri kayıt altında.

- **Sipariş Yönetimi:**  
  Sipariş oluşturma, iptal etme ve detayları takip etme.

- **Otomatik Stok Yönetimi:**  
  - Sipariş eklendiğinde stok otomatik düşer.  
  - Sipariş iptal edilirse stok geri yüklenir.

- **Fiyat Takibi:**  
  Ürün fiyatları değiştiğinde otomatik log kaydı tutulur.

- **Fonksiyonlar:**  
  - `calculate_order_total(order_id)` → Sipariş toplamını hesaplar  
  - `customer_lifetime_value(customer_id)` → Müşterinin toplam harcaması  
  - `stock_status(product_id)` → Stok durumu: Bol / Orta / Az / Tükendi

- **Stored Procedure’ler:**  
  - `sp_place_order()` → Stok kontrolü ile sipariş oluşturma  
  - `sp_cancel_order()` → Sipariş iptali ve stok geri yükleme

---

## 📦 Tablolar

| Tablo Adı | Açıklama |
|------------|----------|
| `categories` | Ürün kategorileri |
| `products` | Ürün bilgileri |
| `customers` | Müşteri bilgileri |
| `shipping_addresses` | Teslimat adresleri |
| `orders` | Sipariş bilgileri |
| `order_items` | Sipariş detayları |
| `reviews` | Ürün yorumları |
| `product_price_log` | Fiyat değişiklik kayıtları |

---

## 📊 View’lar

- `category_sales_stats` → Kategorilere göre satış istatistikleri  
- `customer_order_summary` → Müşteri sipariş özetleri  

---

## ⚡ Kurulum

1. PostgreSQL sunucusuna bağlanın.
2. SQL dosyasını çalıştırarak tüm tablolar, trigger’lar, stored procedure’ler ve view’ları oluşturun.
3. Test verileri ile sistemin çalışmasını kontrol edin:

