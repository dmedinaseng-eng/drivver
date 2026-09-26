class SettingPolicy < ApplicationPolicy
    def show?
      os_access_allowed?
    end
  
    def update?
      os_access_allowed?
    end
  end