class Post < ActiveRecord::Base
	validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent => :destroy, :counter_cache => true
	has_many :post_category_ships
	has_many :categories, :through => :post_category_ships
	has_many :user_post_favorite_ships
	has_many :users, :through => :user_post_favorite_ships


	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  # def author_is?(user)
		# return true if self.user == user
  # end

  scope :published, -> { where(status: 'Publish') }
  scope :by_user, -> (user){ where.not('status = ? and user_id is NOT ?', 'Draft', user.id) }

  def favorite_by?(user)
  	UserPostFavoriteShip.where(:user_id => user.id, :post_id => id).present?
  end
end
