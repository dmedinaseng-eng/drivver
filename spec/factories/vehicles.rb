FactoryBot.define do
  factory :vehicle do
    user { nil }
    family { nil }
    plate { "MyString" }
    color { "MyString" }
    chasis_id { "MyString" }
    motor_id { "MyString" }
    vehicle_type { "MyString" }
    brand { "MyString" }
    model { "MyString" }
    year { "MyString" }
  end
end
