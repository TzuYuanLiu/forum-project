class CommentsController < ApplicationController
	
before_action :set_post

	def create
		@comment = @post.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	def edit
		unless @post.user == current_user
			flash[:alert] = "No-Access-Edit-Allow"
		else
			@comment = @post.comments.find(params[:id])
			
		end
	end	

	def update
		@comment = @post.comments.find(params[:id])

		if @comment.update(params[:comment].permit(:comment))
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	def destroy
		unless @post.user == current_user
			flash[:alert] = "No-Access-Delete-Allow"
      redirect_to post_path(@post)
		else
			@comment = @post.comments.find(params[:id])
			@comment.destroy
			

			if @post.comments.count > 1
        # 1要砍成0，但在此時暫存還是1 #這裡為何是這樣？
        @post.last_comment_time = Comment.order("updated_at").last.updated_at
      else
        @post.last_comment_time = nil
      end
      @post.save

      flash[:alert] = "Comment was successfully deleted"

      redirect_to post_path(@post)
		end
	end

	protected

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_param
    params.require(:comment).permit(:comment)
  end
end
