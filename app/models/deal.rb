class Deal < ApplicationRecord
  
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'
  belongs_to :agent_seller, class_name: 'User', foreign_key: 'agent_seller_id', optional: true
  belongs_to :agent_buyer, class_name: 'User', foreign_key: 'agent_buyer_id', optional: true
  
  belongs_to :vehicle
  belongs_to :organization
  
  has_many :offers, dependent: :destroy
end
