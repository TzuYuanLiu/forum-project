class Admin::CategoriesController < ApplicationController
before_action :set_category, :only => [ :edit, :update, :destroy ]
	
	def index
		@category = Category.all
	end

	def edit	
	end

	def new
		@category = Category.new
	end

	def update
		if @category.update(category_params)
    	flash[:notice] = "Post was successfully updated"
      redirect_to admin_posts_path
    else
    	render :edit  
 		end
	end

	def create	
		 @category = Category.new(category_params)
		if @category.save
    	flash[:notice] = "Post was successfully updated"
      redirect_to admin_posts_path
    else
    	render :new 
    end	
	end

	def show
		@category = Category.new
	end

	def destroy
		flash[:alert] = "Post was successfully deleted"
    @category.destroy
    redirect_to admin_posts_path
	end

	private

 	def set_category
  	@category = Category.find(params[:id])
  end

  def category_params
  	params.require(:category).permit(:name)
  end

end
