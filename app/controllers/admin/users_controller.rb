class Admin::UsersController < ApplicationController
	before_action :set_user

	def edit	
	end

	def update
		@user.update(user_params)
    flash[:notice] = "User profile was successfully updated"
    redirect_to admin_posts_path
	end

	private

 	def set_user
  	@user = User.find(params[:id])
  end

  def user_params
  	params.require(:user).permit(:role, :first_name, :last_name, :bio)
  end
end
