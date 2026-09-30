FactoryBot.define do
  factory :webauthn_credential do
    user
    sequence(:external_id) { |n| "credential-#{n}" }
    public_key { "pubkey-#{SecureRandom.hex(8)}" }
    sign_count { 0 }
  end
end
