class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :zipcode
      t.string :title
      t.string :creator_id
      t.text :description
      t.date :date
    end

    create_table :users do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.string :password
    end
  end
end
