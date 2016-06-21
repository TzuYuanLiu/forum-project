class Admin::PostsController < ApplicationController
	before_action :authenticate_user!

	before_action :check_admin
    layout "admin"

    # ....

    protected

    def check_admin
       unless current_user.admin?
       	Raise ActiveRecord::RecordNotfound
       else

       end
    end
end
