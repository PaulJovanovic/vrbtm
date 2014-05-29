class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.joins(:quote).where("(quotes.citable_type = 'User' AND quotes.citable_id = ?) OR posts.user_id = ?", @user.id, @user.id).paginate(page: params[:page], per_page: 10).order("posts.created_at desc")
  end

  def search
    users = User.search_by_name(params[:name])
    render json: User.search_by_name(params[:name]).map{ |user| { id: user.id, name: user.name } }
  end
end
