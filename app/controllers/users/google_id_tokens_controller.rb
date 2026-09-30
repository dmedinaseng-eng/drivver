require "googleauth/id_tokens"

module Users
  class GoogleIdTokensController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    before_action :verify_google_request!, only: :create

    def create
      payload = Google::Auth::IDTokens.verify_oidc(
        credential_token,
        aud: google_client_id
      )
      user = User.from_google_payload(payload)
      sign_in(user)

      respond_to do |format|
        format.json { render json: { status: "ok", redirect_url: after_sign_in_path_for(user) } }
        format.html { redirect_to after_sign_in_path_for(user), notice: t("auth.google.success") }
      end
    rescue Google::Auth::IDTokens::VerificationError, ArgumentError, KeyError
      respond_to do |format|
        format.json { render json: { status: "error", message: t("auth.google.failure") }, status: :unauthorized }
        format.html { redirect_to new_user_session_path, alert: t("auth.google.failure") }
      end
    end

    private

    def credential_token
      params[:credential].presence || params.dig(:google_id_token, :credential)
    end

    def google_client_id
      ENV.fetch("GOOGLE_CLIENT_ID")
    end

    def verify_google_request!
      return if rails_csrf_valid?
      return if google_double_submit_csrf?
      raise ActionController::InvalidAuthenticityToken
    end

    def rails_csrf_valid?
      token = request.headers["X-CSRF-Token"].presence || params[:authenticity_token]
      token.present? && valid_authenticity_token?(session, token)
    end

    def google_double_submit_csrf?
      token = params[:g_csrf_token].to_s
      cookie = cookies["g_csrf_token"].to_s
      token.present? && cookie.present? && ActiveSupport::SecurityUtils.secure_compare(token, cookie)
    end
  end
end
