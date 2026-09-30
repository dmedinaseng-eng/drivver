require "rails_helper"

RSpec.describe OrganizationRole, type: :model do
  subject { build(:organization_role) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:organization) }
  it { is_expected.to belong_to(:user) }
end
