class CreateUserPostFavoriteShips < ActiveRecord::Migration
  def change
    create_table :user_post_favorite_ships do |t|

    	t.integer :user_id
    	t.integer :post_id
      
      t.timestamps null: false
    end

  end
end
