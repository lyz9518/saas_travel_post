class Post < ActiveRecord::Base
    has_many :reviews, :dependent => :destroy
end
