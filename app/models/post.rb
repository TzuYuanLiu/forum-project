class Post < ActiveRecord::Base
	validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent => :destroy, :counter_cache => true
	has_many :post_category_ships
	has_many :categories, :through => :post_category_ships
	has_many :user_post_favorite_ships
	has_many :users, :through => :user_post_favorite_ships
	has_many :user_post_likes
	has_many :liked_users, :through => :user_post_like, :source => :user
	has_many :post_tag_ships
	has_many :tags, :through => :post_tag_ships 


	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  # def author_is?(user)
		# return true if self.user == user
  # end

  scope :published, lambda {
  	Post.draft.by_user & Post.publish
	}

  scope :publish, -> { where(status: 'Publish') }
  scope :sign_in_post, -> (user){ where("user_id = ? or status = ?", user.id, "Publish")}

  def favorite_by?(user)
  	UserPostFavoriteShip.where(:user => user, :post_id => id).present?
  end

  def find_my_like(user)
    self.user_post_likes.where( :user => user ).first
  end
end
