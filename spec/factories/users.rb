FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "user#{n}@drivver.test" }
    password { "password123" }
    password_confirmation { "password123" }
    sequence(:id_number) { |n| "10#{n.to_s.rjust(8, "0")}" }
    id_type { "CC" }
    active { true }
    city { "Bogotá" }
    phone_country_code { "CO" }
    sequence(:phone_number) { |n| "300#{n.to_s.rjust(7, "0")}" }
    global_role { :standard }
    current_context { "personal" }

    trait :google do
      provider { "google_oauth2" }
      sequence(:uid) { |n| "google-uid-#{n}" }
    end

    trait :super_admin do
      global_role { :super_admin }
    end

    trait :developer do
      global_role { :developer }
    end

    trait :c_level do
      global_role { :c_level }
    end

    trait :inactive do
      active { false }
    end
  end
end
