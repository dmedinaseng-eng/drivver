require "rails_helper"

RSpec.describe Event, type: :model do
  subject { build(:event) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:vehicle) }
  it { is_expected.to belong_to(:organization) }
  it { is_expected.to belong_to(:user) }
end
