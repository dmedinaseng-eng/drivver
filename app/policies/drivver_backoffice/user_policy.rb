module DrivverBackoffice
  class UserPolicy < ApplicationPolicy
    def toggle_active?
      backoffice_access?
    end
  end
end
