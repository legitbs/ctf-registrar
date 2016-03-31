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
 "Baby's First",
 "Shellcode",
 "Reversing",
 "Exploitation",
 "Programming"
].each_with_index do |name, order|
  categories[name] = Category.where(name: name, order: order).first_or_create
end

p = proc{|a| BCrypt::Password.create a}

fart = "$2a$10$/tcBNuCm5oCxpuzfUeq8luZFS/Rk.IoOVsyVzcdSX7.uXxcI4Dlj6"

categories.each do |n, cat|
  cat.challenges.where(name: cat.name+' 1',
                       points: 1,
                       clue: 'asdf',
                       answer_digest: fart).first_or_create
  cat.challenges.where(name: cat.name+' 2',
                       points: 2,
                       clue: 'asdf',
                       answer_digest: fart).first_or_create
end

if Rails.env.development?
  23.times do |t|
    u = User.where(username: "User-#{t}").first || User.create(username: "User-#{t}", password: 'asdf', password_confirmation: 'asdf', email: "butt-#{t}@invalid.invalid")
    raise u.errors.inspect if u.id.nil?
    t = Team.where(name: "Team #[t}").first || Team.create(name: "Team #{t}", password: 'asdf', password_confirmation: 'asdf', user: u)
    u.team = t
    u.save
    t.solutions.where(challenge: Challenge.first).first_or_create
  end
end

Notice.where(body: "Welcome to the 2015 DEF CON Capture the Flag Qualification round, brought to you by Legitimate Business Syndicate", created_at: ApplicationController.allocate.game_window).first_or_create
