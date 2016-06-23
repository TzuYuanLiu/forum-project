class Admin::PostsController < ApplicationController
	before_action :authenticate_user!

	before_action :check_admin
    layout "admin"

    def index
      @category = Category.all  
    end

    def edit_category
      @category = @category.all
    end

    protected

    def check_admin
       unless current_user.role == "admin"
       	Raise ActiveRecord::RecordNotfound
       end
    end
end
