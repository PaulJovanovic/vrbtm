class LikesController < ApplicationController

  def create
    like = Like.new(like_params.merge({user_id: current_user.id}))

    if like.save
      render json: { id: like.id }
    else
      render json: { errors: like.errors }
    end
  end

  def destroy
    like = Like.where(like_params.merge({user_id: current_user.id})).last

    if like.destroy
      render json: { id: like.id }
    else
      render json: { errors: like.errors }
    end
  end

  private

  def like_params
    params.require(:like).permit(:likable_type, :likable_id)
  end
end
