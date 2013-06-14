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

p = proc{|a| BCrypt::Password.create a}

fart = "$2a$10$/tcBNuCm5oCxpuzfUeq8luZFS/Rk.IoOVsyVzcdSX7.uXxcI4Dlj6"

categories['3dub'].challenges.create(
                                    name: 'babysfirst',
                                    clue: 'http://babysfirst.shallweplayaga.me/',
                                    answer_digest: p['literally online lolling on line WucGesJi'],
                                    points: 1
                                    )
categories['3dub'].challenges.create(
                                     name: 'badmedicine',
                                     clue: 'http://badmedicine.shallweplayaga.me/',
                                     answer_digest: p['who wants oatmeal raisin anyways twumpAdby'],
                                     points: 2
                                     )
categories['3dub'].challenges.create(
                                     name: 'rememberme',
                                     clue: 'http://rememberme.shallweplayaga.me/',
                                     answer_digest: p['DyacphakukKefumsh2SwalvyocfowgitenhonEaf'],
                                     points: 3
                                     )
categories['3dub'].challenges.create(
                                     name: 'hypeman',
                                     clue: 'http://hypeman.shallweplayaga.me/',
                                     answer_digest: p['watch out for this Etdeksogav'],
                                     points: 4
                                     )

categories['OMGACM'].challenges.create(
                                       name: 'pieceofeight',
                                       points: 1
                                           )
categories['OMGACM'].challenges.create(
                                       name: 'grandprix',
                                       points: 2
                                           )
categories['OMGACM'].challenges.create(
                                       name: 'frenemies',
                                       points: 3
                                           )
categories['OMGACM'].challenges.create(
                                       name: 'diehard'
                                       points: 4
                                           )

categories['0x41414141'].challenges.create(
                                       name: 'bitterswallow',
                                       points: 1
                                           )
categories['0x41414141'].challenges.create(
                                       name: 'blackbox',
                                       clue: "[[core file]]\nRunning at 131.247.27.201:1234",
                                       points: 2
                                           )
categories['0x41414141'].challenges.create(
                                       name: 'ergab',
                                       points: 3
                                           )
categories['0x41414141'].challenges.create(
                                       name: 'annyong',
                                       clue: "HELLOHellohello\n[[server binary]]\nRunning at annyong.shallweplayaga.me:5679",
                                       answer_digest: p['Kernel airbags have been fully deployed'],
                                       points: 4
                                           )
categories['0x41414141'].challenges.create(
                                       name: 'yolo',
                                       points: 5
                                           )

categories['\\xff\\xe4\\xcc'].challenges.create(
                                                name: 'blackjack',
                                                clue: "Are you ready to win some $$?\n[[server binary]]\nRunning at blackjack.shallweplayaga.me:6789",
                                                answer_digest: p['Counting cards will get you banned from the casino'],
                                                points: 1
                                                )
categories['\\xff\\xe4\\xcc'].challenges.create(
                                                name: 'linked', 
                                                points: 2
                                                )
categories['\\xff\\xe4\\xcc'].challenges.create(
                                                name: 'parser',
                                                points: 3
                                                )
categories['\\xff\\xe4\\xcc'].challenges.create(
                                                name: 'lena',
                                                points: 4
                                                )
categories['\\xff\\xe4\\xcc'].challenges.create(
                                                name: 'incest',
                                                points: 5
                                                )

categories['gnireenigne'].challenges.create(
                                                name: 'musicman',
                                                clue: "Can you hear that?\n[[server binary]]\nRunning at musicman.shallweplayaga.me:7890",
                                                answer_digest: p['We make beautiful music together'],
                                                points 1
                                                )
categories['gnireenigne'].challenges.create(
                                                name: 'policebox',
                                                points: 2
                                                )
categories['gnireenigne'].challenges.create(
                                                name: 'thyself',
                                                clue: "usage: ./client 50.16.112.8\n[[client binary]]",
                                                answer_digest: p['Good enough for government work'],
                                                points: 3
                                                )
categories['gnireenigne'].challenges.create(
                                                name: 'timecubed',
                                                points: 4
                                                )
