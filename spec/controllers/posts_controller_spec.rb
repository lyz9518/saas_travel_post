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
  end

  describe 'show' do
    let!(:post) { Post.create!(title: 'Hi', zipcode: '10463')}

    it 'should show the detail of the post' do
      get :show, id: post.id
      expect(assigns(:post)).to eql(post)
      expect(response).to render_template('show')
    end
  end

  describe 'create' do
    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}

    it 'creates a new post and redirects to the index page' do
      orig_posts_count = Post.all.count
      request.session[:user_id] = 1
      post :create, :post => {:zipcode=>"10463", :title=>"AAA", :description=>"XXX"}
      expect(Post.all.count).to eq(orig_posts_count + 1)

      expect(response).to redirect_to(posts_url)
    end
  end

  describe 'DELETE' do
    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}
    let!(:post) { Post.create!(title: 'Hi', zipcode: '10463', creator_id: "")}
  
    it 'deletes a post and redirects to the home page and alert' do
      orig_post_count = Post.all.count
      delete :destroy, id: post.id
      expect(Post.all.count).to eq(orig_post_count - 1)
  
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eq("post 'Hi' deleted.")
    end
  end
  
  describe 'Edit' do

    let!(:user) { User.create!(user_name: 'abc', first_name: 'Columbia', last_name: "Lion", password: "123")}
    let!(:new_post) { Post.create!(title: 'Hi', zipcode: '10463', creator_id: "")}

    before do
      get :edit, id: new_post.id
    end
  
    it 'should edit a post and redirect' do
      expect(assigns(:post)).to eql(new_post)
      expect(response).to render_template('edit')
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
end