class Tag < ActiveRecord::Base
	has_many :post_tag_ships
	has_many :posts, :through => :post_tag_ships 
end
