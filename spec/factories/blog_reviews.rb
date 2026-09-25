FactoryBot.define do
  factory :blog_review do
    blog_post
    user
    rating { 5 }
    comment { "Muy útil" }
  end
end
