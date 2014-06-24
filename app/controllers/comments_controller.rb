class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: { comment: { id: @comment.id, post_id: @comment.post_id, user_id: @comment.user_id, text: @comment.text, created_at: @comment.created_at } }
    else
      render json: { errors: @comment.errors }, status: :unprocessible_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge({post_id: params[:post_id], user_id: current_user.id})
  end
end
