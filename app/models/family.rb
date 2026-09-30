class Family < ApplicationRecord
  has_many :family_members, dependent: :destroy
  has_many :users, through: :family_members
  
  has_many :vehicles
end
