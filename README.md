# 📝 Blog Management API - Ruby on Rails

## 🎯 Proje Hakkında

Bu proje, **Ruby on Rails 7.2** ile geliştirilmiş, **5 model** içeren **RESTful API** uygulamasıdır. Yazılım Gerçekleme ve Test dersi kapsamında geliştirilmiştir.

### Özellikler

- ✅ **5 Model İlişkisi** (User, Category, Post, Comment, Tag)
- ✅ **RESTful API** endpoint'leri
- ✅ **CRUD** operasyonları (Create, Read, Update, Delete)
- ✅ **Model Validasyonları**
- ✅ **Nested Resources** (İlişkisel veri sorgulama)
- ✅ **Many-to-Many İlişki** (Post ↔ Tag)

---

## 📊 Veritabanı Modelleri

### 1. **User** (Kullanıcı)
- `name`: string
- `email`: string (unique)
- İlişkiler: `has_many :posts, :comments`

### 2. **Category** (Kategori)
- `name`: string
- `description`: text
- İlişkiler: `has_many :posts`

### 3. **Post** (Blog Yazısı)
- `title`: string
- `content`: text
- `published`: boolean
- İlişkiler: `belongs_to :user, :category` | `has_many :comments` | `has_and_belongs_to_many :tags`

### 4. **Comment** (Yorum)
- `content`: text
- İlişkiler: `belongs_to :user, :post`

### 5. **Tag** (Etiket)
- `name`: string
- İlişkiler: `has_and_belongs_to_many :posts`

---

## 🔗 Entity Relationship Diagram (ERD)

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│    User     │1      ∞ │     Post     │∞      1 │  Category   │
│─────────────│◄────────│──────────────│────────►│─────────────│
│ id          │         │ id           │         │ id          │
│ name        │         │ title        │         │ name        │
│ email       │         │ content      │         │ description │
└─────────────┘         │ published    │         └─────────────┘
       │                │ user_id      │
       │                │ category_id  │
       │                └──────────────┘
       │                       │
       │                       │∞
       │                       ▼
       │                ┌──────────────┐
       │             ∞  │   Comment    │
       └───────────────►│──────────────│
                        │ id           │
                        │ content      │
                        │ user_id      │
                        │ post_id      │
                        └──────────────┘

       ┌──────────────┐         ┌─────────────┐
       │     Post     │∞      ∞ │     Tag     │
       │──────────────│◄───────►│─────────────│
       │ (yukarıda)   │         │ id          │
       └──────────────┘         │ name        │
                                └─────────────┘
```

---

## 🚀 Kurulum

### Gereksinimler

- Ruby 3.3.9
- Rails 7.2
- SQLite3

### Adımlar

```bash
# Depoyu klonlayın
git clone https://github.com/Srhot/blog-api-rails.git
cd blog-api-rails

# Bağımlılıkları yükleyin
bundle install

# Veritabanını oluşturun
rails db:create
rails db:migrate

# (Opsiyonel) Örnek verileri yükleyin
rails db:seed

# Sunucuyu başlatın
rails server
```

Uygulama `http://localhost:3000` adresinde çalışacaktır.

---

## 📡 API Endpoint'leri

### Hello World
```
GET /api/v1/hello
GET /
```

**Yanıt:**
```json
{
  "message": "Hello World from Ruby on Rails API!"
}
```

### Users (Kullanıcılar)
```
GET    /api/v1/users           # Tüm kullanıcıları listele
POST   /api/v1/users           # Yeni kullanıcı oluştur
GET    /api/v1/users/:id       # Tek kullanıcıyı görüntüle
PUT    /api/v1/users/:id       # Kullanıcıyı güncelle
DELETE /api/v1/users/:id       # Kullanıcıyı sil
GET    /api/v1/users/:id/posts # Kullanıcının tüm yazıları
```

### Categories (Kategoriler)
```
GET    /api/v1/categories           # Tüm kategorileri listele
POST   /api/v1/categories           # Yeni kategori oluştur
GET    /api/v1/categories/:id       # Tek kategoriyi görüntüle
PUT    /api/v1/categories/:id       # Kategoriyi güncelle
DELETE /api/v1/categories/:id       # Kategoriyi sil
GET    /api/v1/categories/:id/posts # Kategorinin tüm yazıları
```

### Posts (Blog Yazıları)
```
GET    /api/v1/posts                # Tüm yazıları listele
POST   /api/v1/posts                # Yeni yazı oluştur
GET    /api/v1/posts/:id            # Tek yazıyı görüntüle
PUT    /api/v1/posts/:id            # Yazıyı güncelle
DELETE /api/v1/posts/:id            # Yazıyı sil
GET    /api/v1/posts/:id/comments   # Yazının tüm yorumları
POST   /api/v1/posts/:id/add_tag    # Yazıya etiket ekle
DELETE /api/v1/posts/:id/remove_tag # Yazıdan etiket çıkar
```

### Comments (Yorumlar)
```
GET    /api/v1/comments/:id             # Tek yorumu görüntüle
PUT    /api/v1/comments/:id             # Yorumu güncelle
DELETE /api/v1/comments/:id             # Yorumu sil
POST   /api/v1/posts/:post_id/comments  # Yazıya yeni yorum ekle
```

### Tags (Etiketler)
```
GET    /api/v1/tags        # Tüm etiketleri listele
POST   /api/v1/tags        # Yeni etiket oluştur
GET    /api/v1/tags/:id    # Tek etiketi görüntüle
PUT    /api/v1/tags/:id    # Etiketi güncelle
DELETE /api/v1/tags/:id    # Etiketi sil
```

---

## 📋 Örnek İstekler

### Yeni Kullanıcı Oluşturma
```bash
curl -X POST http://localhost:3000/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"user": {"name": "Ahmet Yılmaz", "email": "ahmet@example.com"}}'
```

**Yanıt:**
```json
{
  "id": 1,
  "name": "Ahmet Yılmaz",
  "email": "ahmet@example.com",
  "created_at": "2025-10-21T12:00:00.000Z",
  "updated_at": "2025-10-21T12:00:00.000Z"
}
```

### Yeni Blog Yazısı Oluşturma
```bash
curl -X POST http://localhost:3000/api/v1/posts \
  -H "Content-Type: application/json" \
  -d '{"post": {"title": "İlk Yazım", "content": "Merhaba Dünya!", "published": true, "user_id": 1, "category_id": 1}}'
```

### Yazıya Yorum Ekleme
```bash
curl -X POST http://localhost:3000/api/v1/posts/1/comments \
  -H "Content-Type: application/json" \
  -d '{"comment": {"content": "Harika yazı!", "user_id": 2}}'
```

### Yazıya Etiket Ekleme
```bash
curl -X POST http://localhost:3000/api/v1/posts/1/add_tag?tag_id=1
```

---

## 🧪 Test

```bash
# Rails console'da test
rails console

# Örnek komutlar:
> User.count          # Kullanıcı sayısı
> Post.all            # Tüm yazılar
> User.first.posts    # İlk kullanıcının yazıları
> Post.first.comments # İlk yazının yorumları

# Routes kontrolü
rails routes

# Testleri çalıştır
rails test
```

---

## 📁 Proje Yapısı

```
blog_api/
├── app/
│   ├── controllers/
│   │   └── api/
│   │       └── v1/
│   │           ├── hello_controller.rb
│   │           ├── users_controller.rb
│   │           ├── categories_controller.rb
│   │           ├── posts_controller.rb
│   │           ├── comments_controller.rb
│   │           └── tags_controller.rb
│   └── models/
│       ├── user.rb
│       ├── category.rb
│       ├── post.rb
│       ├── comment.rb
│       └── tag.rb
├── config/
│   ├── routes.rb
│   └── database.yml
├── db/
│   ├── migrate/
│   │   ├── create_users.rb
│   │   ├── create_categories.rb
│   │   ├── create_posts.rb
│   │   ├── create_comments.rb
│   │   ├── create_tags.rb
│   │   └── create_join_table_posts_tags.rb
│   └── seeds.rb
├── Gemfile
└── README.md
```

---

## 🎓 Model Validasyonları

### User Model
- `name`: zorunlu
- `email`: zorunlu, benzersiz, geçerli email formatı

### Category Model
- `name`: zorunlu, benzersiz

### Post Model
- `title`: zorunlu
- `content`: zorunlu
- `user_id`: zorunlu (foreign key)
- `category_id`: zorunlu (foreign key)

### Comment Model
- `content`: zorunlu
- `user_id`: zorunlu (foreign key)
- `post_id`: zorunlu (foreign key)

### Tag Model
- `name`: zorunlu, benzersiz

---

## 📊 Veritabanı Seed Data

Proje, örnek verilerle birlikte gelir:

- **3 Kullanıcı:** Ahmet Yılmaz, Ayşe Demir, Mehmet Kaya
- **3 Kategori:** Teknoloji, Yaşam, Seyahat
- **4 Blog Yazısı:** Rails, AI, Sağlık, Kapadokya
- **5 Yorum:** Çeşitli yazılara yapılmış yorumlar
- **5 Etiket:** Ruby, Rails, AI, Sağlık, Türkiye

Seed verilerini yüklemek için:
```bash
rails db:seed
```

---

## 👨‍💻 Geliştirici

**Serhat Sezgül**  
Yazılım Gerçekleme ve Test Dersi  
Samsun Üniversitesi - 2025

**GitHub:** https://github.com/Srhot 
**LinkedIn:** https://www.linkedin.com/in/serhat-sezgul/

---


## 📝 Lisans

Bu proje eğitim amaçlı geliştirilmiştir.

---

