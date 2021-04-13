class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:edit, :update, :show]
  def new
      @category = Category.new
  end

  def create
      @category = Category.new(category_params)
      if @category.save
          flash[:notice] = "Category was successfully created"
          redirect_to @category
      else
          render 'new'
      end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    
    @articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end
  
  def edit
    
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Successfully updated category"
    else
      flash[:alarm] = "Something went wrong while updating category"
    end
    redirect_to @category
  end
  private
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    
    if !(logged_in? && current_user.admin?)
      flash[:alarm] = "Only admin can create new category"
      redirect_to categories_path
    end
  end
end 