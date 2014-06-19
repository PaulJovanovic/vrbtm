class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:privacy]
  def index
    @posts = current_user.feed.includes(:quote).paginate(page: params[:page], per_page: 10).order("created_at desc")
    @trending_sources = Source.joins(:posts).where("posts.created_at > ?", 1.day.ago).group(:citable_id, :name).order('count_id desc').limit(5).count('id')
  end
end
