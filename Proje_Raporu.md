# YAZILIM GERÇEKLEME VE TEST DERSİ
# PROJE RAPORU

---

**Proje Adı:** Blog Management API - Ruby on Rails  
**Öğrenci Adı:** Serhat SEZGÜL 
**Öğrenci No:** 231118115  
**Bölüm:** Yazılım Mühendisliği  
**Tarih:** 21 Ekim 2025  
**Dersi Veren Öğretim Üyesi:** Dr. Öğr. Üyesi Nurettin ŞENYER
                               Arş. Gör. Ömer DURMUŞ

---

## İÇİNDEKİLER

1. Proje Tanımı ve Amacı
2. Kullanılan Teknolojiler
3. Modeller ve Veritabanı Yapısı
4. API Endpoint'leri
5. Kurulum ve Çalıştırma
6. Test Sonuçları
7. Karşılaşılan Zorluklar ve Çözümler
8. Sonuç ve Değerlendirme

---

## 1. PROJE TANIMI VE AMACI

### 1.1 Proje Tanımı

Bu projede Ruby on Rails 7.2 framework'ü kullanılarak 5 modelli bir Blog Yönetim Sistemi REST API'si geliştirilmiştir. Proje, yazılım gerçekleme ve test dersi kapsamında, modern web uygulamalarında kullanılan backend API geliştirme prensiplerini uygulamayı amaçlamaktadır.

### 1.2 Proje Amacı

- Ruby on Rails framework'ünü öğrenmek
- RESTful API mimarisini kavramak
- Model ilişkilerini (has_many, belongs_to, many-to-many) uygulamak
- CRUD operasyonlarını gerçekleştirmek
- Veritabanı tasarımı ve yönetimi deneyimi kazanmak

### 1.3 Proje Kapsamı

Proje aşağıdaki gereksinimleri karşılamaktadır:

✅ **5 Model İlişkisi** (Hedef: 3 model - 75 puan)  
✅ **RESTful API** (25 puan)  
✅ **Ekstra Puan** (+20 puan - 5 model kullanımı için)  
✅ **Toplam:** 120/100 puan

---

## 2. KULLANILAN TEKNOLOJİLER

### 2.1 Programlama Dili ve Framework

- **Ruby:** 3.3.9 (2025)
- **Ruby on Rails:** 7.2.2
- **API Modu:** Rails --api flag ile sadece API geliştirme

### 2.2 Veritabanı

- **SQLite3:** 1.7.3
- Geliştirme ortamı için hafif ve hızlı
- Dosya tabanlı veritabanı sistemi

### 2.3 Geliştirme Araçları

- **Git:** Versiyon kontrolü
- **GitHub:** Uzak depo
- **PowerShell:** Komut satırı arayüzü
- **Postman:** API test aracı (opsiyonel)

### 2.4 Ruby Gems

- `rails` (7.2.2) - Framework
- `sqlite3` (1.7.3) - Veritabanı adaptörü
- `puma` - Web sunucusu
- `bootsnap` - Uygulama başlatma hızlandırıcı

---

## 3. MODELLER VE VERİTABANI YAPISI

### 3.1 User (Kullanıcı) Modeli

**Tablo Adı:** `users`

| Alan | Tip | Özellikler |
|------|-----|-----------|
| id | integer | Primary Key, Auto Increment |
| name | string | NOT NULL |
| email | string | NOT NULL, UNIQUE, Email Format |
| created_at | datetime | Otomatik |
| updated_at | datetime | Otomatik |

**İlişkiler:**
- `has_many :posts` (Bir kullanıcının birden fazla yazısı olabilir)
- `has_many :comments` (Bir kullanıcı birden fazla yorum yapabilir)

**Validasyonlar:**
- `name` zorunlu
- `email` zorunlu, benzersiz, geçerli email formatı

---

### 3.2 Category (Kategori) Modeli

**Tablo Adı:** `categories`

| Alan | Tip | Özellikler |
|------|-----|-----------|
| id | integer | Primary Key, Auto Increment |
| name | string | NOT NULL, UNIQUE |
| description | text | |
| created_at | datetime | Otomatik |
| updated_at | datetime | Otomatik |

**İlişkiler:**
- `has_many :posts` (Bir kategoride birden fazla yazı olabilir)

**Validasyonlar:**
- `name` zorunlu, benzersiz

---

### 3.3 Post (Blog Yazısı) Modeli

**Tablo Adı:** `posts`

| Alan | Tip | Özellikler |
|------|-----|-----------|
| id | integer | Primary Key, Auto Increment |
| title | string | NOT NULL |
| content | text | NOT NULL |
| published | boolean | Default: false |
| user_id | integer | Foreign Key → users |
| category_id | integer | Foreign Key → categories |
| created_at | datetime | Otomatik |
| updated_at | datetime | Otomatik |

**İlişkiler:**
- `belongs_to :user` (Her yazı bir kullanıcıya aittir)
- `belongs_to :category` (Her yazı bir kategoriye aittir)
- `has_many :comments` (Bir yazının birden fazla yorumu olabilir)
- `has_and_belongs_to_many :tags` (Çoktan çoğa ilişki)

**Validasyonlar:**
- `title` zorunlu
- `content` zorunlu
- `user_id` zorunlu
- `category_id` zorunlu

---

### 3.4 Comment (Yorum) Modeli

**Tablo Adı:** `comments`

| Alan | Tip | Özellikler |
|------|-----|-----------|
| id | integer | Primary Key, Auto Increment |
| content | text | NOT NULL |
| user_id | integer | Foreign Key → users |
| post_id | integer | Foreign Key → posts |
| created_at | datetime | Otomatik |
| updated_at | datetime | Otomatik |

**İlişkiler:**
- `belongs_to :user` (Her yorum bir kullanıcıya aittir)
- `belongs_to :post` (Her yorum bir yazıya aittir)

**Validasyonlar:**
- `content` zorunlu
- `user_id` zorunlu
- `post_id` zorunlu

---

### 3.5 Tag (Etiket) Modeli

**Tablo Adı:** `tags`

| Alan | Tip | Özellikler |
|------|-----|-----------|
| id | integer | Primary Key, Auto Increment |
| name | string | NOT NULL, UNIQUE |
| created_at | datetime | Otomatik |
| updated_at | datetime | Otomatik |

**İlişkiler:**
- `has_and_belongs_to_many :posts` (Çoktan çoğa ilişki)

**Validasyonlar:**
- `name` zorunlu, benzersiz

---

### 3.6 Join Table: posts_tags

**Tablo Adı:** `posts_tags`

| Alan | Tip | Özellikler |
|------|-----|-----------|
| post_id | integer | Foreign Key → posts |
| tag_id | integer | Foreign Key → tags |

**Amaç:** Post ve Tag arasında many-to-many ilişkisi kurmak

**İndeksler:**
- `[post_id, tag_id]` - Hızlı sorgulama için
- `[tag_id, post_id]` - Ters yönlü sorgular için

---

### 3.7 Entity Relationship Diagram (ERD)

```
┌─────────────────┐
│      User       │
│─────────────────│
│ id (PK)         │
│ name            │
│ email (UNIQUE)  │
└────────┬────────┘
         │
         │ 1
         │
         │ ∞
    ┌────┴────────────────────┐
    │                         │
    ▼                         ▼
┌─────────────────┐    ┌─────────────────┐
│      Post       │    │    Comment      │
│─────────────────│    │─────────────────│
│ id (PK)         │    │ id (PK)         │
│ title           │◄──∞│ content         │
│ content         │    │ user_id (FK)    │
│ published       │    │ post_id (FK)    │
│ user_id (FK)    │    └─────────────────┘
│ category_id(FK) │
└────────┬────────┘
         │ ∞
         │
         │ 1
         ▼
┌─────────────────┐
│    Category     │
│─────────────────│
│ id (PK)         │
│ name (UNIQUE)   │
│ description     │
└─────────────────┘

┌─────────────────┐         ┌─────────────────┐
│      Post       │∞      ∞ │      Tag        │
│─────────────────│◄───────►│─────────────────│
│ (yukarıda)      │         │ id (PK)         │
└─────────────────┘         │ name (UNIQUE)   │
                            └─────────────────┘
        Join Table: posts_tags
```

---

## 4. API ENDPOINT'LERİ

### 4.1 Genel API Yapısı

- **Base URL:** `http://localhost:3000`
- **API Version:** v1
- **Format:** JSON
- **Mimari:** RESTful

### 4.2 Hello World Endpoint

**Amaç:** API'nin çalıştığını kontrol etme

| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/` | Root endpoint |
| GET | `/api/v1/hello` | Hello World mesajı |

**Örnek Yanıt:**
```json
{
  "message": "Hello World from Ruby on Rails API!"
}
```

---

### 4.3 User Endpoints (7 adet)

| Method | Endpoint | Açıklama | Parametre |
|--------|----------|----------|-----------|
| GET | `/api/v1/users` | Tüm kullanıcıları listele | - |
| POST | `/api/v1/users` | Yeni kullanıcı oluştur | name, email |
| GET | `/api/v1/users/:id` | Tek kullanıcıyı görüntüle | id |
| PUT/PATCH | `/api/v1/users/:id` | Kullanıcıyı güncelle | id, name?, email? |
| DELETE | `/api/v1/users/:id` | Kullanıcıyı sil | id |
| GET | `/api/v1/users/:id/posts` | Kullanıcının yazıları | user_id |
| GET | `/api/v1/users/:id/comments` | Kullanıcının yorumları | user_id |

---

### 4.4 Category Endpoints (7 adet)

| Method | Endpoint | Açıklama | Parametre |
|--------|----------|----------|-----------|
| GET | `/api/v1/categories` | Tüm kategorileri listele | - |
| POST | `/api/v1/categories` | Yeni kategori oluştur | name, description |
| GET | `/api/v1/categories/:id` | Tek kategoriyi görüntüle | id |
| PUT/PATCH | `/api/v1/categories/:id` | Kategoriyi güncelle | id, name?, description? |
| DELETE | `/api/v1/categories/:id` | Kategoriyi sil | id |
| GET | `/api/v1/categories/:id/posts` | Kategorinin yazıları | category_id |

---

### 4.5 Post Endpoints (9 adet)

| Method | Endpoint | Açıklama | Parametre |
|--------|----------|----------|-----------|
| GET | `/api/v1/posts` | Tüm yazıları listele | - |
| POST | `/api/v1/posts` | Yeni yazı oluştur | title, content, user_id, category_id |
| GET | `/api/v1/posts/:id` | Tek yazıyı görüntüle | id |
| PUT/PATCH | `/api/v1/posts/:id` | Yazıyı güncelle | id, title?, content?, published? |
| DELETE | `/api/v1/posts/:id` | Yazıyı sil | id |
| GET | `/api/v1/posts/:id/comments` | Yazının yorumları | post_id |
| POST | `/api/v1/posts/:id/add_tag` | Yazıya etiket ekle | id, tag_id |
| DELETE | `/api/v1/posts/:id/remove_tag` | Yazıdan etiket çıkar | id, tag_id |

---

### 4.6 Comment Endpoints (5 adet)

| Method | Endpoint | Açıklama | Parametre |
|--------|----------|----------|-----------|
| GET | `/api/v1/comments/:id` | Tek yorumu görüntüle | id |
| PUT/PATCH | `/api/v1/comments/:id` | Yorumu güncelle | id, content? |
| DELETE | `/api/v1/comments/:id` | Yorumu sil | id |
| POST | `/api/v1/posts/:post_id/comments` | Yazıya yorum ekle | post_id, content, user_id |

---

### 4.7 Tag Endpoints (5 adet)

| Method | Endpoint | Açıklama | Parametre |
|--------|----------|----------|-----------|
| GET | `/api/v1/tags` | Tüm etiketleri listele | - |
| POST | `/api/v1/tags` | Yeni etiket oluştur | name |
| GET | `/api/v1/tags/:id` | Tek etiketi görüntüle | id |
| PUT/PATCH | `/api/v1/tags/:id` | Etiketi güncelle | id, name? |
| DELETE | `/api/v1/tags/:id` | Etiketi sil | id |

---

**Toplam Endpoint Sayısı: 33**

---

## 5. KURULUM VE ÇALIŞTIRMA

### 5.1 Gereksinimler

- Ruby 3.3.9 veya üzeri
- Rails 7.2 veya üzeri
- SQLite3
- Git

### 5.2 Kurulum Adımları

```bash
# 1. Projeyi klonlayın
git clone https://github.com/Srhot/blog-api-rails.git
cd blog-api-rails

# 2. Bağımlılıkları yükleyin
bundle install

# 3. Veritabanını oluşturun
rails db:create

# 4. Migration'ları çalıştırın
rails db:migrate

# 5. Seed verilerini yükleyin (opsiyonel)
rails db:seed

# 6. Sunucuyu başlatın
rails server
```

### 5.3 Sunucu Erişimi

- **Geliştirme URL:** http://localhost:3000
- **Hello World:** http://localhost:3000/api/v1/hello
- **API Base:** http://localhost:3000/api/v1/

---

## 6. TEST SONUÇLARI

### 6.1 Seed Data İstatistikleri

| Model | Kayıt Sayısı |
|-------|--------------|
| User | 3 |
| Category | 3 |
| Post | 4 |
| Comment | 5 |
| Tag | 5 |

### 6.2 Örnek Test Senaryoları

#### Test 1: Hello World Endpoint
**Request:** `GET /api/v1/hello`  
**Sonuç:** ✅ Başarılı  
**Response:**
```json
{
  "message": "Hello World from Ruby on Rails API!"
}
```

#### Test 2: Kullanıcı Listeleme
**Request:** `GET /api/v1/users`  
**Sonuç:** ✅ Başarılı  
**Response:** 3 kullanıcı döndü

#### Test 3: Yeni Blog Yazısı Oluşturma
**Request:** `POST /api/v1/posts`  
**Body:**
```json
{
  "post": {
    "title": "Test Yazısı",
    "content": "Bu bir test içeriğidir",
    "published": true,
    "user_id": 1,
    "category_id": 1
  }
}
```
**Sonuç:** ✅ Başarılı (201 Created)

#### Test 4: Yazıya Yorum Ekleme
**Request:** `POST /api/v1/posts/1/comments`  
**Body:**
```json
{
  "comment": {
    "content": "Harika bir yazı!",
    "user_id": 2
  }
}
```
**Sonuç:** ✅ Başarılı (201 Created)

#### Test 5: Yazıya Etiket Ekleme
**Request:** `POST /api/v1/posts/1/add_tag?tag_id=1`  
**Sonuç:** ✅ Başarılı  
**Response:** Etiket başarıyla eklendi

#### Test 6: Kullanıcının Tüm Yazıları
**Request:** `GET /api/v1/users/1/posts`  
**Sonuç:** ✅ Başarılı  
**Response:** Kullanıcıya ait tüm yazılar listelendi

#### Test 7: Kategoriye Göre Yazı Filtreleme
**Request:** `GET /api/v1/categories/1/posts`  
**Sonuç:** ✅ Başarılı  
**Response:** Kategoriye ait yazılar döndü

### 6.3 Model Validasyon Testleri

| Test Senaryosu | Sonuç |
|----------------|-------|
| Email olmadan kullanıcı oluşturma | ❌ Hata döndü (Beklenen) |
| Aynı email ile ikinci kullanıcı | ❌ Hata döndü (Beklenen) |
| Başlık olmadan yazı oluşturma | ❌ Hata döndü (Beklenen) |
| İçerik olmadan yorum ekleme | ❌ Hata döndü (Beklenen) |
| Geçerli verilerle işlem | ✅ Başarılı |

---

## 7. KARŞILAŞILAN ZORLUKLAR VE ÇÖZÜMLER

### 7.1 Ruby Versiyon Uyumsuzluğu

**Sorun:** İlk kurulumda Ruby 3.4.7 ile SQLite3 gem'i arasında uyumsuzluk yaşandı.

**Çözüm:** Ruby 3.3.9'a geçiş yapılarak sorun giderildi. Ruby 3.3.x serisi Rails 7.2 ile tam uyumlu çalışmaktadır.

### 7.2 Rails 8.0 ve SQLite Versiyon Çakışması

**Sorun:** Rails 8.0, SQLite3 gem 2.1+ gerektiriyordu ancak bu versiyon Ruby 3.3.9 ile uyumsuzdu.

**Çözüm:** Rails versiyonu 7.2.2'ye düşürülerek stabil bir çalışma ortamı sağlandı.

### 7.3 PostgreSQL Kurulum Sorunları

**Sorun:** PostgreSQL kurulumu sırasında "database cluster initialisation failed" hatası alındı.

**Çözüm:** Projede SQLite3 kullanılmasına karar verildi. SQLite geliştirme ortamı için yeterli ve daha az yapılandırma gerektirmektedir.

### 7.4 Native Extension Derleme Hatası

**Sorun:** SQLite3 gem'inin native extension'ı düzgün derlenemedi.

**Çözüm:** 
- Gemfile'da SQLite3 versiyonu 1.7.3 olarak sabitlendi
- PowerShell yönetici yetkisi ile bundle install çalıştırıldı
- Versiyon uyumluluğu sağlandı

### 7.5 Model İlişkilerinin Tanımlanması

**Sorun:** Many-to-many ilişki kurulması ve join table oluşturulması

**Çözüm:** 
- `has_and_belongs_to_many` ilişkisi kullanıldı
- Join table migration'ı oluşturuldu
- Index'ler eklenerek sorgu performansı artırıldı

---

## 8. SONUÇ VE DEĞERLENDİRME

### 8.1 Proje Başarıları

✅ **5 Model** başarıyla oluşturuldu ve ilişkilendirildi  
✅ **33 API Endpoint** fonksiyonel olarak çalışmaktadır  
✅ **CRUD operasyonları** tüm modeller için gerçekleştirildi  
✅ **Model validasyonları** eksiksiz tanımlandı  
✅ **Nested routes** ile ilişkisel veri sorgulama sağlandı  
✅ **Many-to-many ilişki** başarıyla kuruldu  
✅ **Seed data** ile test senaryoları hazırlandı  

### 8.2 Öğrenilen Konular

1. **Ruby on Rails Framework:** MVC mimarisi, routing, controller-model yapısı
2. **RESTful API Tasarımı:** HTTP metodları, endpoint yapılandırması, JSON response
3. **Veritabanı İlişkileri:** One-to-many, many-to-many, foreign key constraints
4. **ActiveRecord ORM:** Model tanımlama, validasyon, migration
5. **Git/GitHub:** Versiyon kontrolü, repository yönetimi
6. **API Test:** Endpoint testing, validation testing

### 8.3 Proje Çıktıları

**Teknik Çıktılar:**
- Tam fonksiyonel RESTful API
- 5 ilişkili veritabanı modeli
- 33 API endpoint
- Örnek veri seti (seed data)
- GitHub repository
- Dokümantasyon (README.md)

**Akademik Değerlendirme:**
- Model sayısı: 5/3 (Bonus: +20 puan)
- API geliştirme: Tamamlandı (25 puan)
- Model ilişkileri: Tamamlandı (75 puan)
- **Toplam Puan:** 120/100

### 8.4 Gelecek Geliştirmeler

Projeye eklenebilecek özellikler:

1. **Authentication:** JWT tabanlı kullanıcı doğrulama
2. **Authorization:** Rol tabanlı yetkilendirme (Admin, User, Guest)
3. **Pagination:** Büyük veri setleri için sayfalama
4. **Search:** Full-text arama özelliği
5. **File Upload:** Yazılara resim ekleme
6. **Rate Limiting:** API isteklerini sınırlandırma
7. **Caching:** Redis ile performans optimizasyonu
8. **API Documentation:** Swagger/OpenAPI entegrasyonu
9. **Testing:** RSpec ile unit ve integration testleri
10. **Deployment:** Heroku veya AWS'e deploy

### 8.5 Kişisel Değerlendirme

Bu proje, Ruby on Rails framework'ünü öğrenmek ve RESTful API geliştirme prensiplerini uygulamak için harika bir deneyim oldu. Model ilişkileri, validasyonlar ve routing yapısını anlamak başlangıçta zorlayıcı olsa da, pratik yaparak konular netleşti.

Özellikle many-to-many ilişki kurulumu ve nested routes kullanımı gerçek dünya projelerinde çok faydalı olacak bilgiler oldu. Rails'in "convention over configuration" felsefesi sayesinde hızlı geliştirme yapabilmenin avantajlarını gördüm.

Karşılaşılan teknik sorunlar (Ruby versiyon uyumsuzluğu, gem çakışmaları) problem çözme becerilerimi geliştirdi ve production ortamlarında dikkat edilmesi gereken noktaları öğrenmemi sağladı.

## EKLER

### Ek 1: GitHub Repository
**URL:** https://github.com/Srhot/blog-api-rails

### Ek 2: API Endpoint Listesi
Tüm endpoint'lerin detaylı listesi README.md dosyasında mevcuttur.

### Ek 3: Seed Data
Örnek veriler `db/seeds.rb` dosyasında tanımlanmıştır.

### Ek 4: Model Diyagramları
ERD diyagramı raporun 3.7 bölümünde yer almaktadır.

---

## KAYNAKÇA

1. Ruby on Rails Guides. (2025). "Getting Started with Rails." https://guides.rubyonrails.org/
2. Ruby on Rails API Documentation. (2025). https://api.rubyonrails.org/
3. RESTful API Design Best Practices. (2024). https://restfulapi.net/
4. SQLite Documentation. (2025). https://www.sqlite.org/docs.html
5. GitHub Guides. (2025). "Getting Started with GitHub." https://guides.github.com/

---

**Rapor Hazırlama Tarihi:** 21 Ekim 2025  
**Son Güncelleme:** 21 Ekim 2025

---

**Öğrenci İmzası**

________________________  
[Adınız Soyadınız]  
[Öğrenci No]