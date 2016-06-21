class Post < ActiveRecord::Base
	validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent => :destroy, :counter_cache => true
	has_many :categories, :through => :post_category_ships
	has_many :post_category_ships

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
end
