# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [
  {
    name: 'Hardware'
  },
  {
    name: 'Smartphones'
  },
  {
    name: 'Video Games'
  }
]

categories.each do |category|
  Category.find_or_create_by!(category)
end

products = [
  {
    name: 'Apple iPhone 11 Pro Max',
    description: '6.5-inch Super Retina XDR OLED display, 12MP TrueDepth front camera',
    price: 1099.00,
    amount: 10,
    category_id: Category.last.id
  },
  {
    name: 'Nintendo Switch Neon Red Blue',
    description: 'This model includes battery life of approximately 4.5 to 9 hours',
    price: 441.26,
    amount: 20,
    category_id: Category.last.id
  },
  {
    name: 'Intel Core i9-9900K',
    description: '8 Cores up to 5.0GHz Unlocked LGA1151 300 Series 95W',
    price: 509.00,
    amount: 5,
    category_id: Category.last.id
  }
]

products.each do |product|
  Product.find_or_create_by!(product)
end
