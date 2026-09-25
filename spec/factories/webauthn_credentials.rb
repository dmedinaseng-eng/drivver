FactoryBot.define do
  factory :webauthn_credential do
    user { nil }
    external_id { "MyString" }
    public_key { "MyText" }
    sign_count { "" }
  end
end
