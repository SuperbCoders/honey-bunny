# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def create_admins
  User.where(email: 'kostia.pizhon@gmail.com').first_or_create(role: 'admin', password: 'qwerty123')
end

def create_pages
  Page.where(slug: 'index').first_or_create(title: 'Honey-Bunny', published: false, cover: File.open("#{Rails.root}/db/seeds/index_cover.jpg"))
  Page.where(slug: 'products').first_or_create(title: 'Продукты HB', motto: 'Наше все', subtitle: 'Все текущие товары', published: false, cover: File.open("#{Rails.root}/db/seeds/products_cover.jpg"))
end

create_admins
create_pages