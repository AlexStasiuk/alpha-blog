class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
    @articles.each do |article|
      if article.theme.nil?
        article.theme = "Has no theme";
      end
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    #byebug # for debuging 
    @article = Article.find(params[:id])
    @myVar = params
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was successfully created." 
      redirect_to @article
    else
      render 'new'
    end
    
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] =  "Article was successfully updated." 
      redirect_to @article
    end
    
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "Article with id:#{@article.id} was successfully destroyed."
      redirect_to @article
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description, :theme)#takes from params -> article -> permited
    end
end
