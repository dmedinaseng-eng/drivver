class Event < ApplicationRecord
  belongs_to :vehicle
  belongs_to :organization
  belongs_to :user
end
