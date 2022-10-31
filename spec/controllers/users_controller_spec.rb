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
  describe 'User' do
    it 'create new user' do
      user_info = {:user => {:user_name => "fakeuser", :password => "mypassword"}}
      fake_user = double({:id => 0})
      expect(User).to receive(:create).with(user_info[:user]).and_return(fake_user)
      get :create, user_info
      expect(response).to redirect_to(posts_path)
    end 
  end
end