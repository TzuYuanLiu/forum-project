class Admin::PostsController < ApplicationController
	before_action :authenticate_user!

	before_action :check_admin
    layout "admin"

    # def index
    #   @user = User.all
    #   @category = Category.all  
    # end

    # def edit_category
    #   @category = @category.all
    # end

    def index
      @category = Category.all
      @user = User.all
    end


    protected

    def check_admin
       unless current_user.role == "admin"
       	Raise ActiveRecord::RecordNotfound
       end
    end
end
