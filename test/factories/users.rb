# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "fart"
    password "new york"
    email "butt@example.com"

    factory :user_params_valid do
      password_confirmation { password }
      email_confirmation { email }
    end
  end
end
