class ArticlesController < ApplicationController

  before_action :find_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'Your article was successfully created.'
      redirect_to article_path(@article)
    else 
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Your article was successfully updated.'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:success] = 'Your article was successfully deleted.'
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def find_article
    @article = Article.find(params[:id])
  end

end