# Veritabanını temizle
User.destroy_all
Category.destroy_all
Post.destroy_all
Comment.destroy_all
Tag.destroy_all

puts "Veritabanı temizlendi..."

# Kullanıcılar oluştur
user1 = User.create!(name: "Ahmet Yılmaz", email: "ahmet@example.com")
user2 = User.create!(name: "Ayşe Demir", email: "ayse@example.com")
user3 = User.create!(name: "Mehmet Kaya", email: "mehmet@example.com")

puts "✅ #{User.count} kullanıcı oluşturuldu"

# Kategoriler oluştur
tech = Category.create!(name: "Teknoloji", description: "Teknoloji haberleri ve makaleler")
lifestyle = Category.create!(name: "Yaşam", description: "Yaşam tarzı ve sağlık")
travel = Category.create!(name: "Seyahat", description: "Gezi yazıları ve tavsiyeleri")

puts "✅ #{Category.count} kategori oluşturuldu"

# Etiketler oluştur
ruby_tag = Tag.create!(name: "Ruby")
rails_tag = Tag.create!(name: "Rails")
ai_tag = Tag.create!(name: "AI")
health_tag = Tag.create!(name: "Sağlık")
turkey_tag = Tag.create!(name: "Türkiye")

puts "✅ #{Tag.count} etiket oluşturuldu"

# Blog yazıları oluştur
post1 = Post.create!(
  title: "Ruby on Rails ile API Geliştirme",
  content: "Ruby on Rails, modern web uygulamaları ve API'ler geliştirmek için harika bir framework'tür. RESTful API'ler oluşturmak çok kolay...",
  published: true,
  user: user1,
  category: tech
)
post1.tags << [ruby_tag, rails_tag]

post2 = Post.create!(
  title: "Yapay Zeka ve Geleceği",
  content: "Yapay zeka teknolojisi her geçen gün gelişiyor. ChatGPT, DALL-E gibi araçlar hayatımızı değiştiriyor...",
  published: true,
  user: user2,
  category: tech
)
post2.tags << ai_tag

post3 = Post.create!(
  title: "Sağlıklı Yaşam İçin 10 İpucu",
  content: "Sağlıklı bir yaşam için düzenli egzersiz, dengeli beslenme ve yeterli uyku çok önemlidir...",
  published: true,
  user: user2,
  category: lifestyle
)
post3.tags << health_tag

post4 = Post.create!(
  title: "Kapadokya Gezi Rehberi",
  content: "Kapadokya, Türkiye'nin en güzel turistik bölgelerinden biri. Balon turları, peribacaları ve yeraltı şehirleri mutlaka görülmeli...",
  published: true,
  user: user3,
  category: travel
)
post4.tags << turkey_tag

puts "✅ #{Post.count} blog yazısı oluşturuldu"

# Yorumlar oluştur
Comment.create!(
  content: "Harika bir yazı, çok faydalı oldu!",
  user: user2,
  post: post1
)

Comment.create!(
  content: "Ruby on Rails gerçekten çok güçlü bir framework.",
  user: user3,
  post: post1
)

Comment.create!(
  content: "AI konusunda daha fazla yazı bekliyoruz!",
  user: user1,
  post: post2
)

Comment.create!(
  content: "Bu ipuçlarını deneyeceğim, teşekkürler!",
  user: user1,
  post: post3
)

Comment.create!(
  content: "Kapadokya'yı çok seviyorum, harika bir yer!",
  user: user2,
  post: post4
)

puts "✅ #{Comment.count} yorum oluşturuldu"

puts "\n🎉 Seed data başarıyla yüklendi!"
puts "📊 Özet:"
puts "   - #{User.count} Kullanıcı"
puts "   - #{Category.count} Kategori"
puts "   - #{Post.count} Blog Yazısı"
puts "   - #{Comment.count} Yorum"
puts "   - #{Tag.count} Etiket"