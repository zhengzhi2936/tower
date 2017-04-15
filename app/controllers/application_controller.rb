class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

protected

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

  def check_permission(projecct_id)
    unless current_user.has_permission_to_operate_todo?(projecct_id)
      flash[:alert] = "等等，你好像不是我们机组的"
      redirect_to "/"
    end
  end
end
