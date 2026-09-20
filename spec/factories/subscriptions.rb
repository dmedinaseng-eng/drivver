FactoryBot.define do
  factory :subscription do
    subscribable { nil }
    plan { nil }
    status { "MyString" }
    expires_at { "2026-09-20" }
  end
end
