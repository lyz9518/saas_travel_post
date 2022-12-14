require 'spec_helper'
require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe PostsController do
  describe 'index' do
    it 'should display index.html' do
      get :index
      expect(response).to render_template('index')
    end
    
    let!(:post1) { Post.create!(title: 'Hello', zipcode: '10001')}
    let!(:post2) { Post.create!(title: 'Hi', zipcode: '10001')}
    let!(:post3) { Post.create!(title: 'How are you', zipcode: '10000')}
    let(:search_by_title) {"Hello"}
    let(:search_by_zipcode) {"10001"}
    let(:sort_by_rating) {true}
    it "should return post 1" do
      get :index, :search_by_title => "Hello", :search_by_zipcode => "10001"
      expect(assigns(:all_posts)).to eq [post1]
    end
    it "should return post 1, 2" do
      get :index, :search_by_title => "", :search_by_zipcode => "10001"
      expect(assigns(:all_posts)).to eq [post1, post2]
    end
    it "should return post 1" do
      get :index, :search_by_title => "are", :search_by_zipcode => "10000"
      expect(assigns(:all_posts)).to eq [post3]
    end
    it "should return no post" do
      get :index, :search_by_title => "are", :search_by_zipcode => "100001"
      expect(assigns(:all_posts)).to eq []
    end
  end

  describe 'show' do
    let!(:post) { Post.create!(title: 'Hi', zipcode: '10463')}

    it 'should show the detail of the post' do
      get :show, id: post.id
      expect(assigns(:post)).to eql(post)
      expect(response).to render_template('show')
    end
  end

  describe 'new post' do
    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}
    it 'should display create new post page' do
      get :new, {}, {'user_id' => 1}
      expect(response).to render_template('new')
    end

    it 'ask unregistered users to login when they try to create new posts' do
      get :new, {}
      expect(flash[:notice]).to match(/Login to create new post/)
      expect(response).to redirect_to("/login")
    end
  end

  describe 'create' do
    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}

    it 'creates a new post and redirects to the index page' do
      orig_posts_count = Post.all.count
      request.session[:user_id] = 1
      post :create, :post => {:zipcode=>"10463", :title=>"AAA", :description=>"XXX", :rating=>3}
      expect(Post.all.count).to eq(orig_posts_count + 1)

      expect(response).to redirect_to(posts_url)
    end

    it 'create a new post with wrong zipcode' do
      orig_posts_count = Post.all.count
      request.session[:user_id] = 1
      post :create, :post => {:zipcode=>"123456", :title=>"AAA", :description=>"XXX", :rating=>3}
      expect(flash[:warning]).to match(/zipcode 123456 is not invalid!/)
      expect(response).to redirect_to("/posts/new")
    end
  
    it 'create a new post with wrong rating' do
      orig_posts_count = Post.all.count
      request.session[:user_id] = 1
      post :create, :post => {:zipcode=>"11101", :title=>"AAA", :description=>"XXX", :rating=>31}
      expect(flash[:warning]).to match(/rating 31 is not in 0-9!/)
      expect(response).to redirect_to("/posts/new")
    end

    it 'create a new post with string rating' do
      orig_posts_count = Post.all.count
      request.session[:user_id] = 1
      post :create, :post => {:zipcode=>"11101", :title=>"AAA", :description=>"XXX", :rating=>"zx"}
      expect(flash[:warning]).to match(/rating zx is not in 0-9!/)
      expect(response).to redirect_to("/posts/new")
    end


    it 'ask unregistered users to login when they try to create new posts' do
      request.session[:user_id] = 1
      post :create, :post => {:zipcode=>"", :title=>"", :description=>"XXX"}
      expect(flash[:notice]).to match(/Please enter all slots to continue!/)
      expect(response).to redirect_to("/posts/new")
    end
  end

  describe 'DELETE' do
    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}
    let!(:user2) { User.create!(user_name: 'bbc', first_name: 'Columbia', last_name: "Lime", password: "123")}

    let!(:post) { Post.create!(title: 'Hi', zipcode: '10463', creator_id: user.id)}
  
    it 'deletes a post and redirects to the home page and alert' do
      request.session[:user_id] = user.id
      orig_post_count = Post.all.count
      delete :destroy, id: post.id
      expect(Post.all.count).to eq(orig_post_count - 1)
  
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eq("post 'Hi' deleted.")
    end

    it 'only allow the creator to deletes a post' do
      request.session[:user_id] = user2.id
      delete :destroy, id: post.id
  
      expect(flash[:notice]).to match(/Only creator can delete the post/)
      expect(response).to redirect_to("/posts/#{post.id}")
    end
  end
  
  describe 'Edit' do

    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}
    let!(:user2) { User.create!(user_name: 'bbc', first_name: 'Columbia', last_name: "Lime", password: "123")}

    let!(:new_post) { Post.create!(title: 'Hi', zipcode: '10463', creator_id: user.id)}

    # before do
    #   request.session[:user_id] = user.id
    #   get :edit, id: new_post.id
    # end
  
    it 'should let creator edit a post and redirect' do
      request.session[:user_id] = user.id
      get :edit, id: new_post.id
      expect(assigns(:post)).to eql(new_post)
      expect(response).to render_template('edit')
    end

    it 'should reject edit from non-creator' do
      request.session[:user_id] = user2.id
      get :edit, id: new_post.id
      expect(flash[:notice]).to match(/Only creator can edit the post/)
      expect(response).to redirect_to("/posts/#{new_post.id}")
    end

  end
  
  describe 'Update' do
    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}
    let!(:post) { Post.create!(title: 'Hi', zipcode: '10463', creator_id: user.id)}
  
    it 'updates a post and redirects to the post page' do
      put :update, id: post.id, post: {:title=>"HiII"}
      post.reload
      expect(post.title).to eql('HiII')
  
      expect(response).to redirect_to(post_path(post))
      expect(flash[:notice]).to eq("HiII was successfully updated.")
    end
  end

  describe 'Review', type: [:request, :controller] do
    let!(:newpost) { Post.create!(title: 'Hi', zipcode: '10463')}

    it 'should display create new review page' do
      get "/posts/#{newpost.id}/review/add"
      expect(response).to render_template('new_review')
    end

    it 'Add review to the post' do
      post "/posts/#{newpost.id}/review/create",:id => newpost.id, :review => {:content=>"The first review"}
      reviews = (Post.find newpost.id).reviews
      expect(reviews.count).to eq(1)

      expect(response).to redirect_to(post_path(newpost))
    end

    it 'can not create empty review' do
      post "/posts/#{newpost.id}/review/create",:id => newpost.id, :review => {:content=>""}
      reviews = (Post.find newpost.id).reviews
      expect(reviews.count).to eq(0)
      expect(response).to redirect_to("/posts/#{newpost.id}/review/add")
      expect(flash[:notice]).to eq("Content can't be empty")
    end
  end
end