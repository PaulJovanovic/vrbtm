class HomeController < ApplicationController
  def index
    @posts = current_user.feed
  end
end