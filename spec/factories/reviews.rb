FactoryBot.define do
  factory :review do
    want_to_see { false }
    recommendation { false }
    after_watch { 1 }
    spoiler { false }
    content { "MyString" }
  end
end
