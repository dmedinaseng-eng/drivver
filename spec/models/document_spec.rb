require "rails_helper"

RSpec.describe Document, type: :model do
  subject { build(:document) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:organization) }
end
