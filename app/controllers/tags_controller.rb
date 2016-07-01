class TagsController < ApplicationController
	before_action :set_post
	before_action :authenticate_user!

	def create
		@tag = Tag.build
		@tag.save
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy
	end

private

	def set_post
		@post = Post.find(params[:id])
	end

	def tag_params
		params.require(:tag).permit(:tag)
	end
 
end
