class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user
    
    
  def current_user   
      User.find_by(id: session[:user_id])
  end

  def logged_in?
      not current_user.nil?  
  end

  def authorized
      redirect_to '/posts' unless logged_in?
  end
end
