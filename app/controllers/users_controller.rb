class UsersController < ApplicationController
  before_action :authorize_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
    @user.build_avatar if @user.avatar.nil?
    @user.build_cover_photo if @user.cover_photo.nil?
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.joins(:quote).where("(quotes.citable_type = 'User' AND quotes.citable_id = ?) OR posts.user_id = ?", @user.id, @user.id).paginate(page: params[:page], per_page: 10).order("posts.created_at desc")
  end

  def search
    users = User.search_by_name(params[:name])
    render json: User.search_by_name(params[:name]).map{ |user| { id: user.id, name: user.name, image: user.search_image, followers: "#{user.id} followers" } }
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.paginate(page: params[:page], per_page: 20).order("first_name, last_name")
  end

  def following
    @user = User.find(params[:id])
    @followings = @user.following.paginate(page: params[:page], per_page: 20).order("first_name, last_name")
  end

  private

  def user_params
    params.require(:user).permit(:favorite_quote, :favorite_quote_author, avatar_attributes: [:id, :attachment], cover_photo_attributes: [:id, :attachment])
  end

  def authorize_user
    unless current_user.id == params[:id].to_i
      redirect_to user_path(params[:id])
    end
  end
end
