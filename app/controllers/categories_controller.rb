class CategoriesController < ApplicationController

  before_action :find_category, only: [:edit, :update, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'The category was created successfully.'
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category name was successfully updated.'
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 10)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !logged_in? || !admin?
      flash[:danger] = 'Only admin can create, edit or delete a category.'
      redirect_to categories_path
    end
  end

end