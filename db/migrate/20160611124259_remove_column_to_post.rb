class RemoveColumnToPost < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.remove :post, :body
		end
  end
end
