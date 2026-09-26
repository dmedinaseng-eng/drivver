class EffectiveRolePolicy < ApplicationPolicy
    def create?
      os_access_allowed? && user.internal_team?
    end
  end