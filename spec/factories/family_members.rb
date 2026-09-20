FactoryBot.define do
  factory :family_member do
    family { nil }
    user { nil }
    status { "MyString" }
    role { "MyString" }
  end
end
