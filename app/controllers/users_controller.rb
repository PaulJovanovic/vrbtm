class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def search
    users = User.search_by_name(params[:name])
    render json: User.search_by_name(params[:name]).map{ |user| { id: user.id, name: user.name } }
  end
end
