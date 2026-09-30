FactoryBot.define do
  factory :vehicle do
    user
    family
    sequence(:plate) { |n| "ABC#{n.to_s.rjust(3, "0")}" }
    color { "Negro" }
    sequence(:chasis_id) { |n| "CHS#{n.to_s.rjust(8, "0")}" }
    sequence(:motor_id) { |n| "MTR#{n.to_s.rjust(8, "0")}" }
    vehicle_type { "sedan" }
    brand { "Toyota" }
    model { "Corolla" }
    year { "2020" }
  end
end
