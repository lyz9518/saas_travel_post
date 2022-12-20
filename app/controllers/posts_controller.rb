class PostsController < ApplicationController
    # before_action :force_index_redirect, only: [:index]
    @sort_by_rating_checked = false
  
    def show
      id = params[:id] # retrieve movie ID from URI route
      @post = Post.find(id) # look up movie by unique ID
      @add_review = "#{params[:id]}/review/add"
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_posts = Post.all()
      
      if params[:search_by_title] && params[:search_by_title] != ""
        @all_posts = @all_posts.where("title LIKE ?", "%"+params[:search_by_title]+"%")
      end
      if params[:search_by_zipcode] && params[:search_by_zipcode] != ""
        @all_posts = @all_posts.where("zipcode LIKE ?", "%"+params[:search_by_zipcode]+"%" )
      end
      if not params[:sort_by_rating].nil?
        @sort_by_rating_checked = true
        @all_posts = @all_posts.order("rating DESC")
      end 
    end
  
    def new
      "NEW"
      if not logged_in?
        flash["notice"] = "Login to create new post"
        redirect_to "/login"
      end
      @post = Post.new
    end
  
    def create
      if params[:post][:title] && params[:post][:description] && params[:post][:rating] && params[:post][:zipcode] && params[:post][:title]!="" && params[:post][:description]!="" && params[:post][:zipcode]!=""
        @post_title = params[:post][:title]
        @post_description = params[:post][:description]
        @zipcode = params[:post][:zipcode]
        @rating = params[:post][:rating]
        if not @rating.match(/^\d{1}$/)
          flash[:warning] = "rating #{@rating} is not in 0-9!"
          redirect_to '/posts/new' and return
        end
        if not @zipcode.match(/^\d{5}(?:[-\s]\d{4})?$/)
          flash[:warning] = "zipcode #{@zipcode} is not invalid!"
          redirect_to '/posts/new' and return
        end
        # TODO: Dummy User & Post at the moment. Replace this section in Iter2\
        @user_id = current_user.id
        @user_name = current_user.user_name
        @image = params[:post][:image]
        @aa = params[:post]
        @post = Post.create!(
          zipcode: @zipcode, 
          title: @post_title, 
          creator_id: @user_id, 
          description: @post_description, 
          rating: @rating, 
          image: @image,
          date: Time.now.to_date)
        flash[:notice] = "#{@post.title} was successfully created."
        redirect_to posts_path
      else
        flash["notice"] = "Please enter all slots to continue!"
        redirect_to '/posts/new'
      end
    end
  
    def edit
      @post = Post.find params[:id]
      if @post.creator_id != session[:user_id].to_s
        flash["notice"] = "Only creator can edit the post"
        redirect_to(@post)
      end
    end
  
    def update
      @post = Post.find params[:id]
      @post.update_attributes!(post_params)
      flash[:notice] = "#{@post.title} was successfully updated."
      redirect_to post_path(@post)
    end

    def new_review
      @post = Post.find params[:id]
      # @action_path = "posts/params[:id]/review/create"
      render "new_review"
    end


    def create_review
      if params[:review][:content].empty?
        flash[:notice] = "Content can't be empty"
        redirect_to("/posts/#{params[:id]}/review/add")
      else
        @post = Post.find params[:id]
        @post.reviews.build(:content => params[:review][:content])
        @post.save
        flash[:notice] = params[:review][:content]
        redirect_to post_path(@post)
      end
    end
  
    def destroy
      @post = Post.find(params[:id])
      if @post.creator_id != session[:user_id].to_s
        flash["notice"] = "Only creator can delete the post"
        redirect_to(@post)
      else
        @post.destroy
        flash[:notice] = "post '#{@post.title}' deleted."
        redirect_to posts_path
      end
    end
  
    private
    def post_params
      params.require(:post).permit(:title, :description, :zipcode, :image, :sort_by_rating)
    end
  
    # def force_index_redirect
    #   if !params.key?(:ratings) || !params.key?(:sort_by)
    #     flash.keep
    #     url = movies_path(sort_by: sort_by, ratings: ratings_hash)
    #     redirect_to url
    #   end
    # end
  
    # def ratings_list
    #   params[:ratings]&.keys || session[:ratings] || Movie.all_ratings
    # end
  
    # def ratings_hash
    #   Hash[ratings_list.collect { |item| [item, "1"] }]
    # end
  
    # def sort_by
    #   params[:sort_by] || session[:sort_by] || 'id'
    # end
  end