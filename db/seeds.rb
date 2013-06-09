# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = {}

[
  "3dub", # web
  "0x41414141", # exploitation
  "\\xff\\xe4\\xcc", # shellcode
  "OMGACM", # guerilla programming
  "gnireenigne", # reverse engineering
].each_with_index do |name, order|
  categories[name] = Category.where(name: name, order: order).first_or_create
end

fart = "$2a$10$/tcBNuCm5oCxpuzfUeq8luZFS/Rk.IoOVsyVzcdSX7.uXxcI4Dlj6"

Category.find_each do |cat|
  (1..5).each do |val|
    c = Challenge.where(name: "#{cat.name} #{val}",
                    clue: "#{cat.name}",
                    category_id: cat.id,
                    points: val
                    ).first_or_create
    c.answer_digest = fart
    c.save
  end
end
