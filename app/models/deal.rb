class Deal < ApplicationRecord
  belongs_to :vehicle
  belongs_to :organization, optional: true
  belongs_to :client, class_name: "User"
end
