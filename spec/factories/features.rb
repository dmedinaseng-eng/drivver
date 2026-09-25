FactoryBot.define do
  factory :feature do
    sequence(:name) { |n| "feature-#{n}" }
    category { "core" }
    target_model { "User" }
    description { "Funcionalidad de la plataforma" }
  end
end
