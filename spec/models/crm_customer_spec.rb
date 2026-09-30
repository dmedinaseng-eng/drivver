require "rails_helper"

RSpec.describe CrmCustomer, type: :model do
  subject { build(:crm_customer) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:organization) }
  it { is_expected.to belong_to(:converted_user).class_name("User").optional }
end
