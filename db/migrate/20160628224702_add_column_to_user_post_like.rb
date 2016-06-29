class AddColumnToUserPostLike < ActiveRecord::Migration
  def change
  	add_column :user_post_likes, :user_id, :integer
  	add_column :user_post_likes, :post_id, :integer 

  end
end
