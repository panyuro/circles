class ApplicationController < ActionController::Base
  include UserSession

  private
  def auth_user
    unless logged_in?
      flash[:notice] = '请登录'
      redirect_to new_session_path
    end
  end
end
