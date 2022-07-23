FactoryBot.define do
  factory :user do
    email                 { |n| "test#{n}@gmail.com" }
    password              { "password" }
    password_confirmation { "password" }
  end
end
