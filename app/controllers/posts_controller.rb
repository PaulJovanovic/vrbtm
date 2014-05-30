class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

private
  def post_params
    params.require(:post).permit(:quote_id, :origin_user_id).merge({user_id: current_user.id})
  end
end
