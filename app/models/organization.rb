class Organization < ApplicationRecord
    has_many :subscriptions, as: :subscribable, dependent: :destroy
    has_many :organization_roles, dependent: :destroy
    has_many :users, through: :organization_roles
end
