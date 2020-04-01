class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user.admin?
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'Please log in first.'
      redirect_to root_path
    end
  end

end
