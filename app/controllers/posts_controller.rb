class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def create
    post = Post.new(post_params)
    if params[:post][:photo_attributes].present?
      post.photo = Photo.from_attributes(JSON.parse(params[:post][:photo_attributes]))
    end

    if post.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])

    if current_user.id == @post.user_id && @post.destroy
      render json: {}
    else
      render json: { errors: @post.errors }, status: :unprocessible_entity
    end
  end

private
  def post_params
    params.require(:post).permit(:quote_id, :original_post_id, { tag_ids: [] }).merge({user_id: current_user.id})
  end
end
