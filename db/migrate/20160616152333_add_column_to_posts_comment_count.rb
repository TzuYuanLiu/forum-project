class AddColumnToPostsCommentCount < ActiveRecord::Migration
  def change
  	add_column :posts, :comments_count, :integer, :default => 0
  	add_column :posts, :status, :string, :default => "draft"
  	add_column :posts, :clicked, :datetime, :default => 0

  end
end
