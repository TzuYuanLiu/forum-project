class AddColumnToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :title, :string
  	add_column :posts, :content, :string
  	remove_column :posts, :name, :string	
  end
end
