# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username { "fart #{rand(1000)}" }
    password "new york"
    password_confirmation "new york"
    email { "butt#{rand(1000)}@example.com" }

    factory :user_params_valid do
      password_confirmation { password }
      email_confirmation { email }
    end

    factory :team_member do
      team
    end
  end
end
