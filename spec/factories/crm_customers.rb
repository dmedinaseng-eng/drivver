FactoryBot.define do
  factory :crm_customer do
    organization { nil }
    lead_type { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { "MyString" }
    phone_country_code { "MyString" }
    email { "MyString" }
    notes { "MyText" }
    converted_user_id { "" }
  end
end
