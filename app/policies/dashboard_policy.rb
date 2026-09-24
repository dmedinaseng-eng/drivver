class DashboardPolicy < ApplicationPolicy
    def show?
      user.present? && user.active?
    end
  end