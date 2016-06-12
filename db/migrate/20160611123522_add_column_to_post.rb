class AddColumnToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :title, :string
  	add_column :posts, :content, :text

  	change_table :posts do |t|
  		t.remove :post, :name
		end
  end
end
