FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    id_number { "MyString" }
    id_type { "MyString" }
    active { false }
    city { "MyString" }
    phone_country_code { "MyString" }
    phone_number { "MyString" }
    theme { "MyString" }
    global_role { 1 }
    provider { "MyString" }
    uid { "MyString" }
  end
end
