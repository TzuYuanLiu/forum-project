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

    # favorites = UserPostFavoriteShip.where( :user => current_user )

    # @favorite_posts = Post.includes(:users).where(users: { id: current_user.id })

    @favorite_posts = current_user.favorite_posts
    @like_posts = current_user.like_posts
    # @favorites = []
    # favorite_posts.each do |f|
    #   @favorites << Post.find(f.post_id)
    # end
  end

  def about
    @posts = Post.all
  end

  def index
    @q = Post.ransack(params[:q])
    if params[:q]
      @posts = @q.result(distinct: true).published
    else
      @posts = Post.publish
    end

    # if user_signed_in?
    #   if params[:category_id]
    #     category = Category.find(params[:category_id])
    #     @posts = category.posts.by_user(current_user)
    #   else
    #     @posts = Post.by_user(current_user)
    #   end
    # else
    #   if params[:category_id]
    #     category = Category.find(params[:category_id]) 
    #     @posts = category.posts.published
    #   else
    #     @posts = Post.published
    #   end
    # end

    # if params[:category_id]
    #   category = Category.find(params[:category_id])
    #   if user_signed_in?
    #     @posts = category.posts.by_user(current_user)
    #   else
    #     @posts = category.posts.published
    #   end
    # else
    #   if user_signed_in?
    #     @posts = Post.by_user(current_user)
    #   else
    #     @posts = Post.published
    #   end
    # end

    # @posts = params[:category_id].present? ? Category.find(params[:category_id]).posts : Post.all
    # 上下等價
    if params[:category_id].present?
      @posts = Category.find(params[:category_id]).posts
    else
      @posts = Post.all
    end

    @posts = user_signed_in? ? @posts.by_user(current_user) : @posts.publish

    # 如果要改良 ransack 應該會發生在這邊

    @posts = @posts.order(params[:order] + ' desc') if params[:order].present?
      # case params[:order]
      # when 'comments_count desc'
      #   @posts.order('comments_count desc')
      # when 'last_comment_time desc'
      #   @posts.order('last_comment_time desc')
      # when 'views_count desc'
      #   @posts.order('views_count desc')
      # end

    # if params[:category_id]

    #   category = Category.find(params[:category_id]) 
    #   @posts = category.posts.published 
    #   @posts = @posts.order("title desc")
    # elsif params[:order] == "comments_count desc"
    #   @posts = @posts.order("comments_count desc")
    # elsif params[:order] == "last_comment_time"
    #   @posts = @posts.order("last_comment_time desc")
    # elsif params[:order] == "views_count"
    #   @posts = @posts.order("views_count desc")  
    # else
    #   if user_signed_in?
    #     @posts = Post.by_user(current_user)
    #   else
    #     @posts = Post.published
    #   end
    # end  

    @posts = @posts.page(params[:page]).per(4)

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

    # @is_favorite = UserPostFavoriteShip.where(:user_id => current_user.id, :post_id => @post.id).count == 0 ? false : true
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
