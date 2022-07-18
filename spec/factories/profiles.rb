FactoryBot.define do
  factory :profile do
    name        { "ユーザー" }
    sex         { 0 }
    date_of_birth { "2022/07/01" }
    prefecture    { "沖縄県" }
    municipality  { "那覇市" }
  end
end
