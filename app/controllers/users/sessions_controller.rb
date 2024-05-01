# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    if resource.status == "blocked"
      flash[:alert] = "Your account is blocked."
      redirect_to new_user_session_path
    elsif resource && resource.active_for_authentication? && resource.status == 'active'
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
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