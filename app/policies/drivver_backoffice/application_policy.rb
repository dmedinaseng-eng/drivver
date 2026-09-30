module DrivverBackoffice
  class ApplicationPolicy < ::ApplicationPolicy
    def index?
      backoffice_access?
    end

    def show?
      backoffice_access?
    end

    def create?
      backoffice_access?
    end

    def update?
      backoffice_access?
    end

    def destroy?
      backoffice_access?
    end

    private

    def backoffice_access?
      os_access_allowed? && user.internal_team?
    end
  end
end
