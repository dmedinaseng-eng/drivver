require "rails_helper"

RSpec.describe WebauthnCredential, type: :model do
  subject { build(:webauthn_credential) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:user) }
end
