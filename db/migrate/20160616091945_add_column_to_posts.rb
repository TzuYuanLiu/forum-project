class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :last_comment_time, :datetime
    add_column :posts, :most_comment, :integer
  end
end
