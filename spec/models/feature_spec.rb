require "rails_helper"

RSpec.describe Feature, type: :model do
  it { expect(build(:feature)).to be_valid }
end
