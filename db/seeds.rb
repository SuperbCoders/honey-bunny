# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'csv'

def create_admins
  User.where(email: 'schumi@live.ru').first_or_create(role: 'admin', password: 'qwerty123')
end

def create_pages
  Page.where(slug: 'index').first_or_create(title: 'Honey-Bunny', published: false, cover: File.open("#{Rails.root}/db/seeds/index_cover.jpg"))
  Page.where(slug: 'products').first_or_create(title: 'Продукты HB', motto: 'Наше все', subtitle: 'Все текущие товары', published: false, cover: File.open("#{Rails.root}/db/seeds/products_cover.jpg"))
  Page.where(slug: 'company').first_or_create(title: 'В основе нашей косметики лежат несколько идей', motto: 'Honey Bunny', subtitle: 'За текущими новостями компании следите в нашем фейсбуке', published: false, cover: File.open("#{Rails.root}/db/seeds/company_cover.jpg"))
  Page.where(slug: 'values').first_or_create(title: 'Наши ценности', motto: 'Приятно познакомиться', subtitle: 'Мы делаем хорошую косметику для людей', published: true, cover: File.open("#{Rails.root}/db/seeds/values_cover.jpg"))
  Page.where(slug: 'cosmetics').first_or_create(title: 'О косметике', motto: '', subtitle: '', published: true, cover: File.open("#{Rails.root}/db/seeds/products_cover.jpg"))
  Page.where(slug: 'faq').first_or_create(title: 'Вопросы и ответы', motto: 'Отвечаем на ваши вопросы', subtitle: 'Про нашу классную косметику', published: true, cover: File.open("#{Rails.root}/db/seeds/faq_cover.jpg"))
  Page.where(slug: 'difference').first_or_create(title: 'В чем отличие', published: true, cover: File.open("#{Rails.root}/db/seeds/products_cover.jpg"))
end

def create_cities
  CSV.foreach("#{Rails.root}/db/seeds/cities.csv", col_sep: ';', encoding: 'UTF-8') do |row|
    city_id, country_id, name = row[0], row[1], row[3]
    next if city_id == 'city_id' || country_id != '3159' # read only Rusian cities
    City.where(name: name).first_or_create
  end
end

def create_shipping_methods
  # For default orders
  ShippingMethod.where(name: 'courier').first_or_create(title: 'Курьер по Москве', rate_type: 'city_rate', available_for_default_order: true)
  ShippingMethod.where(name: 'regions').first_or_create(title: 'Почта в регионы', rate_type: 'city_and_fix_rate', rate: 1000, available_for_default_order: true)

  # For wholesale orders
  ShippingMethod.where(name: 'own_expense').first_or_create(title: 'Самовывоз со склада', rate_type: 'fix_rate', available_for_wholesale_order: true)
  ShippingMethod.where(name: 'transport_company').first_or_create(title: 'Транспортная компания', rate_type: 'individual', available_for_wholesale_order: true)
end

def create_shipping_prices_for(shipping_method_name)
  shipping_method = ShippingMethod.find_by(name: shipping_method_name)
  CSV.foreach("#{Rails.root}/db/seeds/shipping_prices_#{shipping_method_name}.csv", col_sep: ';', encoding: 'UTF-8') do |row|
    name, price = row[0], row[1]
    city = City.find_by(name: name)
    next unless city
    shipping_method.shipping_prices.where(city_id: city.id).first_or_create!(price: price.to_i)
  end
end

def create_payment_methods
  PaymentMethod.where(name: 'cash').first_or_create(title: 'Наличными')
  PaymentMethod.where(name: 'w1').first_or_create(title: 'Банковской картой')
end

def create_default_meta_block
  MetaBlock.where(default: true).first_or_create(
    title: 'Косметика Honey Bunny',
    description: 'Новая классная косметика. Качественная, простая, сбалансированная, доступная, для России',
    fb_title: 'Новая классная косметика Honey Bunny',
    fb_description: 'Простая, доступная, красивая',
    fb_image: File.open("#{Rails.root}/db/seeds/meta_blocks/fb_image.png"),
    javascript: File.read("#{Rails.root}/db/seeds/meta_blocks/javascript.txt")
  )
end

create_admins
create_pages
create_cities
create_shipping_methods
create_shipping_prices_for('courier')
create_shipping_prices_for('regions')
create_payment_methods
create_default_meta_block
