class UsersController < ApplicationController

    # skip_before_action :authorized, only: [:new, :create]

    def show
      id = params[:id] # retrieve movie ID from URI route
      @user = User.find(id)
      @all_posts = Post.where(creator_id: id)
    end
    
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
      elsif User.exists?(user_name: params["user"]["user_name"])
        flash["notice"] = "Username already exist"
        redirect_to '/users/new'
      else
        @user = User.create(params.require(:user).permit(:user_name, :first_name, :last_name, :password))
        session[:user_id] = @user.id
        flash["notice"] = "New User Created"
        redirect_to '/posts'
      end
    end
  end