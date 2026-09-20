class Deal < ApplicationRecord
  belongs_to :vehicle
  belongs_to :organization
  belongs_to :client
end
