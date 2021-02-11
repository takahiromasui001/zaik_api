# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  Storehouse.create!(id: 1, name: 'store1')
  Storehouse.create!(id: 2, name: 'store2')
  Storehouse.create!(id: 3, name: 'store1')
  Stock.create!(id: 1, name: 'zaiko1', color_number: 'black', quantity: 10, manufacturing_date: '2020-07-02 16:04:05', used: false, storehouse_id: 1)
  Stock.create!(id: 2, name: 'zaiko2', color_number: 'black', quantity: 12, manufacturing_date: '2020-07-02 16:10:05', used: false, storehouse_id: 1)
  Stock.create!(id: 3, name: 'zaiko3', color_number: 'black', quantity: 9, manufacturing_date: '2020-07-02 20:04:05', used: true, storehouse_id: 2)
  Stock.create!(id: 4, name: 'zaiko4', color_number: 'black', quantity: 3, manufacturing_date: '2020-07-03 16:04:05', used: false, storehouse_id: 2)
  Stock.create!(id: 5, name: 'zaiko5', color_number: 'black', quantity: 21, manufacturing_date: '2020-07-05 16:04:05', used: true, storehouse_id: 3)
  Stock.create!(id: 6, name: 'zaiko6', color_number: 'black', quantity: 33, manufacturing_date: '2020-07-06 08:04:05', used: false, storehouse_id: 3)
  Stock.create!(id: 7, name: 'zaiko7', color_number: 'black', quantity: 15, manufacturing_date: '2020-07-08 16:04:05', used: false, storehouse_id: 3)
end
