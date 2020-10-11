class SessionsController < ApplicationController
  # layout false
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    exist = @user.authenticate(params[:session][:password])

    if exist
      sign_user @user
      redirect_to welcome_index_path
    else
      flash[:notice] = "用户名或密码不正确"
      render action: :new
    end
  end

  def destroy
    logout_user
    flash[:success] = "退出成功"
    redirect_to new_session_path
  end
end
