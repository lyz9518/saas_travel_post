class UsersController < ApplicationController

    skip_before_action :authorized, only: [:new, :create]
    
    def new
      @user = User.new
    end
  
    def create
      @user = User.create(params.require(:user).permit(:user_id, :password))
      session[:user_id] = @user.user_id
      redirect_to '/posts'
    end
  end