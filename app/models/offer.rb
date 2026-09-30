class Offer < ApplicationRecord
  belongs_to :deal
  belongs_to :organization, optional: true
  belongs_to :offeror_user, class_name: "User"
end
