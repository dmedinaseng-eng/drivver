FactoryBot.define do
  factory :blog_post do
    organization
    association :author, factory: :user
    title { "Guía de compra segura" }
    sequence(:slug) { |n| "guia-compra-#{n}" }
    content { "Contenido del artículo" }
    status { "draft" }
  end
end
