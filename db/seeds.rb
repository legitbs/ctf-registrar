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

categories['Vito Genovese'].challenges.create(name: 'asdf',
                                              points: 1,
                                              clue: 'asdf',
                                              answer_digest: fart)
categories['Vito Genovese'].challenges.create(name: 'asdf2',
                                              points: 2,
                                              clue: 'asdf2',
                                              answer_digest: fart)

if Rails.env.development?
  [
   "The Plaid Parliament of Pwning",
   "The European Nopsled Team"
  ].each do |t|
    Team.where(name: t).first or Team.create(name: t, password: 'asdf', password_confirmation: 'asdf')
  end
  
  23.times do |t|
    Team.where(name: "Team #[t}").first or Team.create(name: "Team #{t}", password: 'asdf', password_confirmation: 'asdf')
  end
  
  Team.all.order('created_at asc').each do |t|
    t.solutions.where(challenge: Challenge.first).first_or_create
  end
end

Notice.where(body: "Welcome to the 2014 DEF CON Capture the Flag Qualification round, brought to you by Legitimate Business Syndicate", created_at: ApplicationController.allocate.game_window).first_or_create
