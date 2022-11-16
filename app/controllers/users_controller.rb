class UsersController < ApplicationController

    # skip_before_action :authorized, only: [:new, :create]
    
    def new
      @user = User.new
    end
  
    def create
      if params["user"]["user_name"].empty?
        flash["notice"] = "User Name can't be empty"
        redirect_to '/users/new'
      elsif params["user"]["password"].empty?
        flash["notice"] = "Password can't be empty"
        redirect_to '/users/new'
      else
        @user = User.create(params.require(:user).permit(:user_name, :first_name, :last_name, :password))
        session[:user_id] = @user.id
        flash["notice"] = "New User Created"
        redirect_to '/posts'
      end
    end
  end