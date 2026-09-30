class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def personal_context?
    user&.operating_in_personal_context?
  end

  def admin_context?
    user&.operating_in_admin_context?
  end

  def dealership_context?
    user&.operating_in_dealership?
  end

  def workshop_context?
    user&.operating_in_workshop?
  end

  def detailer_context?
    user&.operating_in_detailer?
  end

  def agency_context?
    user&.operating_in_agency?
  end

  def current_org
    user&.active_organization
  end

  def super_admin?
    user&.super_admin? || user&.developer?
  end

  def os_access_allowed?
    user.present?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end
  end
end
