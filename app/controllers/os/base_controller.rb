class Os::BaseController < ::ApplicationController
  before_action :authenticate_user!
  before_action :ensure_account_not_suspended!

  include Pundit::Authorization
  after_action :verify_authorized

  layout "os"

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :operating_as_internal_team?

  def switch_context
    skip_authorization
    context_id = params[:context_id]

    if context_id == "admin"
      flash[:alert] = "El modo Admin solo puede activarse desde la sección de Configuración."
    elsif context_id == "personal"
      current_user.update_column(:current_context, "personal")
      flash[:notice] = "Has cambiado a tu Perfil Personal."
    elsif current_user.organization_roles.exists?(organization_id: context_id)
      current_user.update_column(:current_context, context_id)
      org = current_user.organizations.find(context_id)
      flash[:notice] = "Entorno activo: #{org.name}."
    else
      flash[:alert] = "No tienes permisos para acceder a este entorno."
    end

    redirect_back(fallback_location: os_root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :phone_number, :phone_country_code, :id_type, :id_number, :city ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :phone_number, :phone_country_code, :id_type, :id_number, :city, :theme ])
  end

  private

  def user_not_authorized
    flash[:alert] = "Tu entorno actual no incluye esta funcionalidad o no tienes permisos."
    redirect_to(request.referrer || os_root_path)
  end

  def ensure_account_not_suspended!
    if !current_user.active?
      sign_out current_user
      flash[:alert] = "Tu cuenta ha sido suspendida por violar nuestras políticas."
      redirect_to root_path
    end
  end

  def operating_as_internal_team?
    current_user&.operating_in_admin_context?
  end
end
