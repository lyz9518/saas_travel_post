class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.references 'post'
      t.timestamps null: false
    end
  end
end
