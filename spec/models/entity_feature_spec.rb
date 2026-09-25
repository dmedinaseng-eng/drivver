require "rails_helper"

RSpec.describe EntityFeature, type: :model do
  subject { build(:entity_feature) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:feature) }
  it { is_expected.to belong_to(:featurable) }
end
