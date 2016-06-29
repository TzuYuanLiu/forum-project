class CreateUserPostLikes < ActiveRecord::Migration
  def change
    create_table :user_post_likes do |t|
    

      t.timestamps null: false
    end
  end
end
