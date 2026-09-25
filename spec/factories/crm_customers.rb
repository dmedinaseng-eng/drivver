FactoryBot.define do
  factory :crm_customer do
    organization
    lead_type { "buyer" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:phone_number) { |n| "310#{n.to_s.rjust(7, "0")}" }
    phone_country_code { "CO" }
    sequence(:email) { |n| "lead#{n}@drivver.test" }
    notes { "Lead de prueba" }
  end
end
