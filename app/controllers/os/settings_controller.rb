class Os::SettingsController < Os::BaseController
  def show
    @user = current_user
    @passkeys = @user.webauthn_credentials
    authorize :setting, :show?
  end

  def update
    @user = current_user
    authorize :setting, :update?
    if request.format.json? && params.dig(:user, :theme).present?
      @user.update_attribute(:theme, params.dig(:user, :theme))
      return head :ok
    end
    if user_params[:current_password].present?
      if @user.update_with_password(user_params)
        bypass_sign_in(@user)
        redirect_to os_settings_path, notice: "Seguridad actualizada exitosamente."
      else
        @passkeys = @user.webauthn_credentials
        render :show, status: :unprocessable_entity
      end
    else
      # 3. Flujo normal de actualización de Perfil
      clean_params = user_params.except(:current_password, :password, :password_confirmation)
      if @user.update(clean_params)
        redirect_to os_settings_path, notice: "Perfil actualizado."
      else
        @passkeys = @user.webauthn_credentials
        render :show, status: :unprocessable_entity
      end
    end
  end

  private
  
      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :phone_country_code, :phone_number,
          :id_type, :id_number, :city, :theme, :email,
          :current_password, :password, :password_confirmation
        )
      end
end
  