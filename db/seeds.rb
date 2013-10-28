# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'bcrypt'
categories = {}

[
 "Gynophage",
 "Vito Genovese",
 "HJ",
 "Sirgoon",
 "Selir",
 "Jymbolya",
].each_with_index do |name, order|
  categories[name] = Category.where(name: name, order: order).first_or_create
end

p = proc{|a| BCrypt::Password.create a}

fart = "$2a$10$/tcBNuCm5oCxpuzfUeq8luZFS/Rk.IoOVsyVzcdSX7.uXxcI4Dlj6"

