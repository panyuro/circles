class ApplicationController < ActionController::Base
  include UserSession
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def auth_user
    unless logged_in?
      flash[:notice] = '请登录'
      redirect_to new_session_path
    end
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
end
