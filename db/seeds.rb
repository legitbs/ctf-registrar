# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  "transfer protocol", # web
  "ethically sourced", # exploitation
  "a stitch in time", # patching
  "Ghoti in the Shell", # shellcode
  "10100111001", # guerilla programming
  "gnireenigne", # reverse engineering
].each_with_index do |name, order|
  Category.where(name: name, order: order).first_or_create
end

Category.find_each do |cat|
  (1..5).each do |val|
    Challenge.where(name: "#{cat.name} #{val}",
                    clue: "#{cat.name}",
                    category_id: cat.id,
                    points: val
                    ).first_or_create
  end
end
