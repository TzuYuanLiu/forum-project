class ApiV1::PostsController < ApiController

	# GET /api/v1/posts
   def index
     @posts = Post.all
 
     # index.json.jbuilder
   end
end
