module UserSession

  def self.included base
    base.class_eval do
      helper_method :logged_in?
      helper_method :current_user
    end
  end

  def sign_user user
    session[:user_id] = user.id
  end

  def logout_user
    session[:user_id] = nil
    @current_user = nil
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if logged_in?
      @current_user ||= User.find_by(id: session[:user_id])
    else
      nil
    end
  end
end
