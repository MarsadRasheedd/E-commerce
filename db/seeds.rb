# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find(1)
a = 1
(a...50).each do
  a = a +1
  title = "product #{a}"
  description = "description for product #{a}"
  price = 30 * a
  p = Product.create(title: title, description: description, price: price, serial_no: Product.generate_serial_number)

  if a % 2 == 0
    p.images.attach(io: File.open('/home/dev/Downloads/watch series 7.jpeg'), filename: 'watch series 7.jpeg')
  else
    p.images.attach(io: File.open('/home/dev/Downloads/iphone 13.jpeg'), filename: 'iphone 13.jpeg')
  end

  user.products << p
end
