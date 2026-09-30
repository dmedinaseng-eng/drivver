module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      handle_auth("Google")
    end

    def failure
      redirect_to new_user_session_path, alert: "No se pudo autenticar con Google."
    end

    private

    def handle_auth(kind)
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        flash[:notice] = "Inicio de sesión exitoso con #{kind}."
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
        redirect_to new_user_registration_url, alert: "Hubo un problema al autenticar o crear tu cuenta con #{kind}."
      end
    end
  end
end
