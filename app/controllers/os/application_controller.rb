class Os::ApplicationController < ::ApplicationController
      before_action :authenticate_user!
  
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
        flash[:alert] = "No tienes permisos para realizar esta acción o acceder a este módulo."
        redirect_to(request.referrer || os_root_path)
      end
end
