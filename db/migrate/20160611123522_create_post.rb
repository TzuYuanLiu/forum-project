class CreatePost < ActiveRecord::Migration
  def change
  	# create_table :posts do |t|
   #    t.string :title
   #    t.string :content

   #    t.timestamps null: false
   # add_column :posts, :title, :string
  	add_column :posts, :content, :string
    # end
  end
end
