FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    sequence(:tax_id) { |n| "900#{n.to_s.rjust(6, "0")}" }
    org_type { "dealership" }
    sequence(:phone_number) { |n| "601#{n.to_s.rjust(7, "0")}" }
    phone_country_code { "CO" }
    sequence(:email) { |n| "org#{n}@drivver.test" }

    trait :workshop do
      org_type { "workshop" }
    end

    trait :detailer_shop do
      org_type { "detailer_shop" }
    end

    trait :marketing_agency do
      org_type { "marketing_agency" }
    end
  end
end
