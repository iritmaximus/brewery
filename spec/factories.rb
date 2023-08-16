FactoryBot.define do
  factory :user do
    username { "Möötti" }
    password { "Unsecure1" }
    password_confirmation { "Unsecure1" }
  end

  factory :brewery do
    name { "Creative" }
    year { 2023 }
  end

  factory :beer do
    name { "Something good" }
    style { "Yes" }
    brewery
  end

  factory :rating do
    score { 15 }
    beer
    user
  end
end
