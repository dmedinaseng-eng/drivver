class DrivverBackoffice::BaseController < ApplicationController
      before_action :authenticate_user!
      before_action :ensure_account_not_suspended!
      before_action :ensure_internal_team!

      include Pundit::Authorization
      after_action :verify_authorized
      layout "drivver_backoffice"

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      helper_method :operating_as_internal_team?

      private

      def ensure_internal_team!
        unless current_user&.internal_team?
          flash[:alert] = "Acceso denegado. Área restringida al equipo interno de Drivver."
          redirect_to os_root_path
        end
      end

      def user_not_authorized
        flash[:alert] = "No tienes permisos para realizar esta acción en el Backoffice."
        redirect_to(request.referrer || drivver_backoffice_root_path)
      end

      def ensure_account_not_suspended!
        if !current_user.active?
          sign_out current_user
          flash[:alert] = "Tu cuenta ha sido suspendida."
          redirect_to root_path
        end
      end

      # En este namespace siempre será true, pero lo mantenemos por compatibilidad de helpers
      def operating_as_internal_team?
        true
      end
end
