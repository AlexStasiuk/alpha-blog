class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
    @articles.each do |article|
      if article.theme.nil?
        article.theme = "Has no theme";
      end
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    #byebug # for debuging 
    @myVar = params
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
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was successfully created." 
      redirect_to @article
    else
      render 'new'
    end
    
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated." 
      redirect_to @article
    else
      redirect_to edit_article_path(@article)
    end
    
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    if @article.destroy
      flash[:notice] = "Article with id:#{@article.id} was successfully destroyed."
      redirect_to @article
    end
  end
  
  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
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
