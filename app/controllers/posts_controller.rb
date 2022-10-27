class PostsController < ApplicationController
    # before_action :force_index_redirect, only: [:index]
  
    def show
      id = params[:id] # retrieve movie ID from URI route
      @post = Post.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
    #   @all_ratings = Movie.all_ratings
    #   @movies = Movie.with_ratings(ratings_list, sort_by)
    #   @ratings_to_show_hash = ratings_hash
    #   @sort_by = sort_by
      @all_posts = Post.all()
      # remember the correct settings for next time
    #   session['ratings'] = ratings_list
    #   session['sort_by'] = @sort_by
    end
  
    def new
    end
  
    def create
      @post_title = params[:post][:title]
      @post_description = params[:post][:description]
      @zipcode = params[:post][:zipcode]
      # TODO: Dummy User & Post at the moment. Replace this section in Iter2
      @user_id = "123"
      @user_name = "Arthur Liu"
      @aa = params[:post]
      @post = Post.create!(
        post_id: "100", 
        zipcode: @zipcode, 
        title: @post_title, 
        creator_id: @user_id, 
        description: @post_description, 
        date: "2022-01-03")
      flash[:notice] = "#{@post.title} was successfully created."
      redirect_to posts_path
    end
  
    def edit
      @post = Post.find params[:id]
    end
  
    def update
      @post = Post.find params[:id]
      @post.update_attributes!(post_params)
      flash[:notice] = "#{@post.title} was successfully updated."
      redirect_to post_path(@post)
    end
  
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      flash[:notice] = "post '#{@post.title}' deleted."
      redirect_to posts_path
    end
  
    private
    def post_params
      params.require(:post).permit(:title, :description)
    end
  
    def force_index_redirect
      if !params.key?(:ratings) || !params.key?(:sort_by)
        flash.keep
        url = movies_path(sort_by: sort_by, ratings: ratings_hash)
        redirect_to url
      end
    end
  
    def ratings_list
      params[:ratings]&.keys || session[:ratings] || Movie.all_ratings
    end
  
    def ratings_hash
      Hash[ratings_list.collect { |item| [item, "1"] }]
    end
  
    def sort_by
      params[:sort_by] || session[:sort_by] || 'id'
    end
  end