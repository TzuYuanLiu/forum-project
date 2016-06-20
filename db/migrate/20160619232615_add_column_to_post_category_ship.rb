class AddColumnToPostCategoryShip < ActiveRecord::Migration
  def change
  	add_column :post_category_ships, :post_id, :integer
  	add_column :post_category_ships, :category_id, :integer
  end
end
