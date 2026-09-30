require "rails_helper"

RSpec.describe Plan, type: :model do
  it { expect(build(:plan)).to be_valid }
end
