class HomeController < ApplicationController
  def index
    @users = User.unscoped.all
  end

  def manage
    selected_user_ids = params[:user_ids]

    if params[:block]
      User.unscoped.where(id: selected_user_ids).update_all(status: "blocked")
      flash[:notice] = "Action was successful!"
      if selected_user_ids.map(&:to_i).include?(current_user.id)
        sign_out_and_redirect(current_user)
      else
        redirect_to home_index_path
      end
    elsif params[:delete]
      User.unscoped.where(id: selected_user_ids).destroy_all
      flash[:notice] = "Action was successful!"
      redirect_to home_index_path
    elsif params[:unblock]
      User.unscoped.where(id: selected_user_ids).update_all(status: "active")
      flash[:notice] = "Action was successful!"
      redirect_to home_index_path
    end
  end
end
