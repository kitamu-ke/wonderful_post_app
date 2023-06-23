class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_article, only: %i[ edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
    @articles = Article.page(params[:page]).per(50)
  end

  # GET /articles/1 or /articles/1.json
  def show
    # binding.pry
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
      @article = current_user.articles.new(article_params)

      if @article.save
        redirect_to @article, notice: "記事を作成しました"
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    # respond_to do |format|
      if @article.update(article_params)
        redirect_to @article, notice: "記事を編集しました"
      else
        render :edit, status: :unprocessable_entity
      end
    # end

    # @article = Article.find(params[:id])

    # @article.update!(article_params)

    # render :show
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    # binding.pry
    @article = Article.find(params[:id])
    @article.destroy
    # redirect_to articles_url, notice: "Article was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      # @article = current_user.articles.find(params[:id])
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
