FactoryGirl.define do
  factory :challenge do
    name { "butt challence #{rand(10000)}" }
    clue "hello"
    answer_digest BCrypt::Password.create('password').to_s
    category
    points 5
  end
end
