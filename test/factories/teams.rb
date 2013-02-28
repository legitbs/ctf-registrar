FactoryGirl.define do
  factory :team do
    name { "butt team #{rand(10000)}" }
    password 'kenny'
    user
  end
end
