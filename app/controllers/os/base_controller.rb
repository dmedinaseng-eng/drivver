class Os::BaseController < ::ApplicationController
      before_action :authenticate_user!
      before_action :ensure_account_not_suspended!
  
      include Pundit::Authorization
      after_action :verify_authorized
  
      layout "os"
  
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :phone_country_code, :id_type, :id_number, :city])
            devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :phone_country_code, :id_type, :id_number, :city, :theme])
        end
  
      private
  
        def user_not_authorized
          if ActiveModel::Type::Boolean.new.cast(ENV.fetch("USER_SHOULD_PAY", "false")) && !current_user&.active?
            flash[:alert] = "Requieres una suscripción activa para acceder a Drivver OS."
          else
            flash[:alert] = "No tienes permisos para realizar esta acción o acceder a este módulo."
          end
          
          redirect_to(request.referrer || root_path)
        end

        def ensure_account_not_suspended!
          if !current_user.active?
            sign_out current_user
            flash[:alert] = "Tu cuenta ha sido suspendida por violar nuestras políticas."
            redirect_to root_path
          end
        end
    
        def user_not_authorized
          flash[:alert] = "Tu plan actual no incluye esta funcionalidad o no tienes permisos."
          redirect_to(request.referrer || os_root_path)
        end
end
