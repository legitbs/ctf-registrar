# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  "Ghoti in the Shell", # shellcode
  "10100111001", # binary leetness
  "transfer protocol", # web
  
  ].each_with_index do |name, order|
    Category.where(name: name, order: order).first_or_create
  end
