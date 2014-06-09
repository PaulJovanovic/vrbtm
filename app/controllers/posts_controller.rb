class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

private
  def post_params
    params.require(:post).permit(:quote_id, :original_post_id).merge({user_id: current_user.id})
  end
end
