require "rails_helper"

RSpec.describe Organization, type: :model do
  subject { build(:organization) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
  it { is_expected.to have_many(:organization_roles).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:organization_roles) }
end
