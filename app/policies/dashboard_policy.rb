class DashboardPolicy < ApplicationPolicy
    def show?
      os_access_allowed?
    end
end
