class CrmCustomer < ApplicationRecord
  belongs_to :organization
  belongs_to :converted_user, class_name: "User", optional: true
end
