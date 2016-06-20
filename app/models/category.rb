class Category < ActiveRecord::Base
	has_many :posts, :through => :post_category_ship
	has_many :post_category_ship
end
