class PostsController < ApplicationController
	before_action :set_post, :only => [ :show, :edit, :update, :destroy ]


  def index
  	@posts = Post.all
  end	

  def new
  	@post = Post.new
  end

  def create
	  @post = Post.new(post_params)
		if @post.save
			
	  	redirect_to @post
	  	flash[:notice] = "Post was successfully created"
		else
			flash[:alert] = "Title can not be blank"
			render :new
		end
  end
 
  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
    	flash[:notice] = "Post was successfully updated"
      redirect_to @post
    else
    	render :edit  
 		end
  end

  def destroy
  	@post.destroy
  	flash[:alert] = "Post was successfully deleted"
  	redirect_to :root
  end

  protected

  def set_post
  	@post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :content)
  end

end
