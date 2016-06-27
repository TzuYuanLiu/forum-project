class PostsController < ApplicationController
	before_action :set_post, :only => [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, :except => [:index, :show]

  def favorite
    if params[:favorite] == "true"
      UserPostFavoriteShip.create(:user_id => current_user.id, :post_id => params[:id])
    else
      UserPostFavoriteShip.find_by(:user_id => current_user.id, :post_id => params[:id]).destroy
    end
    redirect_to post_path(params[:id])
  end

  def profile
    @posts = current_user.posts
  end

  def about
    @posts = Post.all
  end


  def index
    @posts = Post.all
    @q = Post.ransack(params[:q])
    if params[:q]
      @posts = @q.result(distinct: true).where(status: "draft")
    else
      # @posts = Post.where(status: "draft")
    end

    if params[:category_id]
      category = Category.find(params[:category_id]) 
      @posts = category.posts.where(status: "draft").order("id desc")
    elsif params[:order] == "title"
      @posts = @posts.order("title asc")
    elsif params[:order] == "comments_count"
      @posts = @posts.order("comments_count desc")
    elsif params[:order] == "last_comment_time"
      @posts = @posts.order("last_comment_time desc")
    elsif params[:order] == "views_count"
      @posts = @posts.order("views_count desc")  
    end  

    @posts = @posts.page( params[:page]).per(4)

  end	

  def new
    @post = Post.new
  end

  def create
	  @post = current_user.posts.build(post_params)
		if @post.save
			
	  	redirect_to @post
	  	flash[:notice] = "Post was successfully created"
		else
			flash[:alert] = "Title can not be blank"
			render :new
		end
  end
 
  def show
    @comment = Comment.new
    @post.views_count = @post.views_count + 1
    @post.save

    @is_favorite = UserPostFavoriteShip.where(:user_id => current_user.id, :post_id => @post.id).count == 0 ? false : true
    # TODO 1 views_count
    # Add a new column(e.g. views_count) to posts table
    # Plus one whenver one enter show action 
    # Will refactor and use session or cookie
  end

  def edit
    unless @post.user == current_user
      flash[:alert] = "No-Access-Edit-Allow"
      redirect_to :root
    end
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
    unless @post.user == current_user || current_user.role == "admin"
      byebug
      flash[:alert] = "No-Access-Delete-Allow" 
      redirect_to :root
    else
      flash[:notice] = "Post was successfully deleted"
      @post.destroy
      redirect_to :root
    end  
  end

  protected

  def set_post
  	@post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :content, :logo, :role, :status, :category_ids => [])
  end

end
