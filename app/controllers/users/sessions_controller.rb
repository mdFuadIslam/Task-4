# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    email = params[:user] && params[:user][:email].downcase
    @user = email.present? ? User.find_by(email: email) : nil
    if @user && @user.status == "blocked"
      set_flash_message!(:alert, :"devise.failure.blocked")
      redirect_to new_user_session_path and return
    end
    super
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
