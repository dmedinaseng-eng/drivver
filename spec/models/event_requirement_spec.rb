require "rails_helper"

RSpec.describe EventRequirement, type: :model do
  subject { build(:event_requirement) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:event) }
end
