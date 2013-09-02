FactoryGirl.define do
  factory :team do
    name { "butt team #{rand(10000)}" }
    password 'kenny'
    password_confirmation 'kenny'
    user
  end
end
