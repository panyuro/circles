class SessionsController < ApplicationController
  # layout false
  def new
  end

  def create
    @user = User.find_by(username: params[:username], password: params[:password])

    if @user
      sign_user @user
      redirect_to welcome_index_path
    else
      flash[:notice] = "用户名或密码不正确"
      render action: :new
    end
  end

  def destroy
    logout_user
    flash[:notice] = "退出成功"
    redirect_to new_session_path
  end
end
