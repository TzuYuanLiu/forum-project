class RemoveColumnToPost < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.remove :posts, :body, :string
		end
  end
end
