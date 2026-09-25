FactoryBot.define do
  factory :organization_role do
    organization
    user
    role_name { "owner" }
    permissions { {} }
  end
end
