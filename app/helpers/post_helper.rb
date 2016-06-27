module PostHelper
	def favorite_button(post)
		if user_signed_in?
			if post.favorite_by?(current_user)
				link_to 'not favorite', favorite_post_path(@post, :favorite => false)
			else
				link_to 'favorite', favorite_post_path(@post, :favorite => true)
			end
		end
	end
end
