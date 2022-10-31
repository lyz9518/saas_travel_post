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
      post :create, :post => {:zipcode=>"10463", :title=>"AAA", :username=>"XXX"}
      expect(Post.all.count).to eq(orig_posts_count + 1)

      expect(response).to redirect_to(posts_url)
    end
  end
  #
  # describe 'DELETE' do
  #   let!(:movie) { Movie.create!(title: 'Transformer', director: 'Zijian Zhang') }
  #
  #   it 'deletes a movie and redirects to the home page and alert' do
  #     orig_movies_count = Movie.all.count
  #     delete :destroy, id: movie.id
  #     expect(Movie.all.count).to eq(orig_movies_count - 1)
  #
  #     expect(response).to redirect_to(movies_path)
  #     expect(flash[:notice]).to eq("Movie 'Transformer' deleted.")
  #   end
  # end
  #
  # describe 'Edit' do
  #   let!(:movie) { Movie.create!(title: 'Transformer', director: 'Zijian Zhang') }
  #
  #   before do
  #     get :edit, id: movie.id
  #   end
  #
  #   it 'should edit a movie and redirect' do
  #     expect(assigns(:movie)).to eql(movie)
  #     expect(response).to render_template('edit')
  #   end
  # end
  #
  # describe 'Update' do
  #   let!(:movie) { Movie.create!(title: 'Transformer', director: 'Zijian Zhang') }
  #
  #   it 'updates a movie and redirects to the movie page' do
  #     put :update, id: movie.id, movie: {:title=>"TransformerII"}
  #     movie.reload
  #     expect(movie.title).to eql('TransformerII')
  #
  #     expect(response).to redirect_to(movie_path(movie))
  #     expect(flash[:notice]).to eq("TransformerII was successfully updated.")
  #   end
  # end
end