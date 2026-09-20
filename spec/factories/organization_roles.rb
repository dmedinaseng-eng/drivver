FactoryBot.define do
  factory :organization_role do
    organization { nil }
    user { nil }
    role_name { "MyString" }
    permissions { "" }
  end
end
