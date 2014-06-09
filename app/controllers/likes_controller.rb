class LikesController < ApplicationController

  def create
    like = Like.new(like_params)

    if like.save
      respond_to do |format|
        format.html redirect_to send("#{like_params[:likable_type].downcase}_path", like_params[:likable_id])
        format.json render json: { id: like.id }
      end
    else
      respond_to do |format|
        format.html redirect_to send("#{like_params[:likable_type].downcase}_path", like_params[:likable_id])
        format.json render json: { errors: like.errors }
      end
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
    params.require(:like).permit(:likable_type, :likable_id).merge({user_id: current_user.id})
  end
end
