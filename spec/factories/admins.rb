FactoryBot.define do
  factory :admin do
    email                 { |n| "test#{n}@gmail.com" }
    password              { "password" }
    password_confirmation { "password" }
  end
end
