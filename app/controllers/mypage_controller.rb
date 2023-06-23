class MypageController < ApplicationController

  def index
    @articles = current_user.articles
    @articles = Article.page(params[:page]).per(10)
  end

end
