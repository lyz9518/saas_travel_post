class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]
  
  def new
  end

  def create
    user = User.find_by(user_id: params[:user_id])
    if user && user.password == params[:password]
      flash["notice"] = "Login successfully"
      session[:user_id] = user.user_id
      redirect_to '/posts'
    elsif not user
      flash["notice"] = "No such user find"
      redirect_to '/login'
    elsif not user.password == params[:password]
      flash["notice"] = "Wrong password"
      redirect_to '/login'
    end
  end

  def signoff
    reset_session
    redirect_to '/posts'
  end

  def welcome
    
  end

  def login
  end

  def page_requires_login
  end
  
end
