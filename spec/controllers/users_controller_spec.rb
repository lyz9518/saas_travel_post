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

describe UsersController do
  describe 'Sign In' do
    it 'should display create new user page' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'User' do
    it 'create new user' do
      user_info = {:user => {:user_name => "fakeuser", :password => "mypassword"}}
      fake_user = double({:id => 0})
      expect(User).to receive(:create).with(user_info[:user]).and_return(fake_user)
      get :create, user_info
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/New User Created/)
      expect(session[:user_id]).to eq(0)
    end 

    it 'can not create new user without username' do
      user_info = {:user => {:user_name => "", :password => "mypassword"}}
      post :create, user_info
      expect(flash[:notice]).to match(/User Name can't be empty/)
      expect(response).to redirect_to("/users/new")
    end 

    it 'can not create new user without password' do
      user_info = {:user => {:user_name => "fakeuser", :password => ""}}
      post :create, user_info
      expect(flash[:notice]).to match(/Password can't be empty/)
      expect(response).to redirect_to("/users/new")
    end 
  end
end