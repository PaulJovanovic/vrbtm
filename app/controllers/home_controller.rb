class HomeController < ApplicationController
  def index
    @posts = current_user.feed.paginate(page: params[:page], per_page: 10).order("created_at desc")
  end
end
