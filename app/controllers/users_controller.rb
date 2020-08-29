class UsersController < ApplicationController
  layout false
  require "prawn"

  def index
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password))
    if @user.save
      UserMailer.welcome_email(@user).deliver_later
      #flash 是一次性的闪现信息，之后用户重新刷新页面等操作不会再出现
      flash[:notice] = "注册成功请登录"
      redirect_to new_session_path
    else
      # 这里使用hash,定义render 一个action 保存上次@user对象，及其errors，作为显示，如果换成redirect to则无法保存上次的报错信息
      render action: :new
    end
  end

  def blogs
    @blogs = current_user.blogs.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf { render pdf: generate_pdf(@user) }
    end
  end

  def download_pdf
    user = User.find(params[:id])
    send_data generate_pdf(user),
              filename: "#{user.username}.pdf",
              type: "application/pdf"
  end

  def download_exist_pdf
    user = User.find(params[:id])
    send_file("#{Rails.root}/files/users/#{user.id}.pdf",
              filename: "#{user.username}.send.pdf",
              type: "application/pdf")
  end

  private

  def generate_pdf(user)
    Prawn::Document.new do
      text user.username, align: :center
      text "password: #{user.password}"
    end.render
  end
end
