class MypageController < ApplicationController

  def index
    articles = current_user.articles.preload(:tags)
    articles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.page params[:page]
  end

end
