class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:privacy]
  def index
    @posts = current_user.feed.includes(:quote).paginate(page: params[:page], per_page: 15).order("created_at desc")
    @trending_sources = Source.joins(:posts).where("posts.created_at > ?", 1.day.ago).group(:citable_id, :name).order('count_id desc').limit(5).count('id')
    @suggested_users = User.where('id not in (?)', current_user.relationships.map(&:followed_id).push(current_user.id)).order("posts_count DESC").limit(5)
  end
end
