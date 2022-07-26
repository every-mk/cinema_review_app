FactoryBot.define do
  factory :review do
    recommendation { false }
    after_watch { 1 }
    spoiler { false }
    content { "MyString" }
  end
end
