class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def manage
    selected_user_ids = params[:user_ids]

    if params[:block]
      User.where(id: selected_user_ids).update_all(status: "blocked")
    elsif params[:delete]
      User.where(id: selected_user_ids).destroy_all
    elsif params[:unblock]
      User.where(id: selected_user_ids).update_all(status: "active")
    end
    redirect_to home_index_path
  end
end
